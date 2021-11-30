close all
clear all

speed = 3; % скорость движения в метрах в секунду
heigh = 50; % высота в метрах
alpha = 84; % горизонтальный угол обзора камеры в градусах
beta = 84; % вертикальный угол обзора камеры в градусах
FPS = 24; % частота кадров видеосъёмки
R = 3; % радиус отождествления точек в метрах

mapLength = tand(beta/2)*heigh*2; % длина карты на плоскости
mapWidth = tand(alpha/2)*heigh*2; % ширина карты на плоскости



% создаем объект для чтения видео
reader = VideoReader('src.mp4');

% проверка на пустое видео
if ~reader.hasFrame()
    return
end

% инициализация локальных (промежуточных) переменных
prevFrame = reader.readFrame(); % предыдущий кадр видео. Изначально первый кадр.
prevCenters = []; % Предыдущие значения координат центров машин

% разрешение камеры
s = size(prevFrame);
camHeigh = s(1);
camWidth = s(2);

% пересчёт радиуса из 
R = camHeigh/mapLength * R;
% vpx = round(camHeigh/mapLength * speed);

vpx = 1;

while reader.hasFrame()
   % покадрово читаем все видео
   frame = reader.readFrame();
   originFrame = frame;
   
   % обработка картинки
   frame = rgb2gray(frame); % перевод в ч/б (оттенки серого)
   frame = imadjust(frame,[0 1], [0 1], 5); % повышение контрастности
   difFrame = getDifFrame(frame, prevFrame, vpx); % получение кадра градиентов
   centers = getCenterMassList(difFrame); % ищем центры областей на кадре градиентов
   centers1 = centers; % нужно только для отрисовки найденных центров
   [centers,~] = groupCenters2(centers, R); % группируем центры областей по радиусу R. Получаем центры машин (одна машина - как минимум область спереди и сзади)
   pairs = makePairs(centers, prevCenters, R); % сравниваем центры с предыдущим кадром, объединяем в пару 'было - стало'
   cars = makeCars(pairs, mapLength, mapWidth, camHeigh, camWidth, heigh); % по координатам центров вычисляем информацию о машинах

  % отрисовка 
   imshow(originFrame);
   hold on
   if (length(centers)~=0)
       drawCars(cars); % рисуем центры машин и текст
   end    
   
% дополнительно:
% if (length(centers)~=0)
%        plot(centers1(:,1), centers1(:,2), 'b*'); % центры до объединения
%        plot(centers(:,1), centers(:,2), 'g*'); % центры после объединения
%        for i=1:length(pairs)
%           plot(pair(1,1),pair(1,2), 'r*') % центры в парах 
%        end
%   end  
   
%    if (length(prevCenters)~=0)
%        plot(prevCenters(:,1), prevCenters(:,2), 'g*'); % 'старые' центры
%    end
%    plot(camWidth/2, camHeigh/2, 'y*') % центр камеры


   % запоминаем последний кадр и центры, делаем 'устаревание'
   prevFrame = frame;
   prevCenters = centers;
   pause(0.001)
end