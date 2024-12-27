function y=window(row,col,matrix)
global rowM colM
size_now=1;
new=2*size_now+1;
a=zeros(new,new);
row=row-1;
col=col-1;

for i=1:size_now+1
    for j=1:size_now+1
        if ((row+size_now-i)<1||(row+size_now-i)>rowM||(col+size_now-j)<1||(col+size_now-j)>colM)
        a(i,j)=255;%³¬³ö±ß½çÍ¿ºÚ
        else
        a(i,j)=matrix(row+size_now-i,col+size_now-j);
        end
    end
end
y=a;
