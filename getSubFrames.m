function [subFrame, subPrev] = getSubFrames(frame, prevFrame, vpx)

[h, w, ~] = size(frame);

if (h == vpx)
    printf("Error: vpx is too large, cann't get subframes")
end
rect1 = [1, 1 + vpx, w, h-1       ];
rect2 = [1, 1,       w, h-1 - vpx ];
subFrame = imcrop(frame, rect1);
subPrev = imcrop(prevFrame, rect2);

end

