function res = getCenterMassList(difFrame)
level=graythresh(difFrame);
% level = 0.5;
BW=im2bw(difFrame,level);
STATS=regionprops(BW,'Centroid');
res = cat(1,STATS.Centroid);
end