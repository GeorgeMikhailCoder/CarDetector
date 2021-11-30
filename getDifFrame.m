function res = getDifFrame(frame, prevFrame, vpx)
[subFrame, subPrev] = getSubFrames(frame, prevFrame, vpx);   
difFrame = subFrame - subPrev;
porog = 50;
difFrame(difFrame>porog) = 255;
difFrame(difFrame<porog) = 0;
S = strel('square',2);
difFrame = imerode(difFrame,S);
difFrame = imerode(difFrame,S);
res = difFrame;
end