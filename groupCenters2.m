function [resMeans, resObjectPoints] = groupCenters2(centers, R)
if (nargin==0)
%     centers = [
%   329.0000  257.0000;
%   347.6122  239.0680;
%   369.0000  250.0000;
%   377.0000  248.0000;
%   423.0000  181.0000;
%   459.5000  531.0000;
%   534.1000  457.1000;
%   538.3404  469.4468;
%   540.0000  457.0000;
%   559.3918  342.6186;
%   559.9848  319.8030;
%   561.1875  294.2500;
%   570.0000  300.5000;
%   596.0000  719.0000;
%   696.3415  364.4146;
%   696.6909  320.2727;
%   696.5849  341.0377;
%   739.0303  179.3636;
%   776.0000  484.0000;
%   782.0000  499.0000;
%   798.0000   27.0000;
%   808.0000   59.0000;
%   ];
% R=50;
% kFrame = 400;

centers = [
    1,1;
    3,3;
    6,4;
    7,3;
    8,5
    ];
R = 3;

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





