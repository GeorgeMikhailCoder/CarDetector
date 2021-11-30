function res = getDifFrame(frame, prevFrame, vpx)
% ‘ункци€ выдаЄт кадр изменений (градиентов)

[subFrame, subPrev] = getSubFrames(frame, prevFrame, vpx);   % выравниваем кадры

% получаем градиенты
difFrame = subFrame - subPrev; 

% ¬ыполн€ем порогувую обработку 
% (нужно дл€ однозначного определени€ подвижных областей)
porog = 75;
difFrame(difFrame>porog) = 255;
difFrame(difFrame<porog) = 0;

% выполн€ем эрозию, чтобы убрать шум типа "соль-перец" (единичные пиксели)
S = strel('square',2);
difFrame = imerode(difFrame,S);
difFrame = imerode(difFrame,S);

res = difFrame;
end