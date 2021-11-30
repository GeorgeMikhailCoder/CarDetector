function [resMeans, resObjectPoints] = groupCenters2(centers, R)
if (nargin==0)
centers =[
  278.1447  164.3816;
  290.7111  155.0667;
  683.0000  719.0000;
  691.7460  675.7302;
  691.1875  701.0625;
  704.5000  304.7143;
  732.8889  597.8889
  ];
R=20;

% centers = [
%     1,1;
%     3,3;
%     6,4;
%     7,3;
%     8,5
%     ];
% R = 3;

end

if (size(centers,1)==0)
    resMeans = [];
    resObjectPoints = [];
else 
if (size(centers,1)==1)
    resMeans = centers;
    resObjectPoints = {centers};
else
% a = [1,2,3,5,7,11,13,14,17,18];
% a =[
%   744  305;
%   737  348;
%   741  329;
%   749  329;
% ];
% R = 10;

resObj = [];
resM = [];
object = [centers(1,:)];
prev = centers(1,:);


groupNum = zeros(length(centers),1);

k = 1;
for i=1:length(centers)
   if (groupNum(i)==0)
       groupNum(i) = k;
       k=k+1;
   end
      
   for j=i+1:length(centers)
       if (groupNum(j)~=0)
           continue
       end
       
      a = centers(i);
      b = centers(j);
      if (sum((a - b).^2)<R^2)
          groupNum(j) = groupNum(i);
      end
   end
end

resObj =cell(max(groupNum),1);
resM = zeros(length(resObj), 2);
for i=1:length(resObj)
    obj = centers(groupNum==i,:);
    resObj{i} = obj;
    resM(i,1) = mean(obj(:,1));
    resM(i,2) = mean(obj(:,2));
end

resMeans = resM;
resObjectPoints = resObj;
end

end
end





