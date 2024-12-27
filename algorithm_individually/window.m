function result = window(img_below,img_now,img_above,x,y,~)
global maxum
window_below=img_below((x-1):(x+1),(y-1):(y+1));
window_now=img_now((x-1):(x+1),(y-1):(y+1));
window_above=img_above((x-1):(x+1),(y-1):(y+1));
flag=window_now(2,2);% 中心点
window=[window_below window_now window_above];
Minval=min(min(window));% 极小值
Maxval=max(max(window));% 极大值

Dxx=window_now(2,1)+window_now(2,3)-2*flag;%f1+f3-2f0
Dyy=window_now(1,2)+window_now(3,2)-2*flag;%f2+f4-2f0
Dxy=(window_now(1,1)+window_now(3,3)-window_now(1,3)-window_now(3,1))/4;%(f8+f6-f5-f7)/4
Hessian2=[Dxx Dxy;
          Dxy Dyy];
 Tr=trace(Hessian2);
 Det=det(Hessian2);

 if Tr^(2)/Det<maxum%&&panduan==1 %排除边缘点
     if flag<=Minval||flag>=Maxval
        result=1;
     else
        result=0;
     end
 else
     result=0;
 end