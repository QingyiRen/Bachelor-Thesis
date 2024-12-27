global rowM colM
track='C:\Users\任小猪\Desktop\毕设\test1.jpg';
tt=canny(track);
imshow(tt);
for i=1:rowM
    for j=1:colM
        if(tt(i,j)>150)
            tt(i,j)=255;
        else
            tt(i,j)=0;
        end
    end
end
figure(2);
imshow(tt);
% b=medfilt2(tt,[3,3]);  %matlab中自带值滤波函数
% imshow(b);
pengzhang=tt;
B0=[1 1 1;
    1 1 1;
    1 1 1];%B为结构元
% B1=[1 1 1 1 1;
%    1 1 1 1 1;
%    1 1 1 1 1;
%    1 1 1 1 1;
%    1 1 1 1 1];
pengzhang1=imdilate(pengzhang,B0);%图像sobelxx被结构元素B膨胀
pengzhang2=imdilate(pengzhang1,B0);%膨胀两次
% pengzhang3=imdilate(pengzhang2,B0); %膨胀三次
% imwrite(pengzhang1,'膨胀一次图.bmp');
% figure(4);
% subplot(2,2,1);
% imshow(pengzhang);
% title('未膨胀图像');
% subplot(2,2,2);
% imshow(pengzhang1);
% title('使用B后1次膨胀后的图像');
% subplot(2,2,3);
% imshow(pengzhang2);
% title('使用B后2次膨胀后的图像');
% subplot(2,2,4);
% imshow(pengzhang3);
% title('使用B后3次膨胀后的图像');
fushi=pengzhang1;
figure(3);
subplot(2,2,1);
imshow(fushi);
title('腐蚀原始图像');
se1=strel('disk',1);%这是一个半径为1的圆盘结构元素
fushi1=imerode(fushi,se1);
imwrite(fushi1,'腐蚀一次图.bmp');
subplot(2,2,2);
imshow(fushi1);
title('使用结构元disk(1)腐蚀后的图像');
se2=strel('disk',2);
fushi2=imerode(fushi1,se1);
subplot(2,2,3);
imshow(fushi2);
title('使用结构元disk(2)腐蚀后的图像');
se3=strel('disk',3);
fushi3=imerode(fushi2,se1);
subplot(2,2,4);
imshow(fushi3);
title('使用结构元disk(3)腐蚀后的图像');
%%
figure;
subplot(1,3,1);
imshow(pengzhang);
title('原始图像');
subplot(1,3,2);
imshow(pengzhang1);
title('使用结构元B膨胀后的图像');
subplot(1,3,3);
imshow(fushi1);
title('使用结构元se1腐蚀后的图像');
%%
% 霍夫变换
BW=zeros(480,640);
for i=1:480
    for j=1:640
         if i>150&&i<200&&j>200&&j<500
           if(tt(i,j)>0)
              BW(i,j)=1;%返回二值图像(边界1,否则0)
           end
         else
            BW(i,j)=0;
        end
    end
end
% BW = edge(I,'canny');%Canny方法提取图像边界，返回二值图像(边界1,否则0)
imshow(BW);
[H,T,R] = hough(BW);%计算二值图像的标准霍夫变换，H为霍夫变换矩阵，I,R为计算霍夫变换的角度和半径值
subplot(1,3,2);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');%hough变换的图像
xlabel('\theta'), ylabel('\rho');
axis on,axis square,hold on;
P  = houghpeaks(H,3);%提取3个极值点
x = T(P(:,2)); 
y = R(P(:,1));
plot(x,y,'s','color','white');%标出极值点
lines=houghlines(BW,T,R,P);%提取线段
subplot(1,3,3);
imshow(fushi1), hold on;
point_start=[];
point_end=[];
for k = 1:length(lines)
xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%画出线段
plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%起点
plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%终点
point_start=[point_start [xy(1,1);xy(1,2)]];
point_end=[point_end [xy(2,1);xy(2,2)]];
end
length_x=xy(2,1)-xy(1,1);
length_y=xy(1,2)-xy(2,2);
figure;
center=size(2,size(point_start,1));
for i=1:size(point_start,2)
x1=point_start(1,i);
y1=point_start(2,i);
scatter(x1,y1,'r')
text(x1+15,y1,num2str(i))
hold on
x2=point_end(1,i);
y2=point_end(2,i);
scatter(x2,y2,'g')
x=[x1;x2];
y=[y1;y2];
center(1,i)=(x1+x2)/2;
center(2,i)=(y1+y2)/2;
plot(x,y,'LineWidth',2,'Color','green');%画出线段
end
%%
%感兴趣ROI区域提取
centerX=mean(center(2,:));
Yright=max(point_end(1,:));
Yleft=min(point_start(1,:));
figure();
imshow(fushi1), hold on;
rectangle('Position',[ Yleft (centerX-8) (Yright-Yleft) 16],'LineWidth',1,'EdgeColor','r');
figure();
hanfeng=fushi1((centerX-5):(centerX+7),Yleft:Yright);
imshow(hanfeng);
X=[];
Y=[];
for i=1:size(hanfeng,1)
    for j=1:size(hanfeng,2)
        if hanfeng(i,j)>0
            X=[X (i-1+centerX-5)];
            Y=[Y (j-1+Yleft)];
        end
    end
end
% X=[point_start(1,3:5) point_end(1,3:5)];
% Y=[point_start(2,3:5) point_end(2,3:5)];
n=size(X,2);                %一共5个变量
 
x2=sum(X.^2);       % 求Σ(xi^2)
x1=sum(X);          % 求Σ(xi)
x1y1=sum(X.*Y);     % 求Σ(xi*yi)
y1=sum(Y);          % 求Σ(yi)

 
% a=(n*x1y1-x1*y1)/(n*x2-x1*x1);      %解出直线斜率b=(y1-a*x1)/n
a=35;
b=(y1-a*x1)/n;                      %解出直线截距
%作图
% 先把原始数据点用蓝色十字描出来
figure
imshow(fushi1);
hold on
% plot(Y,X,'o');      
% hold on
% 用红色绘制拟合出的直线
% px=linspace(min(point_start(1,3:5)),max(point_end(1,3:5)),max(point_end(1,3:5))-min(point_start(1,3:5))+1);%直线区间
% py=linspace((centerX-3),(centerX+4),8);%直线区间
py=linspace(Yleft,Yright,Yright-Yleft+1);%直线区间
% py=a*px+b;
px=(py-b)/a;
plot(py,px,'r','LineWidth',2)
px=round(px);
fengSet=[px;py];
flag=[px;py];
fengedge=[flag(:,1) flag(:,252)];
