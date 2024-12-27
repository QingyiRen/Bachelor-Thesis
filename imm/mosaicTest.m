% clear
% close all
f_left = 'wb';
f_right = 'wb';
ext = 'jpg';
cd('C:\Users\任小猪\Desktop\毕设\Camera\left_pic')
img1 = correct_imgL;
% imread([f_left '3.jpg']);
cd('C:\Users\任小猪\Desktop\毕设\Camera\right_pic')
img2 = correct_imgR;
% imread([f_right '3.jpg']);
% img3 = imread('b3.jpg');
[img0,matchLoc1,matchLoc2,trackinglist] = imMosaic(img2,img1,1);
% img0 = imMosaic(img1,img0,1);
figure,imshow(img0);
% cd('C:\Users\任小猪\Desktop\毕设\Camera\Mosaic')
% imwrite(img0,['mosaic_' f_left '.' ext],ext)
max(matchLoc1(:,1))

% 输出trackinglist为txt格式
% [m, n] = size(trackinglist);
% fid=fopen('output.txt', 'wt');
% for i = 1 : m
% 	fprintf(fid, '%g\t', trackinglist(i, :));
% 	fprintf(fid, '\n');
% end
% fclose(fid);

%%
%得到深度信息
% f=focal_length(1,1);
% b=baseline;
% z=f*b/xlength;
% % 利用矫正后的左右图生成立体图像
% Anaglyph = stereoAnaglyph(correct_imgL, correct_imgR);
% figure; imshow(Anaglyph);
d1=matchLoc1(1,2)-matchLoc2(1,2);
d2=matchLoc1(2,2)-matchLoc2(2,2);
[mN,nN]=size(yDepth);
f=focal_length(1,1);
b=baseline;
WnewT=[];

Z1=f*b/d1;%出错，应该为xl-xr
W(1,1)=Z1*(matchLoc1(1,2)-270.218)/426.3811;
W(2,1)=Z1*(matchLoc1(1,1)-349.235)/427.2602;
W(3,1)=Z1;
Z2=f*b/d2;%出错，应该为xl-xr
W(1,2)=Z2*(matchLoc1(2,2)-270.218)/426.3811;
W(2,2)=Z2*(matchLoc1(2,1)-349.235)/427.2602;
W(3,2)=Z2;
m=sqrt((W(1,1)-W(1,2))^(2)+(W(2,1)-W(2,2))^(2)+(W(3,1)-W(3,2))^(2));
figure;
plot3(W(1,:),W(2,:),W(3,:),'b.');
