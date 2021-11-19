function res = getCenterMassList(difFrame)
level=graythresh(difFrame);
BW=im2bw(difFrame,level);
STATS=regionprops(BW,'Centroid');
res = cat(1,STATS.Centroid);
end