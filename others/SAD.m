% left=double(rgb2gray(imread('C:\Users\��С��\Desktop\����\test1.jpg')));
% right=double(rgb2gray(imread('C:\Users\��С��\Desktop\����\test2.jpg')));
% left=canny('C:\Users\��С��\Desktop\����\test1.jpg');
% right=canny('C:\Users\��С��\Desktop\����\test2.jpg');

left=double(rgb2gray(imread('D:\������\������\test1.jpg')));
right=double(rgb2gray(imread('D:\������\������\test2.jpg')));
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
D=20; %����Ӳ�
N=3; %���ڰ뾶
[H,W]=size(left);
%������ͼ��ȥ��ͼ���������D������ŵ�imgDiff��
imgDiff=zeros(H,W,D);
e=zeros(H,W);
for i=1:D
    e(:,1:(W-i))=abs(right(:,1:(W-i))- left(:,(i+1):W));
    e2=zeros(H,W);%���㴰���ڵĺ�
    for y=(N+1):(H-N)
        for x=(N+1):(W-N)
            e2(y,x)=sum(sum(e((y-N):(y+N),(x-N):(x+N))));
        end
    end
    imgDiff(:,:,i)=e2;
end

%�ҵ���С���Ӳ��dispMap 
dispMapR=zeros(H,W); 
for x=1:W
   for y=1:H
       [val,id]=sort(imgDiff(y,x,:));
        if abs(val(1)-val(2))>5
           dleft=id(1)-1;%�ҵ�������ڵĲ���
           dright=id(1)+1;%�ҵ��ұ����ڵĲ���
           if dright>20
             dispMapR(y,x)=id(1);
           elseif dleft<1
             dispMapR(y,x)=id(1);
           else
            dfinal=id(1)+(imgDiff(y,x,dright)-imgDiff(y,x,dleft))/2/(imgDiff(y,x,dright)+imgDiff(y,x,dleft)-2*id(1));%���������
            dispMapR(y,x)=dfinal;
            end
        end   
    end
end
imshow(dispMapR,[]);
windowsize=3;
for i=1:W %���Ǵ��۾ۺ�
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
% for i=1:W %�׶����
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
% I_noise=double(imnoise(I,'salt & pepper',0.02));%salt & pepperע���м�Ŀո� �޿ո񱨴�
% imshow(I_noise,[]);
% title('��������');
% %��ֵ�˲�
% subplot(2,3,3);
% I_3=fspecial('average',[3,3]);%3*3��ֵ�˲�
% I_3=imfilter(yDepth,I_3);
% imshow(I_3,[]);title('3*3������ֵ�˲�');
%��ʾ

% left=rgb2gray(imread('C:\Users\��С��\Desktop\����\test1.jpg'));
% right=rgb2gray(imread('C:\Users\��С��\Desktop\����\test2.jpg'));
% disparityRange = [0 32];
% disparityMap = disparity(left,right,'BlockSize',5,'DisparityRange',disparityRange,'Method','SemiGlobal');
% 
% imshow(yDepth,[]);
% yDepth=disparityMap;
% imshow(dispMap,[]);
%%
% %��ά�ؽ�depth����
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
%           Z=f*b/yDepth(x,y);%����Ӧ��Ϊxl-xr
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
% Data=WnewT';%ע������������
% Data=single(Data);
% ptCloud = pointCloud(Data(:,1:3));
% pcwrite(ptCloud, 'test.pcd', 'Encoding', 'ascii'); %�������е�xyz����д��pcd�ļ���
% pc = pcread('test.pcd');
% img=pcread('test.pcd');
% pcwrite(img,'test.ply');
% img=pcread('test.ply');
% pcshow('test.ply');
% pcshow(pc); %��ʾ����

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
for i=1:mN
    for j=1:nN
        if yDepth(i,j)~=0
          Z=f*b/yDepth(i,j);%����Ӧ��Ϊxl-xr
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
Data=WnewT';%ע������������
Data=single(Data);
ptCloud = pointCloud(Data(:,1:3));
pcwrite(ptCloud, 'test.pcd', 'Encoding', 'ascii'); %�������е�xyz����д��pcd�ļ���
pc = pcread('test.pcd');
img=pcread('test.pcd');
pcwrite(img,'test.ply');
img=pcread('test.ply');
pcshow('test.ply');
pcshow(pc); %��ʾ����
