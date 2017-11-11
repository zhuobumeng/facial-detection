function h = boostClassifier(features,label,Npos,Nneg,error)
% boost linear classifier
%
% Input
% features: contains the features
% label: vector of labels. 0/1 for neg/pos
% Npos, Nneg: number of pos/neg images
% T: number of chosen classifiers
%
% Output
% h: summation result & modification theta

% weight = [repmat(1/(2*Npos),Npos,1);repmat(1/(2*Nneg),Nneg,1)];
weight = ones(Npos+Nneg,1);
h.p = [];
h.theta = [];
h.alpha = [];
h.featureIdx = [];
sumResult = zeros(Npos+Nneg,1);
T = 1;
while (1)
    weight = weight/sum(weight);
    ht = getWeakClassifier(features,weight,label,Npos);
    epst = ht.currentMin;
    alphat = 1/2*log((1-epst)/epst);
    weight = weight.* exp(-alphat*(ht.bestResult.*label));
    
    % save values
    h.p(T) = ht.p;
    h.theta(T) = ht.theta;
    h.alpha(T) = alphat;
    h.featureIdx(T) = ht.featureIdx;
    
    % modify boost to reduce false negative rate
    sumResult = sumResult + ht.bestResult*alphat;
    
%     modify = min(sumResult(label==1));% positive while predicted negative
%     if modify<0
%         h.modifytheta = modify; % h-theta>0 then pos
%     else
%         h.modifytheta = 0;
%     end
    h.result = double(sumResult>=0);
    h.result(h.result==0) = -1;
    errorRate = sum(label==-1 & h.result==1)/sum(label==-1);
    if errorRate<error % false pos rate 
        break;
    end
    T = T+1;
end
h.T = T;
h.errorRate = errorRate;
end