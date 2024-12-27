function y = radius(s)
rou=1.5*rou_oct(s);%当前层的尺度信息
y=round(3*rou);%当前点的窗口半径
