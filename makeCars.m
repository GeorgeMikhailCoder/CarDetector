function res = makeCars(pairs, mapLength, mapWidth, camHeigh, camWidth, heigh)
if (nargin ==0)
camHeigh = 720;
camWidth = 1280;
heigh = 50; % высота в метрах
alpha = 84; % горизонтальный угол обзора камеры в градусах
beta = 84; % вертикальный угол обзора камеры в градусах
mapLength = tand(beta/2)*heigh*2; % длина карты на плоскости
mapWidth = tand(alpha/2)*heigh*2; % ширина карты на плоскости

pair1 =[
  707.1000   23.7167;
  706.8793   29.9310
  ];
pair2 =[
  739.7448  484.0239;
  742.0037  495.8301
];
pairs = {pair1; pair2}
end



kW = mapWidth/camWidth;
kL = mapLength/camHeigh;
camCoord = [mapWidth/2, mapLength/2];

res = [];
for i=1:length(pairs)
   pair = pairs{i,:};
   
   if (size(pair,1)==2)
       coord = pair(1,:);
       
       dx = kW*(coord(1) - camCoord(1));
       dy = kL*(coord(2) - camCoord(2));
       dz = heigh;
       
       d = sqrt(dx^2 + dy^2 + dz^2);
       
       %%%%%%%%
       v = pair(2,:) - pair(1,:);
       v1 = kW*v(1);
       v2 = kL*v(2);
       v = sqrt(v1^2 + v2^2);
       
       car = {pair(1,:), d, v};
       res = [res; car];
   end
end
end
