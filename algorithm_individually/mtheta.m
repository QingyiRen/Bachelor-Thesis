function [m,n] = mtheta(window)
xlength=window(2,3)-window(2,1);
ylength=window(3,2)-window(1,2);
m=sqrt(xlength^(2)+ylength^(2));
n=atan2(ylength,xlength)*180/pi;
if -180<n&&n<0
    n=n+360;
elseif n==90
    n=0;
elseif n==90
    n=180;
end

