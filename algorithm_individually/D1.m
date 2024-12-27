function y = D1(matrix)
aa=[-1  -1 -1
     2   2  2;
    -1  -1 -1;];
aaa=aa.*matrix;
y=sum(sum(aaa));
