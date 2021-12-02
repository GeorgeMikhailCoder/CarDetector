function res = px2real(carPX, camCenterPX, camCenterReal, koef_Real_PX)
       camCarPX = carPX - camCenterPX;
       camCarReal = camCarPX.*koef_Real_PX;
       res = camCarReal + camCenterReal;
end