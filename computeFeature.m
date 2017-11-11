%% compute Haar features
function feature = computeFeature(I, row, col,step)
feature = zeros(6324,1);

%extract horizontal feature
cnt = 1;
window_h = 1; window_w=2; %window size 
for h = 10:2:row/window_h %extend the size of one rectangular
    for w = 10:2:col/window_w
        for i = 1:step:row+1-h*window_h %slide 
            for j = 1:step:col+1-w*window_w
                rect1=[i,j,w,h];
                rect2=[i,j+w,w,h];
                feature(cnt)=sumRect(I, rect2)- sumRect(I, rect1);
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
                rect1=[i,j,w,h];
                rect2=[i+h,j,w,h];
                feature(cnt)=sumRect(I, rect1)- sumRect(I, rect2);
                cnt=cnt+1;
            end
        end
    end
end
end