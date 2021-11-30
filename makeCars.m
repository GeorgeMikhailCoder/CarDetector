function res = makeCars(pairs, mapLength, mapWidth, camHeigh, camWidth, heigh)
if (nargin ==0)
camHeigh = 720;
camWidth = 1280;
heigh = 50; % высота в метрах
alpha = 84; % горизонтальный угол обзора камеры в градусах
beta = 84; % вертикальный угол обзора камеры в градусах
mapLength = tand(beta/2)*heigh*2; % длина карты на плоскости
mapWidth = tand(alpha/2)*heigh*2; % ширина карты на плоскости

% pair1 =[
%   707.1000   23.7167;
%   706.8793   29.9310
%   ];
% pair2 =[
%   739.7448  484.0239;
%   742.0037  495.8301
% ];

pair1 =[
  1280/2 720/2   ;
  1280/2  720/2 - 4
  ];
pair2 =[
  1280/2 720/2   ;
  1280/2 + 6  720/2 - 4
  ];

pairs = {pair1; pair2};
end

kL = mapLength/camHeigh;
kW = mapWidth/camWidth;
koef = [kL kW];

camCenterPX = [camWidth/2  camHeigh/2];
camCenterReal = [mapWidth/2  camWidth/2];

res = [];
for i=1:length(pairs)
   pair = pairs{i,:};
      
   if (size(pair,1)==2)
       coordCar = pair(1,:);
       
       deltaCarPX = coordCar - camCenterPX;
       deltaCarReal = deltaCarPX.*koef;
       carReal = deltaCarReal + camCenterReal;
       
       v = deltaCarReal;       
       d = sqrt( sum(deltaCarReal.^2) + heigh^2 );
              
       car = {pair(1,:), d, v};
       res = [res; car];
   end
end
end
