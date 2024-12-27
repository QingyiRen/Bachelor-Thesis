clc
clear
close all
L1=Link([0 400 25 pi/2 0],'standard');
L2=Link([pi/2 0 480 pi 0],'standard');
L3=Link([0 0 25 -pi/2 0],'standard');
L4=Link([0 420 0 pi/2 0],'standard');
L5=Link([0 0 0 pi/2 0],'standard');
L6=Link([0 90 0 0 0],'standard');
% L1 = Link('d', 0.15, 'a', 0, 'alpha', 0.25);%定义连杆
% L2 = Link('d', 0.55, 'a', 0, 'alpha', 0);
% L3 = Link('theta', 0.16, 'a', 0, 'alpha', 0);
% L4 = Link('d', 0, 'a', 0, 'alpha', 0.594);
% L5 = Link('d', 0, 'a', 0, 'alpha',0);
% L6 = Link('d', 0, 'a', 0, 'alpha', 0);
% theta=[0 pi/2 0 0 0 0];
% qj=SerialLink({L1 L2 L3 L4 L5 L6});%生成机器人三维图形
% qj.name='M';
% drivebot(qj)
bot = SerialLink([L1 L2 L3 L4 L5 L6]);%连接连杆
bot.display();%显示D-H参数表
% bot.plot(theta,'tile1color',[0 255 255],'tile2color',[255 251 0]);
teach(bot);
t=[0 0.05 2];
T1=transl(0.86, 0,-0.344);
T2=[-0.05 -0.08  0 -0.3;
    -0.05 -0.08  0 -0.3;
    -0.05 -0.08  0 -0.3;
    0 0 0 1];
T=ctraj(T1,T2,length(t));
q=ikine(bot,T);
T=fkine(bot,q);





