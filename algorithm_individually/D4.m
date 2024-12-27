function y = D4(matrix)
aa=[ 2  -1  -1
    -1   2  -1;
    -1  -1   2;];
aaa=aa.*matrix;
y=sum(sum(aaa));
