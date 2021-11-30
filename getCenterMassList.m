function res = getCenterMassList(difFrame)
% ищет центры выпуклых областей каскадным методом (waterfall)

level=graythresh(difFrame); % автоматическое определение оптимального уровня для бинаризации изображения
% level = 0.5;
BW=im2bw(difFrame,level); % переводим изображение в бинарный вид
STATS=regionprops(BW,'Centroid'); % находим области с помощью 'waterfall' метода
res = cat(1,STATS.Centroid); % берём центры областей
end