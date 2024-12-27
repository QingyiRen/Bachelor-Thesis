function y=windowS(row,col,matrix,windowsize)
rowM=size(matrix,1);
colM=size(matrix,2);
a=zeros(windowsize,windowsize);
size_now=(windowsize-1)/2;
for i=-size_now:size_now
    for j=-size_now:size_now
        if ((row+i)<1||(row+i)>rowM||(col+j)<1||(col+j)>colM)
        a(i+size_now+1,j+size_now+1)=0;%³¬³ö±ß½çÍ¿ºÚ
        else
        a(i+size_now+1,j+size_now+1)=matrix(row+i,col+j);
        end
    end
end
y=a;
