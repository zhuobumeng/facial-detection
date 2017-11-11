function loca = findFeature(row,col,step)
% find location of features
loca = zeros(6324,5);
%extract horizontal feature
cnt = 1;
window_h = 1; window_w=2; %window size 
for h = 10:2:row/window_h %extend the size of one rectangular
    for w = 10:2:col/window_w
        for i = 1:step:row+1-h*window_h %slide 
            for j = 1:step:col+1-w*window_w
                loca(cnt,:) = [i,j,w,h,1];
                cnt=cnt+1;
            end
        end
    end
end

window_h = 2; window_w=1; %window size 
for h = 10:2:row/window_h
    for w = 10:2:col/window_w
        for i = 1:step:row+1-h*window_h
            for j = 1:step:col+1-w*window_w
                loca(cnt,:) = [i,j,w,h,2];
                cnt=cnt+1;
            end
        end
    end
end
end