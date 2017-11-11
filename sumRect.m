%%
function [rectsum] = sumRect(I, rect_four) 
% given four corner points in the integral image 
% calculate the sum of pixels inside the rectangular. 
row_start = rect_four(1); 
col_start = rect_four(2); 
width = rect_four(3);
height = rect_four(4); 
one = I(row_start, col_start); 
two = I(row_start, col_start+width); 
three = I(row_start+height, col_start); 
four = I(row_start+height, col_start+width); 
rectsum = four + one -(two + three);
end