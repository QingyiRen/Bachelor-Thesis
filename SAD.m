% left=double(rgb2gray(imread('C:\Users\任小猪\Desktop\毕设\test1.jpg')));
% right=double(rgb2gray(imread('C:\Users\任小猪\Desktop\毕设\test2.jpg')));
% left=canny('C:\Users\任小猪\Desktop\毕设\test1.jpg');
% right=canny('C:\Users\任小猪\Desktop\毕设\test2.jpg');

left=double(rgb2gray(imread('D:\蠢猪猪\蠢猪猪\test1.jpg')));
right=double(rgb2gray(imread('D:\蠢猪猪\蠢猪猪\test2.jpg')));
% for i=1:size(left,1)
%     for j=1:size(left,2)
%         if(left(i,j)<=150)
%             left(i,j)=0;
%         end
%         if(right(i,j)<=150)
%             right(i,j)=0;
%         end
%     end
% end
% imshow(left);
% right=medfilt2(right,[3,3]);
% imshow(right);
D=20; %最大视差
N=3; %窗口半径
[H,W]=size(left);
%计算右图减去左图，相减产生D个矩阵放到imgDiff中
imgDiff=zeros(H,W,D);
e=zeros(H,W);
for i=1:D
    e(:,1:(W-i))=abs(right(:,1:(W-i))- left(:,(i+1):W));
    e2=zeros(H,W);%计算窗口内的和
    for y=(N+1):(H-N)
        for x=(N+1):(W-N)
            e2(y,x)=sum(sum(e((y-N):(y+N),(x-N):(x+N))));
        end
    end
    imgDiff(:,:,i)=e2;
end

%找到最小的视差，到dispMap 
dispMapR=zeros(H,W); 
for x=1:W
   for y=1:H
       [val,id]=sort(imgDiff(y,x,:));
        if abs(val(1)-val(2))>5
           dleft=id(1)-1;%找到左边所在的层数
           dright=id(1)+1;%找到右边所在的层数
           if dright>20
             dispMapR(y,x)=id(1);
           elseif dleft<1
             dispMapR(y,x)=id(1);
           else
            dfinal=id(1)+(imgDiff(y,x,dright)-imgDiff(y,x,dleft))/2/(imgDiff(y,x,dright)+imgDiff(y,x,dleft)-2*id(1));%子像素拟合
            dispMapR(y,x)=dfinal;
            end
        end   
    end
end
imshow(dispMapR,[]);
windowsize=3;
for i=1:W %考虑代价聚合
    for j=1:H
            ywindow=windowS(j,i,dispMapR,windowsize);
            leftwindow=windowS(j,i,left,windowsize);
            yDepth(j,i)=Bifilter(ywindow,leftwindow);
    end
end
imshow(yDepth,[]);
% Inte_img = Integral_Image(yDepth);
% Wsize=5;
% radius=1;
% for i=1:W %孔洞填充
%     for j=1:H
%         if yDepth(j,i)==0
%             sum=0;
%             if (j+radius)<H&&(i+radius)<W&&(j-radius)>0&&(i-radius)>0
%                 yDepthFull(j,i)=0;
%                 num=0;
%                 for pp=-radius:radius
%                     for qq=-radius:radius
%                         sum=sum+yDepth(j+qq,i+pp);
%                         if(yDepth(j+qq,i+pp)~=0)
%                             num=num+1;
%                         end
%                     end
%                 end
%                 yDepthFull(j,i)=sum/num;
%             else
%                 yDepthFull(j,i)=yDepth(j,i);
%             end
% %             Inte_img(j,i);
%         end
%     end
% end
% imshow(yDepthFull,[]);
% I_noise=double(imnoise(I,'salt & pepper',0.02));%salt & pepper注意中间的空格 无空格报错
% imshow(I_noise,[]);
% title('椒盐噪声');
% %均值滤波
% subplot(2,3,3);
% I_3=fspecial('average',[3,3]);%3*3均值滤波
% I_3=imfilter(yDepth,I_3);
% imshow(I_3,[]);title('3*3算数均值滤波');
%显示

% left=rgb2gray(imread('C:\Users\任小猪\Desktop\毕设\test1.jpg'));
% right=rgb2gray(imread('C:\Users\任小猪\Desktop\毕设\test2.jpg'));
% disparityRange = [0 32];
% disparityMap = disparity(left,right,'BlockSize',5,'DisparityRange',disparityRange,'Method','SemiGlobal');
% 
% imshow(yDepth,[]);
% yDepth=disparityMap;
% imshow(dispMap,[]);
%%
% %三维重建depth方法
% [mN,nN]=size(yDepth);
% f=focal_length(1,1);
% b=baseline;
% p_to_camera=[f 0 0 ;
%              0 f 0 ;
%              0 0 1 ;];
% mm=[R          T.';
%     zeros(1,3) 1];
% WnewT=[];
% for i=1:size(fengSet,2)
%         x=fengSet(1,i);
%         y=fengSet(2,i);
%         if yDepth(x,y)~=0
%             disp(yDepth(x,y));
%           Z=f*b/yDepth(x,y);%出错，应该为xl-xr
%           if Z<5000
%           W(1,1)=Z*(x-270.218)/426.3811;
%           W(2,1)=Z*(y-349.235)/427.2602;
%           W(3,1)=Z;
%           WnewT=[WnewT W];
%           end
% %         else
% %           WnewT=[WnewT zeros(3,1)];
%         end
% end
% figure;
% plot3(WnewT(1,:),WnewT(2,:),WnewT(3,:),'b.');
% Data=WnewT';%注意有求逆运算
% Data=single(Data);
% ptCloud = pointCloud(Data(:,1:3));
% pcwrite(ptCloud, 'test.pcd', 'Encoding', 'ascii'); %将程序中的xyz数据写入pcd文件中
% pc = pcread('test.pcd');
% img=pcread('test.pcd');
% pcwrite(img,'test.ply');
% img=pcread('test.ply');
% pcshow('test.ply');
% pcshow(pc); %显示点云

%三维重建depth方法
[mN,nN]=size(yDepth);
f=focal_length(1,1);
b=baseline;
p_to_camera=[f 0 0 ;
             0 f 0 ;
             0 0 1 ;];
mm=[R          T.';
    zeros(1,3) 1];
WnewT=[];
for i=1:mN
    for j=1:nN
        if yDepth(i,j)~=0
          Z=f*b/yDepth(i,j);%出错，应该为xl-xr
          if Z<40000
          W(1,1)=Z*(i-270.218)/426.3811;
          W(2,1)=Z*(j-349.235)/427.2602;
          W(3,1)=Z;
            if W(1,1)<2000&&W(1,1)>-4000&&W(2,1)<5000&&W(2,1)>-6000
             WnewT=[WnewT W];
            end
          end
%         else
%           WnewT=[WnewT zeros(3,1)];
        end
    end
end
figure;
plot3(WnewT(1,:),WnewT(2,:),WnewT(3,:),'b.');
Data=WnewT';%注意有求逆运算
Data=single(Data);
ptCloud = pointCloud(Data(:,1:3));
pcwrite(ptCloud, 'test.pcd', 'Encoding', 'ascii'); %将程序中的xyz数据写入pcd文件中
pc = pcread('test.pcd');
img=pcread('test.pcd');
pcwrite(img,'test.ply');
img=pcread('test.ply');
pcshow('test.ply');
pcshow(pc); %显示点云
