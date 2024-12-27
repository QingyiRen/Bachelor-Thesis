function y = D3(matrix)
aa=[ -1   2  -1
     -1   2  -1;
     -1   2  -1;];
aaa=aa.*matrix;
y=sum(sum(aaa));


