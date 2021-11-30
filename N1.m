close all
clear all

speed = 3; % �������� �������� � ������ � �������
heigh = 50; % ������ � ������
alpha = 84; % �������������� ���� ������ ������ � ��������
beta = 84; % ������������ ���� ������ ������ � ��������
FPS = 24; % ������� ������ �����������
R = 2; % ������ �������������� ����� � ������

mapLength = tand(beta/2)*heigh*2; % ����� ����� �� ���������
mapWidth = tand(alpha/2)*heigh*2; % ������ ����� �� ���������



% ������� ������ ��� ������ �����
reader = VideoReader('src.mp4');

% ��������� ������ ��� �����
% ������� step ����� ���������� ������� �������� Height x Width x  3
% ������ �������� ���� ������� ����� ��� ���� single - 4��� ������� ����� � ��������� ������
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

kadr=1;
while reader.hasFrame()
   frame = reader.readFrame();
   kadr=kadr+1
   
   originFrame = frame;
   frame = rgb2gray(frame);
   frame = imadjust(frame,[0 1], [0 1], 5);
   difFrame = getDifFrame(frame, prevFrame, vpx);   
   centers = getCenterMassList(difFrame);
   centers1 = centers;
   [centers,~] = groupCenters2(centers, R);
   pairs = makePairs(centers, prevCenters, R);
   cars = makeCars(pairs, mapLength, mapWidth, camHeigh, camWidth, heigh);

   
   imshow(originFrame);
   hold on
   plot(camWidth/2, camHeigh/2, 'y*')
   if (length(centers)~=0)
       plot(centers1(:,1), centers1(:,2), 'b*');
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