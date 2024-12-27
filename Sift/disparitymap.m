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
            d(1,ceng)=census(LI,RI);%��ÿһ��ֱ���census����
        end
        disp(d);
        hang_max=max(d);
        dstar=find(d==hang_max);%�ҵ����ֵ���ڵĲ���
        if size(dstar,2)~=1
           y(i,j)=0;%�Ӳ�ͼΪ-1����õ��Ӳ�û������
        else
           flag=d;
           flag(1,dstar)=-1;
           hang_max=max(flag);
           dsecond=find(flag==hang_max);%�ҵ��δ�ֵ���ڵĲ���
          if size(dsecond,2)~=1
           dsecond=dsecond(1,1);
          end
           dleft=dstar-1;%�ҵ�������ڵĲ���
           dright=dstar+1;%�ҵ��ұ����ڵĲ���
          if abs(d(1,dstar)-d(1,dsecond))<=1%���ֵ�ʹδ�ֵ�Ĳ�С����ֵ1����ȥ
            y(i,j)=0;%�Ӳ�ͼΪ0����õ��Ӳ�û������
          elseif dright>30
            y(i,j)=dstar;
          elseif dleft<1
            y(i,j)=dstar;
          else
            dfinal=dstar+(d(1,dright)-d(1,dleft))/2/(d(1,dleft)+d(1,dright)-2*d(1,dstar));%���������
            y(i,j)=dfinal;
          end
        end
     end
end
for i=1:m %���Ǵ��۾ۺ�
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