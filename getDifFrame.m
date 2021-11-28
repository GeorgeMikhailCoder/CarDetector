function res = getDifFrame(frame, prevFrame, vpx)
[subFrame, subPrev] = getSubFrames(frame, prevFrame, vpx);   
difFrame = subFrame - subPrev;
porog = 100;
difFrame(difFrame>porog) = 255;
difFrame(difFrame<porog) = 0;
S = strel('square',3);
difFrame = imerode(difFrame,S);
res = difFrame;
end