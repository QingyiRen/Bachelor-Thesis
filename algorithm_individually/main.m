global rou0 S N maxum
rou0=1.6;
S=3;
N=2;
r=9;%��������ֵ��������Ե��
maxum=(r+1)^(2)/r;
track='C:\Users\��С��\Desktop\����\test1.jpg';
channel_1=imread(track);%��RGBͼƬ
channel_2 = imresize(channel_1,[512 512]);%��ͼƬ�߶ȹ�һ��Ϊ512*512
image_gray=rgb2gray(channel_2); %RGB��ʽͼƬת��Ϊ�Ҷ�ͼƬ
% image_gray = imresize(image_gray,[512 512]);%��ͼƬ�߶ȹ�һ��Ϊ512*512
rou_n=0.5;
img=L(rou_n,image_gray);
newimg=double(img)/255;
img_adap=adapthisteq(newimg);%adapthisteq���⻯��õ�����ͼ��
% img_adap=2.*img_adap;%˫�����ڲ巨������ͼ����������
imshow(img_adap);
firstlayer=img_adap;
for k=1:7
 for i=0:5
    if i==0
        img_before=firstlayer;
    end
    sigma=SigmaDiff(i);
    y = L(sigma,img_before);
    newimg=y;
    img_pyramid(k,i+1)=mat2cell(newimg,2^(10-k),2^(10-k));% ��˹������
    img_before=y;
    if i==3
        firstlayer=dsample(newimg,N) ;
    end
 end
end
for k=1:7
    for i=1:5
        imgD=cell2mat(img_pyramid(k,i+1))-cell2mat(img_pyramid(k,i));%
        imgD = guiyihua(imgD);
        imgD=adapthisteq(imgD);%adapthisteq���⻯��õ�����ͼ��
        img_diff(k,i)=mat2cell(imgD,2^(10-k),2^(10-k));% ��˹��ֽ�����
    end
end
for k=1:7
    a=extremum(img_diff,k);
    key(1,k) = mat2cell(a,3);
    switch k
        case 1
            key1=a;
        case 2
            key2=a;
        case 3
            key3=a;
        case 4
            key4=a;
        case 5
            key5=a;
        case 6
            key6=a;
        case 7
            key7=a;
    end
end
aaa=cell2mat(img_pyramid(2,1));
for smooth_layer=1:3
    img_p{smooth_layer}=cell2mat(img_diff(1,smooth_layer));
end
% figure(2)
% imshow(ccc);
[m,n]=size(key1);
figure(3)
imshow(img_p{1});
for i=1:n
    hold on
%     circle(key1(1,n),key1(2,n),1); %���û�ԲȦ�ĺ���
% hFigure = figure('Visible', 'on', 'Position', [0 0 600 500]);
% movegui(hFigure, 'center');
% hAxes = axes('Visible', 'off', 'Position', [0.01 0.2 0.98 0.79], 'Drawmode', 'fast');
% imshow(channel_2);
    t = 0:2*pi/20:2*pi;
    x = key1(2,i) + 2*sin(t);
    y = key1(1,i) + 2*cos(t);
    plot(x,y);
    hold on
end

