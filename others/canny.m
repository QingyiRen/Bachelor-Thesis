function tt=canny(trackIn)
global rowM colM
% channel_3=imread(track);%��RGBͼƬ
% image_gray=rgb2gray(channel_3); %RGB��ʽͼƬת��Ϊ�Ҷ�ͼƬ
image_gray=trackIn;%adapthisteq���⻯
[row,col]=size(image_gray);
rowM=row;
colM=col;
% a=randn(row,col);%���ɸ��Ҷ�ת������ԭͼά����ȵĸ�˹�ֲ�����
% R1=(0.1+0.1*(a+1))/2;%��һ�������(1, 2, 3)����ֵ���ֲ���ȽϷ���
% new_gray_channel_1=(R1+double(image_gray)/255);%�����µĻҶȾ���
% new_gray_channel_uint8 = uint8(image_gray);
% new_channe_gus=gaussian(new_gray_channel_uint8,2);
% new_channe_gus = uint8(new_channe_gus);
% new_channe_gus1 = mat_plus1(new_channe_gus,3);
new_gray_channel=image_gray/70;%�����µĻҶȾ���
new_gray_channel_uint8 = uint8(255*new_gray_channel);
% figure;
% imshow(new_gray_channel_uint8);
% disp(new_gray_channel_uint8);
new_channe_gus1 = mat_plus1(new_gray_channel_uint8,3);
for i=1:rowM
    for j=1:colM
        y=singleMatrix(i,j,new_channe_gus1);
        [gx,gy]=sobel(y);
        M(i,j)=sqrt(gx*gx+gy*gy);
        alpha(i,j)=atan(gx/gy);
    end
end
M1 = mat_plus1(M,3);
alpha1 = mat_plus1(alpha,3);
gN=[];
for i=1:rowM
    for j=1:colM
        y=singleMatrix(i,j,M1);
        yy=singleMatrix(i,j,alpha1);
        d1=D1(yy);
        d2=D2(yy);
        d3=D3(yy);
        d4=D4(yy);
        if(d1>d2&&d1>d3&&d1>d4)
            y1=y(2,1);
            y2=y(2,2);
            y3=y(2,3);
            if(y2<y1&&y2<y3)
                gN(i,j)=0;
            else
                gN(i,j)=M(i,j);
            end
        elseif(d2>d1&&d2>d3&&d2>d4)
            y1=y(1,3);
            y2=y(2,2);
            y3=y(3,1);
            if(y2<y1&&y2<y3)
                gN(i,j)=0;
            else
                gN(i,j)=M(i,j);
            end
        elseif(d3>d1&&d3>d2&&d3>d4)
            y1=y(1,2);
            y2=y(2,2);
            y3=y(3,2);
            if(y2<y1&&y2<y3)
                gN(i,j)=0;
            else
                gN(i,j)=M(i,j);
            end
        elseif(d4>d1&&d4>d2&&d4>d3)
            y1=y(1,1);
            y2=y(2,2);
            y3=y(3,3);
            if(y2<y1&&y2<y3)
                gN(i,j)=0;
            else
                gN(i,j)=M(i,j);
            end
        end
     end
end
TL=0.04;
TH=0.1;
gNH=[];
gNL=[];
for i=1:size(gN,1)
    for j=1:size(gN,2)
        if(gN(i,j)>=TH)
             gNH(i,j)=gN(i,j);
             
        else
             gNH(i,j)=0;
        end
        if(gN(i,j)>=TL&&gN(i,j)<TH)
             gNL(i,j)=gN(i,j);
        else
             gNL(i,j)=0;
        end
    end
end
t=gNH+gNL;
tt=uint8(t);
figure(1)
subplot(1,3,1)%������ͼ
imshow(image_gray)
title('�޴���ĻҶ�ͼ��')
subplot(1,3,2)
imshow(new_gray_channel_uint8)
title('���������ĻҶ�ͼ��')
subplot(1,3,3)
imshow(tt)
title('�߿���ȡ')
