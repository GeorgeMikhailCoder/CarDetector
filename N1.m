close all

speed = 3; % �������� �������� � ������ � �������
heigh = 50; % ������ � ������
alpha = 84; % �������������� ���� ������ ������ � ��������
beta = 84; % ������������ ���� ������ ������ � ��������
FPS = 24; % ������� ������ �����������
R = 2; % ������ �������������� ����� � ������

mapLength = tand(beta/2)*heigh*2;
mapWidth = tand(alpha/2)*heigh*2;

R = mapLength/camHeigh * R;

% ������� ������ ��� ������ �����
reader = VideoReader('src.mp4');

% ��������� ������ ��� �����
% ������� step ����� ���������� ������� �������� Height x Width x  3
% ������ �������� ���� ������� ����� ��� ���� single - 4��� ������� ����� � ��������� ������
if ~reader.hasFrame()
    return
end
prevFrame = reader.readFrame();
prevDif = zeros(size(prevFrame));

s = size(prevFrame);
camHeigh = s(1);
camWidth = s(2);

vpx = round(camHeigh/mapLength * speed);
vpx = 1



while reader.hasFrame()
   frame = reader.readFrame();
   difFrame = getDifFrame(frame, prevFrame, vpx);
   
   prevCenters = getCenterMassList(prevDif);
   centers = getCenterMassList(difFrame);
   
   
   imshow(frame);
   if (centers)
   hold on
   plot(centers(:,1), centers(:,2), 'r*')
   hold off
   end
   prevFrame = frame;
   prevDif = difFrame;
   pause(0.001)

end