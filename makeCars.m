function res = makeCars(pairs, mapLength, mapWidth, camHeigh, camWidth, heigh, FPS)
% ������� ��������� ���������� � �������. 
% ��������� - ������ ����� (cell), ����������:
% - ���������� ������ ������ (� ��������)
% - ���������� �� ������ �� ������ (� ������)
% - �������� ������ (� ������ � �������)

% ��������� ��� �������
if (nargin ==0)
    camHeigh = 720;
    camWidth = 1280;
    heigh = 50; % ������ � ������
    alpha = 84; % �������������� ���� ������ ������ � ��������
    beta = 84; % ������������ ���� ������ ������ � ��������
    mapLength = tand(beta/2)*heigh*2; % ����� ����� �� ���������
    mapWidth = tand(alpha/2)*heigh*2; % ������ ����� �� ���������

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

% ��������� ������������ ������� ����� ������� � �������� �����
kL = mapLength/camHeigh;
kW = mapWidth/camWidth;
koef_Real_PX = [kL kW];

% ���������� ������ (� �������� � ������, ������������ ������ �������� ����)
camCenterPX = [camWidth/2  camHeigh/2];
camCenterReal = [mapWidth/2  camWidth/2];

res = [];
for i=1:length(pairs)
   pair = pairs{i,:};
      
   if (size(pair,1)==2)
       carPX = pair(1,:); % ���� ����� ������� ���������� ������ ������
       
       carRealLater = px2real(pair(1,:), camCenterPX, camCenterReal, koef_Real_PX);
       carRealEarlier = px2real(pair(2,:), camCenterPX, camCenterReal, koef_Real_PX);
       
       % ��������� � �����, �������� ��������������: �����-����������-�����
       
       
       % ��������� �������� 
       v = round(sqrt(sum((carRealLater - carRealEarlier).^2))*FPS*3.6);       
       d = sqrt( sum((carRealLater - camCenterReal).^2) + heigh^2 );
              
       % ��������� '������'
       car = {pair(1,:), d, v};

       res = [res; car];
   end
end
end
