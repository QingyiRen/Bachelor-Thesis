function y = census(left,right)
[m,n]=size(left);
costL=zeros(1,m*n);
costR=zeros(1,m*n);
cost=0;
center=(m+1)/2;%中心点位置
for i=1:m
    for j=1:n
        if left(i,j)<left(center,center)
            costL(1,(i-1)*n+j)=1;
        else
            costL(1,(i-1)*n+j)=0;
        end    
        if right(i,j)<right(center,center)
            costR(1,(i-1)*n+j)=1;
        else
            costR(1,(i-1)*n+j)=0;
        end 
        if costL(1,(i-1)*n+j)~=costR(1,(i-1)*n+j)
            cost=cost+1;%异或运算
        end
    end
end
y=cost;

