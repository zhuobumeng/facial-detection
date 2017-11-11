% Harr-like feature extraction for one image
% 
% Input
% filepath: string, the name of the directory containing the faces/ and background/
% directories
% row, col: integers, dimensions of the training images 
% Npos: int, number of face images 
% Nneg: int, number of background images
% 
% Output
% features: ndarray, extracted Haar features

function [ features, Npos, Nneg ] = getHaar(filePath,Ntrain)
row = 64; col = 64;  % 64x64 pixel images
posFilePath = [filePath 'faces/' ];
negFilePath = [filePath 'background/'];
posImg = loadImagesAdaBoost(posFilePath, row, col, Ntrain);
negImg = loadImagesAdaBoost(negFilePath, row, col, Ntrain);

% get total number of images
Nimg = size(posImg,3) + size(negImg,3);
Npos = size(posImg,3);
Nneg = size(negImg,3);
% Nfeatures = 295937;
% features = zeros(Nfeatures, Nimg);
features = zeros(6324,Nimg);
for i = 1:Nimg
    if i <= size(posImg,3)
        % convert to integral image
        intImg = zeros(row+1,col+1);
        intImg(2:row+1,2:col+1) = cumsum(cumsum(posImg(:,:,i)),2);
        % compute features
        features(:,i) = computeFeature(intImg,row,col,10);
    else
        % convert to integral image
        intImg = zeros(row+1,col+1);
        intImg(2:row+1,2:col+1) = cumsum(cumsum(negImg(:,:,i-Npos)),2);
        % compute features
        features(:,i) = computeFeature(intImg,row, col,10);
    end
end

featureLocation = findFeature(row,col,10);
features_adaboost.features = features;
features_adaboost.Npos = Npos;
features_adaboost.Nneg = Nneg;
features_adaboost.location = featureLocation;
%save ('features_adaboost_test.mat','features_adaboost','-mat','-v7.3');
save('features_adaboost_train.mat', 'features_adaboost');

end