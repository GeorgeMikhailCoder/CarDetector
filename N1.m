close all
% ������� ������ ��� ������ �����
reader = VideoReader('src.mp4');

% ��������� ������ ��� �����
% ������� step ����� ���������� ������� �������� Height x Width x  3
% ������ �������� ���� ������� ����� ��� ���� single - 4��� ������� ����� � ��������� ������
if ~reader.hasFrame()
    return
end
prevFrame = reader.readFrame(); 

s = size(prevFrame);
camHeigh = s(1)
camWidth = s(2)
vpx = 1;

f= figure();

while reader.hasFrame()
   frame = reader.readFrame();
   subFrame = frame(vpx:camHeigh,:);
   
   subplot(2,2,1)
   imshow(prevFrame)
   
   subplot(2,2,2)
   imshow(frame)
   
   subplot(2,2,3) 
   imshow(frame-prevFrame);
   
   subplot(2,2,4) 
   imshow(frame-prevFrame);
   
   prevFrame = zeros(size(frame));
   prevFrame = frame;
   pause(2)
end