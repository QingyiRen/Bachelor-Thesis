% track='C:\Users\��С��\Desktop\1.jpg';
imshow(yDepth,[]);%���0-255
% tt=canny(yDepth);
% for i=1:size(tt,1)
%     for j=1:size(tt,2)
%         if(tt(i,j)>40)
%             tt(i,j)=255;
%         else
%             tt(i,j)=0;
%         end
%     end
% end
% figure(2);
% imshow(tt);
%%
BW=zeros(size(yDepth,1),size(yDepth,2));
for i=1:size(yDepth,1)
    for j=1:size(yDepth,2)
        if(yDepth(i,j)>=55)
            BW(i,j)=1;%���ض�ֵͼ��(�߽�1,����0)
        else
            BW(i,j)=0;
        end
    end
end
% BW = edge(I,'canny');%Canny������ȡͼ��߽磬���ض�ֵͼ��(�߽�1,����0)
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
imshow(BW), hold on;
for k = 1:length(lines)
xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%�����߶�
plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%���
plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%�յ�
end
% length_x=xy(2,1)-xy(1,1);
% length_y=xy(1,2)-xy(2,2);
% ROI=pengzhang3(1:1440,600:750);
% figure(5);
% imshow(ROI);