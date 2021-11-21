close all

speed = 3; % �������� �������� � ������ � �������
heigh = 50; % ������ � ������
alpha = 84; % �������������� ���� ������ ������ � ��������
beta = 84; % ������������ ���� ������ ������ � ��������
FPS = 24; % ������� ������ �����������
R = 2; % ������ �������������� ����� � ������

mapLength = tand(beta/2)*heigh*2;
mapWidth = tand(alpha/2)*heigh*2;



% ������� ������ ��� ������ �����
reader = VideoReader('src.mp4');

% ��������� ������ ��� �����
% ������� step ����� ���������� ������� �������� Height x Width x  3
% ������ �������� ���� ������� ����� ��� ���� single - 4��� ������� ����� � ��������� ������
if ~reader.hasFrame()
    return
end
prevFrame = reader.readFrame();
prevDif = [];
prevCenters = [];

s = size(prevFrame);
camHeigh = s(1);
camWidth = s(2);

R = mapLength/camHeigh * R;
vpx = round(camHeigh/mapLength * speed);
vpx = 1
R = 50


while reader.hasFrame()
   frame = reader.readFrame();
   
   frame = rgb2gray(frame);
   frame = imadjust(frame,[0 1], [0 1], 5);
   difFrame = getDifFrame(frame, prevFrame, vpx);   
   
   centers = getCenterMassList(difFrame);
   centers1 = centers;
   [centers,objects] = groupCenters(centers, R);
   
   imshow(frame);
   hold on 
   if (length(centers)~=0)
       plot(centers1(:,1), centers1(:,2), 'b*');
       plot(centers(:,1), centers(:,2), 'r*');
   end
   
   prevFrame = frame;
   prevDif = difFrame;
   prevCenters = centers;
   pause(0.001)
end