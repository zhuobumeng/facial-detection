%% load images
function imgs = loadImagesAdaBoost(filePath, row, col,Ntrain)
% get images in 'filePath'
files = dir([filePath '*.jpg']);
% imgs = zeros(row,col,length(files));
imgs = zeros(row,col,Ntrain);

for i = 1: Ntrain %length(files)
    % files(i)
    img = imread([filePath files(i).name]);
    imgGray = double(rgb2gray(img));
    imgs(:,:,i) = imgGray;
end
end
