% 使用 imtool 确定视差范围值（max=93.5），这里取 128，（具体操作见说明）
disparityRange = [0, 128];

% 利用矫正后的灰度图生成视差图
J1_C1 = correct_imgL;
J2_C1 = correct_imgR;

% 利用矫正后的左右图生成立体图像
Anaglyph = stereoAnaglyph(J1_C1, J2_C1);
figure; 
imshow(Anaglyph);

left=double(rgb2gray(correct_imgL));
right=double(rgb2gray(correct_imgR));

[m,n]=size(left);
im1=double(rgb2gray(correct_imgL));
im2=double(rgb2gray(correct_imgR));

D=20; %最大视差
N=9; %窗口半径
[H,W]=size(im1);

%计算右图减去左图，相减产生D个矩阵放到imgDiff中
imgDiff=zeros(H,W,D);
e=zeros(H,W);
for i=1:D
    e(:,1:(W-i))=abs(im2(:,1:(W-i))- im1(:,(i+1):W));
    e2=zeros(H,W);%计算窗口内的和
    for y=(N+1):(H-N)
        for x=(N+1):(W-N)
            e2(y,x)=sum(sum(e((y-N):(y+N),(x-N):(x+N))));
        end
    end
    imgDiff(:,:,i)=e2;
end

%找到最小的视差，到dispMap 
dispMap=zeros(H,W); 
for x=1:W
   for y=1:H
       [val,id]=sort(imgDiff(y,x,:));
        if abs(val(1)-val(2))>10
            dispMap(y,x)=id(1);
        end
    end
end
%显示
imshow(dispMap,[]);
% w=3;       %窗口半径
% depth=20;    %最大偏移距离，同样也是最大深度距离
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
%        [junk,imgn(i,j)]=min(tmp);   %获得最小位置的索引
%    end
% end
% imshow(imgn,[]);
