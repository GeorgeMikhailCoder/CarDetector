function res = drawCars(cars)
if (nargin==0)
   cars = [{[23 45], 3, 1},
       {[67 78], 8, 9}];
%    cars = [];
end

if (isempty(cars))
   return 
end

centers = [cars{:,1}];
centers = reshape(centers,[length(centers)/2, 2]);

distances = [cars{:,2}];
velocities = [cars{:,3}];
hold on
plot(centers(:,1), centers(:,2), 'r*');

for i=1:size(cars,1)
    text(centers(i,1)+15,centers(i,2), strjoin(string([round(centers(i,1)),round(centers(i,2))])),'color','white');
    text(centers(i,1)+15,centers(i,2)+15, string(round(distances(i))),'color','yellow');
end