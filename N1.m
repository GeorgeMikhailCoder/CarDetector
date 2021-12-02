close all
clear all

resultFileName = 'tmp.avi';

speed = 3; % скорость движени€ в метрах в секунду
heigh = 50; % высота в метрах
alpha = 84; % горизонтальный угол обзора камеры в градусах
beta = 84; % вертикальный угол обзора камеры в градусах
FPS = 24; % частота кадров видеосъЄмки
R = 3; % радиус отождествлени€ точек в метрах
frameRate = 10; % частота записи выходного видео

mapLength = tand(beta/2)*heigh*2; % длина карты на плоскости
mapWidth = tand(alpha/2)*heigh*2; % ширина карты на плоскости



% создаем объект дл€ чтени€ видео
reader = VideoReader('src.mp4');
writer = VideoWriter(resultFileName);
writer.FrameRate = frameRate;
open(writer);
 
% проверка на пустое видео
if ~reader.hasFrame()
    return
end

% инициализаци€ локальных (промежуточных) переменных
prevFrame = reader.readFrame(); % предыдущий кадр видео. »значально первый кадр.
prevCenters = []; % ѕредыдущие значени€ координат центров машин

% разрешение камеры
s = size(prevFrame);
camHeigh = s(1);
camWidth = s(2);

% пересчЄт радиуса из 
R = camHeigh/mapLength * R;
% vpx = round(camHeigh/mapLength * speed);

vpx = 1;
kadr=0;
while reader.hasFrame()
   % покадрово читаем все видео
   frame = reader.readFrame();
   originFrame = frame;
   kadr=kadr+1;
   
   if (kadr>50)
       break;
   end
   
   % обработка картинки
   frame = rgb2gray(frame); % перевод в ч/б (оттенки серого)
   frame = imadjust(frame,[0 1], [0 1], 5); % повышение контрастности
   difFrame = getDifFrame(frame, prevFrame, vpx); % получение кадра градиентов
   centers = getCenterMassList(difFrame); % ищем центры областей на кадре градиентов
   centers1 = centers; % нужно только дл€ отрисовки найденных центров
   [centers,~] = groupCenters2(centers, R); % группируем центры областей по радиусу R. ѕолучаем центры машин (одна машина - как минимум область спереди и сзади)
   pairs = makePairs(centers, prevCenters, R); % сравниваем центры с предыдущим кадром, объедин€ем в пару 'было - стало'
   cars = makeCars(pairs, mapLength, mapWidth, camHeigh, camWidth, heigh, FPS); % по координатам центров вычисл€ем информацию о машинах

  % отрисовка 
   imshow(originFrame);
   hold on
   if (length(centers)~=0)
       drawCars(cars); % рисуем центры машин и текст
   end    
   
% дополнительно:
% if (length(centers)~=0)
%        plot(centers1(:,1), centers1(:,2), 'b*'); % центры до объединени€
%        plot(centers(:,1), centers(:,2), 'g*'); % центры после объединени€
%        for i=1:length(pairs)
%           plot(pair(1,1),pair(1,2), 'r*') % центры в парах 
%        end
%   end  
   
%    if (length(prevCenters)~=0)
%        plot(prevCenters(:,1), prevCenters(:,2), 'g*'); % 'старые' центры
%    end
%    plot(camWidth/2, camHeigh/2, 'y*') % центр камеры

    img = getframe();
    writeVideo(writer,img);
   % запоминаем последний кадр и центры, делаем 'устаревание'
   prevFrame = frame;
   prevCenters = centers;
   pause(0.001)
end
close(writer);
