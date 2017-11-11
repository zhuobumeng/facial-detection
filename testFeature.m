function feature = testFeature(img,row,col,location)
% compute feature in test image
%
% input
% img: image
% row, col: size=64*64
% i,j,w,h,dir: location of each feature
%
% output
% features: vector

intImg = zeros(row+1,col+1);
intImg(2:row+1,2:col+1) = cumsum(cumsum(img),2);
len = size(location,1);
feature = zeros(len,1);
for cnt = 1:len
    i = location(cnt,1);
    j = location(cnt,2);
    w = location(cnt,3);
    h = location(cnt,4);
    dir = location(cnt,5);
    if dir==1
        rect1=[i,j,w,h];
        rect2=[i,j+w,w,h];
        feature(cnt) = sumRect(intImg, rect2)- sumRect(intImg, rect1);
    else
        rect1=[i,j,w,h];
        rect2=[i+h,j,w,h];
        feature(cnt) = sumRect(intImg, rect1)- sumRect(intImg, rect2);
    end
end
end