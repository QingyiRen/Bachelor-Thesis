% track='C:\Users\任小猪\Desktop\1.jpg';
imshow(yDepth,[]);%变成0-255
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
            BW(i,j)=1;%返回二值图像(边界1,否则0)
        else
            BW(i,j)=0;
        end
    end
end
% BW = edge(I,'canny');%Canny方法提取图像边界，返回二值图像(边界1,否则0)
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
imshow(BW), hold on;
for k = 1:length(lines)
xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');%画出线段
plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%起点
plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%终点
end
% length_x=xy(2,1)-xy(1,1);
% length_y=xy(1,2)-xy(2,2);
% ROI=pengzhang3(1:1440,600:750);
% figure(5);
% imshow(ROI);