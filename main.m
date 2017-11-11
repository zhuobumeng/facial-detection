% Main
filePath = '/Users/apple/Desktop/377 Machine Learning/HW 4/';
Ntrain = 1000;
features = features_adaboost.features;
Npos = 1000;
Nneg = 1000;

% label = [ones(Npos,1);zeros(Nneg,1)];
label = [ones(Npos,1);-ones(Nneg,1)];
posIdx = [ones(Npos,1);zeros(Nneg,1)];
negIdx = [zeros(Npos,1);ones(Nneg,1)];
featuress = features;
rec = [];
for runTime = 1:12
h = boostClassifier(featuress,label,Npos,Nneg,0.4);
% pos + false pos -> next stage
Nneg = (h.result==1)'*negIdx;
negIdx = [zeros(Npos,1);ones(Nneg,1)];
label = label(h.result==1);
featuress = featuress(:,h.result==1);
rec = [rec,h];
if Nneg==0
    break;
end
end

totalFeature = [];
for j = 1:length(rec)
    totalFeature = [totalFeature;rec(j).featureIdx'];
end
total.Idx = sort(unique(totalFeature));
total.Location = features_adaboost.location(total.Idx,:); 


workTest = zeros(2000,1);
for i=1:2000
workTest(i) = testResult(rec,[features(:,i),(1:6324)']);
end



testImg = imread('/Users/apple/Desktop/377 Machine Learning/HW 4/test_image.jpg');
testImg = double(testImg);
origImg = testImg;
[rowTest,colTest] = size(testImg);
step = 8;
% move subwindows
cnt = 0;
for windowsi = 1:step:rowTest-63 % 200:step:780
    for windowsj = 1:step:colTest-63 % 120:step:colTest-64+1
        subImg = testImg(windowsi:windowsi+64-1,windowsj:windowsj+64-1);
        featuret = [testFeature(subImg,64,64,total.Location),total.Idx];
        if testResult(rec,featuret)==1
            testImg = drawBorder(testImg,windowsi,windowsj);
            cnt = cnt + 1;
        end
    end
end
result.img = testImg;
result.cnt = cnt;
save('result.mat','result');



% save feature location
% employment on test image
% each 64*64 subwindown image
% according to feature loc to compute feature
% then apply cascade to classify
% draw border around subwindow if pos