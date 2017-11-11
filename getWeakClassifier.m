function h = getWeakClassifier(features, weight, label, Npos)
% Select best weak classifier for one feature over all images
% 
% Input 
% features:  contains the features 
% weight: vector of weights
% label:  vector of labels. O/1 for negative/positive
% Npos: number of face images 

% define parameters

label(label==-1) = 0;
Nfeatures = size(features,1);
Nimgs = size(features,2);
h.currentMin = inf;
tPos = repmat(sum(weight(1:Npos,1)), Nimgs,1);
tNeg = repmat(sum(weight(Npos+1:Nimgs,1)), Nimgs,1);

% search each feature as a classifier
for i = 1: Nfeatures

    % get one feature for all images
    oneFeature = features(i,:);
    
    % sort feature to thresh for postive and negative
    [sortedFeature, sortedIdx] = sort(oneFeature,'ascend');
    % sort weights and labels
    sortedWeight = weight(sortedIdx);
    sortedLabel = label(sortedIdx);

    % select threshold
    sPos = cumsum(sortedWeight .* sortedLabel);
    sNeg = cumsum(sortedWeight)- sPos;
    errPos = sPos + (tNeg -sNeg); % right (large) is pos, p=1, p(f-theta)<0
    errNeg = sNeg + (tPos -sPos); % left (small) is pos
    
    % choose the threshold with small error
    allErrMin = min(errPos, errNeg);
    [errMin, idxMin] = min(allErrMin);
    % result
    result = zeros(Nimgs,1);
    
    if errPos(idxMin) <= errNeg(idxMin)
        p = -1;
        result(idxMin+1:end) = 1;
        result(sortedIdx) = result;
    else
        p = 1;
        result(1:idxMin) = 1;
        result(sortedIdx) = result;
    end
    % get best parameters
    if errMin < h.currentMin 
        h.currentMin = errMin;
        if idxMin==1
            h.theta = sortedFeature(1) - 0.5;
        elseif idxMin==Nimgs; % idxMin? Nimg
            h.theta = sortedFeature(Nimgs) + 0.5;
        else
            h.theta = (sortedFeature(idxMin)+sortedFeature(idxMin - 1))/2;
        end
        h.p = p;
        h.featureIdx = i;
        result(result==0) = -1;
        h.bestResult = result;
    end
end % end of search each feature
end