close all

speed = 3; % скорость движения в метрах в секунду
heigh = 50; % высота в метрах
alpha = 84; % горизонтальный угол обзора камеры в градусах
beta = 84; % вертикальный угол обзора камеры в градусах
FPS = 24; % частота кадров видеосъёмки
R = 2; % радиус отождествления точек в метрах

mapLength = tand(beta/2)*heigh*2; % длина карты на плоскости
mapWidth = tand(alpha/2)*heigh*2; % ширина карты на плоскости



% создаем объект для чтения видео
reader = VideoReader('src.mp4');

% покадрово читаем все видео
% функция step будет возвращать матрицу размером Height x Width x  3
% правда элементы этой матрицы будут уже типа single - 4рех байтные числа с плавающей точкой
if ~reader.hasFrame()
    return
end
prevFrame = reader.readFrame();
prevCenters = [];

s = size(prevFrame);
camHeigh = s(1)
camWidth = s(2)

R = mapLength/camHeigh * R;
vpx = round(camHeigh/mapLength * speed);
vpx = 1
R = 20


while reader.hasFrame()
   frame = reader.readFrame();
    
   frame = rgb2gray(frame);
   frame = imadjust(frame,[0 1], [0 1], 5);
   difFrame = getDifFrame(frame, prevFrame, vpx);   
   centers = getCenterMassList(difFrame);
   centers1 = centers
   [centers,~] = groupCenters2(centers, R);
   
   pairs = makePairs(centers, prevCenters, R);
   if (size(centers,1)~=0)
     c1 = centers(1,:)
   end
   if (length(pairs)~=0)
       p1 = pairs{1}
   end
   
   cars = makeCars(pairs, mapLength, mapWidth, camHeigh, camWidth, heigh);
   if (size(cars,1)~=0)
       cr1 = cars{1}
   end
   
   
%    velocities = zeros(length(objects),2);
%    for i=1:length(objects)
%        pair = objects{i}
%        if (size(pair,1)~=2)
%            disp("Error")
%        else
%            velocities(i,:) = pair(2,:) - pair(1,:);
%        end
%    end
%    velocities
   
   imshow(frame);
   hold on
   if (length(centers)~=0)
%        plot(centers1(:,1), centers1(:,2), 'b*');
%        plot(centers(:,1), centers(:,2), 'g*');
       
       for i=1:length(pairs)
          pair = pairs{i};
%           plot(pair(1,1),pair(1,2), 'r*')
       end
       
       drawCars(cars);
   end
   if (length(prevCenters)~=0)
       plot(prevCenters(:,1), prevCenters(:,2), 'g*');
   end
   
   prevFrame = frame;
   prevCenters = centers;
   pause(0.001)
end