function y = D1(matrix)
aa=[-1  -1 -1
     2   2  2;
    -1  -1 -1;];
yy=aa.*matrix;
y=sum(sum(yy));