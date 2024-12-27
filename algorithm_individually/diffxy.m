function dz = diffxy(window_now)
Dx=(window_now(2,3)-window_now(2,1))/2;
Dy=(window_now(3,2)-window_now(1,2))/2;
Dxx=window_now(2,1)+window_now(2,3)-2*window_now(2,2);%f1+f3-2f0
Dyy=window_now(1,2)+window_now(3,2)-2*window_now(2,2);%f2+f4-2f0
Dxy=(window_now(1,1)+window_now(3,3)-window_now(1,3)-window_now(3,1))/4;%(f8+f6-f5-f7)/4
Hessian2=[Dxx Dxy
          Dxy Dyy];
dz=-inv(Hessian2)*[Dx;Dy];
