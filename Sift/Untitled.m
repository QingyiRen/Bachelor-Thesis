% %% ׼�������ռ� 
% clc3
% clear all
% % close all
%% ����ͼƬ·��
% image1='C:\Users\��С��\Desktop\����\test1.jpg';
% image2='C:\Users\��С��\Desktop\����\test2.jpg';
image1='D:\������\������\test1.jpg';
image2='D:\������\������\test2.jpg';
%% ��ȡͼƬ��SIFT������
[im1, des1, loc1] = sift(image1);
[im2, des2, loc2] = sift(image2);
%% ����ƥ��������
distRatio = 1;   % ��������������ֵ, ��ֵԽСԽ�ϸ�
des2t = des2';       
match=zeros(1,size(des1,1));
for ii = 1 : size(des1,1)
   dotprods = des1(ii,:) * des2t;        
   [vals,indx] = sort(acos(dotprods)); %
   if (vals(1) < distRatio * vals(2))
      match(ii) = indx(1);
   else
      match(ii) = 0;
   end
end
% match = matchFeatures(des1,des2,  'MatchThreshold', 20,'MaxRatio',0.1 );

% ����ƽ��ͼ����ʾƥ��������
im3 = appendimages(im1,im2);
figure('Position', [10 10 size(im3,2) size(im3,1)]);
colormap('gray');
imagesc(im3);
hold on;
cols1 = size(im1,2);
for ii = 1: length(match)
  if (match(ii) > 0)&&abs(loc1(ii,1)-loc2(match(ii),1))<20
    line([loc1(ii,2) loc2(match(ii),2)+cols1], ...
         [loc1(ii,1) loc2(match(ii),1)], 'Color', 'c');
     text(loc1(ii,2)-30,loc1(ii,1),num2str(ii),'Color', 'g');
    hold on
    plot(loc1(ii,2), loc1(ii,1),'ro')
    plot(loc2(match(ii),2)+cols1, loc2(match(ii),1),'ro')
    hold off
  end
end
hold off;
num = sum(match > 0);
fprintf('Found %d matches.\n', num);

%%
%����ȷ��һ��ֱ��
% x1=70;
% x2=310;
% d1=loc1(x1,2)-loc2(match(x1),2);
% d2=loc1(x2,2)-loc2(match(x2),2);
% f=391.2136;
% b=144.7853;
% Z1=f*b/d1;%����Ӧ��Ϊxl-xr
% W(1,1)=Z1*(loc1(x1,1)-280.2511)/391.2136;
% W(2,1)=Z1*(loc1(x1,2)-336.5254)/391.3965;
% W(3,1)=Z1;
% Z2=f*b/d2;%����Ӧ��Ϊxl-xr
% % W(1,2)=Z2*(loc2(match(x1),1)-270.2178)/426.3811;
% % W(2,2)=Z2*(loc2(match(x1),2)-349.235)/427.2602;
% % W(3,2)=Z2;
% 
% 
% W(1,2)=Z2*(loc1(x2,1)-280.2511)/391.2136;
% W(2,2)=Z2*(loc1(x2,2)-336.5254)/391.3965;
% W(3,2)=Z2;
% m=sqrt((W(1,1)-W(1,2))^(2)+(W(2,1)-W(2,2))^(2)+(W(3,1)-W(3,2))^(2));
% 
% im3 = appendimages(im1,im2);
% figure('Position', [10 10 size(im3,2) size(im3,1)]);
% colormap('gray');
% imagesc(im3);
% hold on;
% plot(loc1(x1,2), loc1(x1,1),'ro')
% plot(loc1(x2,2), loc1(x2,1),'ro')
% hold off;
% 
% figure;
% plot3(W(1,:),W(2,:),W(3,:),'b','LineWidth',2)
% hold on
% plot3(W(1,:),W(2,:),W(3,:),'ro');


%��ά�ؽ�depth����
[mN,nN]=size(yDepth);
f=focal_length(1,1);
b=baseline;
p_to_camera=[f 0 0 ;
             0 f 0 ;
             0 0 1 ;];
mm=[R          T.';
    zeros(1,3) 1];
WnewT=[];
for ii = 1: length(match)
  if (match(ii) > 0)
    x=loc1(ii,2);
    y=loc1(ii,1);
    Z=f*b/abs(loc1(ii,2)-loc2(match(ii),2));%����Ӧ��Ϊxl-xr
    if Z<5000
     W(1,1)=Z*(x-270.218)/426.3811;
     W(2,1)=Z*(y-349.235)/427.2602;
     W(3,1)=Z;
     WnewT=[WnewT W];      
    end
  end
end
% x1=37;
% x2=84;
% d1=loc1(x1,2)-loc2(match(x1),2);
% d2=loc1(x2,2)-loc2(match(x2),2);
% f=391.2136;
% b=144.7853;
% Z1=f*b/d1;%����Ӧ��Ϊxl-xr
% WW(1,1)=Z1*(loc1(x1,1)-280.2511)/391.2136;
% WW(2,1)=Z1*(loc1(x1,2)-336.5254)/391.3965;
% WW(3,1)=Z1;
% Z2=f*b/d2;%����Ӧ��Ϊxl-xr
% % W(1,2)=Z2*(loc2(match(x1),1)-270.2178)/426.3811;
% % W(2,2)=Z2*(loc2(match(x1),2)-349.235)/427.2602;
% % W(3,2)=Z2;
% 
% 
% WW(1,2)=Z2*(loc1(x2,1)-280.2511)/391.2136;
% WW(2,2)=Z2*(loc1(x2,2)-336.5254)/391.3965;
% WW(3,2)=Z2;


% im3 = appendimages(im1,im2);
% figure('Position', [10 10 size(im3,2) size(im3,1)]);
% colormap('gray');
% imagesc(im3);
% hold on;
% plot(loc1(x1,2), loc1(x1,1),'ro')
% plot(loc1(x2,2), loc1(x2,1),'ro')
% hold off;


figure;
plot3(WnewT(1,:),WnewT(2,:),WnewT(3,:),'bo');
Data=WnewT';%ע������������
Data=single(Data);
ptCloud = pointCloud(Data(:,1:3));
pcwrite(ptCloud, 'test1.pcd', 'Encoding', 'ascii'); %�������е�xyz����д��pcd�ļ���
pc = pcread('test1.pcd');
img=pcread('test1.pcd');
pcwrite(img,'test1.ply');
img=pcread('test1.ply');
pcshow('test1.ply');
pcshow(pc); %��ʾ����

