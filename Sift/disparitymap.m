function y=disparitymap(left,right)
[m,n]=size(right);
for i=1:30
    if i==1
       rightLayer{1,i}=right;
    else
       rightLayer{1,i}=[edgeAdd(right(:,1),i) right(:,1:(n-i))]; 
    end
end
% y=rightLayer{1,10};
% imshow(y);
windowsize=3;
y=zeros(m,n);
d=zeros(1,30);
for i=1:m
    for j=1:n
        LI=window(i,j,left,windowsize);
        for ceng=1:30
            Rimg=rightLayer{1,ceng};
            RI=window(i,j,Rimg,windowsize);
            d(1,ceng)=census(LI,RI);%对每一层分别求census代价
        end
        disp(d);
        hang_max=max(d);
        dstar=find(d==hang_max);%找到最大值所在的层数
        if size(dstar,2)~=1
           y(i,j)=0;%视差图为-1代表该点视差没有意义
        else
           flag=d;
           flag(1,dstar)=-1;
           hang_max=max(flag);
           dsecond=find(flag==hang_max);%找到次大值所在的层数
          if size(dsecond,2)~=1
           dsecond=dsecond(1,1);
          end
           dleft=dstar-1;%找到左边所在的层数
           dright=dstar+1;%找到右边所在的层数
          if abs(d(1,dstar)-d(1,dsecond))<=1%最大值和次大值的差小于阈值1，舍去
            y(i,j)=0;%视差图为0代表该点视差没有意义
          elseif dright>30
            y(i,j)=dstar;
          elseif dleft<1
            y(i,j)=dstar;
          else
            dfinal=dstar+(d(1,dright)-d(1,dleft))/2/(d(1,dleft)+d(1,dright)-2*d(1,dstar));%子像素拟合
            y(i,j)=dfinal;
          end
        end
     end
end
for i=1:m %考虑代价聚合
    for j=1:n
        if y(i,j)>0
            ywindow=window(i,j,y,windowsize);
%         disp(ywindow);
            leftwindow=window(i,j,left,windowsize);
            yy(i,j)=Bifilter(ywindow,leftwindow);
        else
            yy(i,j)=0;
        end
    end
end
y=yy;