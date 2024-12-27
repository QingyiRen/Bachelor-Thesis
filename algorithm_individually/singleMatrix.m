function y = singleMatrix(row,col,MAT,k)
y = zeros(3,3);
dM=2^(10-k);
  for i=1:3
    for j=1:3
        if((row-1+i)<=dM&&(col-1+j)<=dM)
          y(i,j)=MAT(row-1+i,col-1+j);
        else
          y(i,j)=0;
        end
    end
  end
