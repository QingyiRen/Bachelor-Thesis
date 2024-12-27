function y = singleMatrix(row,col,MAT)
new = 3;
y = zeros(new,new);
for i=1:new
    for j=1:new
        y(i,j) = MAT(row-1+i,col-1+j);
    end
end
