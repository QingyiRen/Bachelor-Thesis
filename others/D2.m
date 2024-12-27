function y = D2(matrix)
aa=[ -1  -1   2;
     -1   2   -1;
      2  -1  -1;];
yy=aa.*matrix;
y=sum(sum(yy));