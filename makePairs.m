function res = makePairs(centers, prevCenters, R)
[~, pairs] = groupCenters2([centers;prevCenters], R);
pairs
res = [];
for i=1:length(pairs)
    pair = pairs{i,:}
    if (size(pair,1)==2)
        res = [res; {pair}];
    end
end
end
