global rowM colM
track='C:\Users\��С��\Desktop\����\test1.jpg';
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
% b=medfilt2(tt,[3,3]);  %matlab���Դ�ֵ�˲�����
% imshow(b);
pengzhang=tt;
B0=[1 1 1;
    1 1 1;
    1 1 1];%BΪ�ṹԪ
% B1=[1 1 1 1 1;
%    1 1 1 1 1;
%    1 1 1 1 1;
%    1 1 1 1 1;
%    1 1 1 1 1];
pengzhang1=imdilate(pengzhang,B0);%ͼ��sobelxx���ṹԪ��B����
pengzhang2=imdilate(pengzhang1,B0);%��������
% pengzhang3=imdilate(pengzhang2,B0); %��������
% imwrite(pengzhang1,'����һ��ͼ.bmp');
% figure(4);
% subplot(2,2,1);
% imshow(pengzhang);
% title('δ����ͼ��');
% subplot(2,2,2);
% imshow(pengzhang1);
% title('ʹ��B��1�����ͺ��ͼ��');
% subplot(2,2,3);
% imshow(pengzhang2);
% title('ʹ��B��2�����ͺ��ͼ��');
% subplot(2,2,4);
% imshow(pengzhang3);
% title('ʹ��B��3�����ͺ��ͼ��');
fushi=pengzhang1;
figure(3);
subplot(2,2,1);
imshow(fushi);
title('��ʴԭʼͼ��');
se1=strel('disk',1);%����һ���뾶Ϊ1��Բ�̽ṹԪ��
fushi1=imerode(fushi,se1);
imwrite(fushi1,'��ʴһ��ͼ.bmp');
subplot(2,2,2);
imshow(fushi1);
title('ʹ�ýṹԪdisk(1)��ʴ���ͼ��');
se2=strel('disk',2);
fushi2=imerode(fushi1,se1);
subplot(2,2,3);
imshow(fushi2);
title('ʹ�ýṹԪdisk(2)��ʴ���ͼ��');
se3=strel('disk',3);
fushi3=imerode(fushi2,se1);
subplot(2,2,4);
imshow(fushi3);
title('ʹ�ýṹԪdisk(3)��ʴ���ͼ��');
%%
figure;
subplot(1,3,1);
imshow(pengzhang);
title('ԭʼͼ��');
subplot(1,3,2);
imshow(pengzhang1);
title('ʹ�ýṹԪB���ͺ��ͼ��');
subplot(1,3,3);
imshow(fushi1);
title('ʹ�ýṹԪse1��ʴ���ͼ��');
%%
% ����任
BW=zeros(480,640);
for i=1:480
    for j=1:640
         if i>150&&i<200&&j>200&&j<500
           if(tt(i,j)>0)
              BW(i,j)=1;%���ض�ֵͼ��(�߽�1,����0)
           end
         else
            BW(i,j)=0;
        end
    end
end
% BW = edge(I,'canny');%Canny������ȡͼ��߽磬���ض�ֵͼ��(�߽�1,����0)
imshow(BW);
[H,T,R] = hough(BW);%�����ֵͼ��ı�׼����任��HΪ����任����I,RΪ�������任�ĽǶȺͰ뾶ֵ
subplot(1,3,2);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');%hough�任��ͼ��
xlabel('\theta'), ylabel('\rho');
axis on,axis square,hold on;
P  = houghpeaks(H,3);%��ȡ3����ֵ��
x = T(P(:,2)); 
y = R(P(:,1));
plot(x,y,'s','color','white');%�����ֵ��
lines=houghlines(BW,T,R,P);%��ȡ�߶�
subplot(1,3,3);
imshow(fushi1), hold on;
point_start=[];
point_end=[];
for k = 1:length(lines)
xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%�����߶�
plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%���
plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%�յ�
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
plot(x,y,'LineWidth',2,'Color','green');%�����߶�
end
%%
%����ȤROI������ȡ
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
n=size(X,2);                %һ��5������
 
x2=sum(X.^2);       % ��(xi^2)
x1=sum(X);          % ��(xi)
x1y1=sum(X.*Y);     % ��(xi*yi)
y1=sum(Y);          % ��(yi)

 
% a=(n*x1y1-x1*y1)/(n*x2-x1*x1);      %���ֱ��б��b=(y1-a*x1)/n
a=35;
b=(y1-a*x1)/n;                      %���ֱ�߽ؾ�
%��ͼ
% �Ȱ�ԭʼ���ݵ�����ɫʮ�������
figure
imshow(fushi1);
hold on
% plot(Y,X,'o');      
% hold on
% �ú�ɫ������ϳ���ֱ��
% px=linspace(min(point_start(1,3:5)),max(point_end(1,3:5)),max(point_end(1,3:5))-min(point_start(1,3:5))+1);%ֱ������
% py=linspace((centerX-3),(centerX+4),8);%ֱ������
py=linspace(Yleft,Yright,Yright-Yleft+1);%ֱ������
% py=a*px+b;
px=(py-b)/a;
plot(py,px,'r','LineWidth',2)
px=round(px);
fengSet=[px;py];
flag=[px;py];
fengedge=[flag(:,1) flag(:,252)];
