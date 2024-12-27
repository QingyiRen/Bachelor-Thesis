%Census
left=double(rgb2gray(imread('D:\蠢猪猪\蠢猪猪\test1.jpg')));
right=double(rgb2gray(imread('D:\蠢猪猪\蠢猪猪\test2.jpg')));
new_image_R=right;
new_image_L=left;
[B, A, C] = size(new_image_L);

windowsize = 5;
win = (windowsize -1)/2;
D_min = 5;
D_max = 60;


for b = win+1 : B-win
    for a = win+1 : (A-win-D_max)
        %左图census变换
        var_r = zeros(1,windowsize^2);
        parallax = D_min; hamm_data =10000; hamm=0;
        for m = -win : 1 : win
            for n = -win : 1:  win
                if(new_image_R(b+m,a+n) <= new_image_R(b,a))
                    var_r(1,windowsize*n+m+41) = 1;
                else
                    var_r(1,windowsize*n+m+41) = 0;
                end
            end
        end
        %对右图进行变换
        
        for d = D_min : 1 : D_max
            var_l = zeros(1,windowsize^2);
            hamm_value = 0;
            for m = -win : 1 : win
                for n = -win : 1:  win
                    if(new_image_L(b+m,d+a+n) <= new_image_L(b,d+a))
                        var_l(1,windowsize*n+m+41) = 1;
                    else
                        var_l(1,windowsize*n+m+41) = 0;
                    end
                end
            end
            %汉明距离计算
            hamm = xor(var_l,var_r);
            hamm_value = sum(hamm(:) == 1);
            
            if(hamm_data > hamm_value)
                hamm_data = hamm_value;   
                parallax = d;%得到视差值  
            end   
        end
        parallax_image(b-win,a-win)= parallax;
        
    end
end

% dispMap = mat2gray(parallax_image);
% B=medfilt2(dispMap,[5 5]);%中值滤波，滤波器窗口[9 9]
imshow(parallax_image,[]);
% [mN,nN]=size(parallax_image);
% f=391.2136;
% b=144.7853;
% p_to_camera=[f 0 0 ;
%              0 f 0 ;
%              0 0 1 ;];
% mm=[R          T.';
%     zeros(1,3) 1];
% WnewT=[];
% for i=1:size(fengSet,2)
%         x=fengSet(1,i);
%         y=fengSet(2,i);
%         if parallax_image(x,y)~=0
%             disp(parallax_image(x,y));
%           Z=f*b/parallax_image(x,y);%出错，应该为xl-xr
%           if Z<1500&&Z>1000
%           W(1,1)=Z*(x-280.2511)/391.2136;
%           W(2,1)=Z*(y-336.5254)/391.3965;
%           W(3,1)=Z;
%            if W(2,1)>360&&W(2,1)<500
%               WnewT=[WnewT W];
%            end
%           end
% %         else
% %           WnewT=[WnewT zeros(3,1)];
%         end
% end
% figure;
% plot3(WnewT(1,:),WnewT(2,:),WnewT(3,:),'bo');
% hold on
% plot3(WnewT(1,3),WnewT(2,3),WnewT(3,3),'ro');
% hold on
% plot3(WnewT(1,31),WnewT(2,31),WnewT(3,31),'ro')
% hold on
% m=sqrt((WnewT(1,3)-WnewT(1,31))^(2)+(WnewT(2,3)-WnewT(2,31))^(2)+(WnewT(3,3)-WnewT(3,31))^(2));

%%
%两点确定一条直线
% figure;
% flag=[2 240];
% for i=1:2
%         x=fengSet(1,flag(1,i));
%         y=fengSet(2,flag(1,i));
%           W(1,i)=Z*(x-280.2511)/391.2136;
%           W(2,i)=Z*(y-336.5254)/391.3965;
%           W(3,i)=Z;
%           plot3(W(1,i),W(2,i),W(3,i),'ro');
%           hold on
% end
% m=sqrt((W(1,1)-W(1,2))^(2)+(W(2,1)-W(2,2))^(2)+(W(3,1)-W(3,2))^(2));
% figure;
% plot3(W(1,:),W(2,:),W(3,:),'b','LineWidth',2)
% hold on
% plot3(W(1,:),W(2,:),W(3,:),'ro')

%三维重建depth方法
yDepth=parallax_image;
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
          if Z<5000
          W(1,1)=Z*(i-270.218)/426.3811;
          W(2,1)=Z*(j-349.235)/427.2602;
          W(3,1)=Z;
          WnewT=[WnewT W];
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







