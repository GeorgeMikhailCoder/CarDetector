function [resMeans, resObjectPoints] = groupCenters(centers, R)
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

s = size(centers);
s1 = s(1);
if (s1==0)
    resMeans = [];
    resObjectPoints = [];
else 
if (s1==1)
    resMeans = centers;
    resObjectPoints = centers;
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
for i=2:1:length(centers)
   elem = centers(i,:);
   if (elem - prev <=R)
       if (sum((elem - prev).^2)< R^2)
           object = [object; elem];
           prev = elem;
           continue
       end
   end
      
   resObj = [resObj; {object}];
   mx = mean(object(:,1));
   my = mean(object(:,2));
   object = elem;
   resM = [resM; mx,my];
   prev = elem;
   end
   
resObj = [resObj; {object}];
% for i=1:1:length(resObj)
%     el = resObj(i);
%     el{1};
% end

mx = mean(object(:,1));
my = mean(object(:,2));
resM=[resM; mx,my];
resMeans = resM;
resObjectPoints = resObj;
end

end
end





