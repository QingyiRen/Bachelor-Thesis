%cat img pair in Horizontal,ˮƽƴ�������ߴ粻ͬ��ͼ��
%Arguments:
%   img1,img2 - image matrix, make sure img1&img1 are both gray level
%
%   ��������ͼ��ľ���
%return:
%   imgout - image matrix cat img1 & img2 in Horizontal
%   
%   ���ˮƽƴ�Ӻ������ͼƬ
%
%Chen Honghan 2011-08-17
function imgout=Horcatimg(img1,img2)
[c1,r1,d1]=size(img1);
[c2,r2,d2]=size(img2);
if d1~=d2
    imgout=NaN;
    return;
end 
cMax=max(c1,c2);
if c1<cMax
   imgtmp=zeros(cMax,r1,d1);
   imgtmp(1:c1,1:r1,1:d1)=img1;
   Ia=imgtmp;
else
   Ia=img1;
end
if c2<cMax
   imgtmp=zeros(cMax,r2,d2);
   imgtmp(1:c2,1:r2,1:d2)=img2;
   Ib=imgtmp; 
else
    Ib=img2;
end
imgout=cat(2,Ia,Ib);