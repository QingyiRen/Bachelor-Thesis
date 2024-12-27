% ʹ�� imtool ȷ���ӲΧֵ��max=93.5��������ȡ 128�������������˵����
disparityRange = [0, 128];

% ���ý�����ĻҶ�ͼ�����Ӳ�ͼ
J1_C1 = correct_imgL;
J2_C1 = correct_imgR;

% ���ý����������ͼ��������ͼ��
Anaglyph = stereoAnaglyph(J1_C1, J2_C1);
figure; 
imshow(Anaglyph);

left=double(rgb2gray(correct_imgL));
right=double(rgb2gray(correct_imgR));

[m,n]=size(left);
im1=double(rgb2gray(correct_imgL));
im2=double(rgb2gray(correct_imgR));

D=20; %����Ӳ�
N=9; %���ڰ뾶
[H,W]=size(im1);

%������ͼ��ȥ��ͼ���������D������ŵ�imgDiff��
imgDiff=zeros(H,W,D);
e=zeros(H,W);
for i=1:D
    e(:,1:(W-i))=abs(im2(:,1:(W-i))- im1(:,(i+1):W));
    e2=zeros(H,W);%���㴰���ڵĺ�
    for y=(N+1):(H-N)
        for x=(N+1):(W-N)
            e2(y,x)=sum(sum(e((y-N):(y+N),(x-N):(x+N))));
        end
    end
    imgDiff(:,:,i)=e2;
end

%�ҵ���С���Ӳ��dispMap 
dispMap=zeros(H,W); 
for x=1:W
   for y=1:H
       [val,id]=sort(imgDiff(y,x,:));
        if abs(val(1)-val(2))>10
            dispMap(y,x)=id(1);
        end
    end
end
%��ʾ
imshow(dispMap,[]);
% w=3;       %���ڰ뾶
% depth=20;    %���ƫ�ƾ��룬ͬ��Ҳ�������Ⱦ���
% imgn=zeros(m,n);
% for i=1+w:m-w
%    for j=1+w+depth:n-w 
%        tmp=[];
%        lwin=left(i-w:i+w,j-w:j+w);
%        for k=0:-1:-depth        
%            rwin=right(i-w:i+w,j-w+k:j+w+k);
%            diff=lwin-rwin;
%            tmp=[tmp sum(abs(diff(:)))];
%        end
%        [junk,imgn(i,j)]=min(tmp);   %�����Сλ�õ�����
%    end
% end
% imshow(imgn,[]);
