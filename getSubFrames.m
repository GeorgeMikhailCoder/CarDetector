function [subFrame, subPrev] = getSubFrames(frame, prevFrame, vpx)
% функци€ выравнивает кадры. “екущий кадр сдвинут относительно предыдущего.
% ‘ункци€, зна€ скорость сдвига в пиксел€х, обрезает текущий и предыдущий
% кадры, оставл€€ только повтор€ющиес€ пиксели


[h, w, ~] = size(frame);

if (h == vpx)
    printf("Error: vpx is too large, cann't get subframes")
end
rect1 = [1, 1 + vpx, w, h-1       ];
rect2 = [1, 1,       w, h-1 - vpx ];
subFrame = imcrop(frame, rect1);
subPrev = imcrop(prevFrame, rect2);

end

