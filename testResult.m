function faceornot = testResult(cascade,feature)
% detect face in 64*64

% Input
% cascade: multi-stage boosted classifier
% feature: feature value
% Output
% faceornot: 1/-1

totLen = length(cascade);
for stage = 1:totLen
    h = cascade(stage);
    if h.T~=1
        sumResult = 0;
        for t = 1:h.T
            Idx = h.featureIdx(t);
            fea = feature(feature(:,2)==Idx,1);
            ht = sign(h.p(t)*(h.theta(t)-fea));
            sumResult = sumResult + h.alpha(t)*ht;
        end
        if sumResult-h.modifytheta<0
            faceornot = -1;
            return;
        end
        faceornot = 1;
    else
        Idx = h.featureIdx(1);
        fea = feature(feature(:,2)==Idx,1);
        ht = sign(h.p(1)*(h.theta(1)-fea));
        if ht<1
            faceornot = -1;
            return;
        end
        faceornot = 1;
    end
end
end