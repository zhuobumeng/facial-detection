function imgres = drawBorder(img,i,j)
imgres = img;
imgres(i:i+63,j) = 255;
imgres(i:i+63,j+63) = 255;
imgres(i,j:j+63) = 255;
imgres(i+63,j:j+63) = 255;
end