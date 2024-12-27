% cameraParams = calibrationSession.CameraParameters;  %我们需要的是CameraParameters
% import numpy as np
% class USB_Camera(object): 
% def __init__(self):
cam_matrix_left = calibrationSession.CameraParameters.CameraParameters1.IntrinsicMatrix;
distortion_l = calibrationSession.CameraParameters.CameraParameters1.RadialDistortion;
cam_matrix_right = calibrationSession.CameraParameters.CameraParameters2.IntrinsicMatrix;
distortion_r = calibrationSession.CameraParameters.CameraParameters2.RadialDistortion;
R = calibrationSession.CameraParameters.RotationOfCamera2;
T = calibrationSession.CameraParameters.TranslationOfCamera2;
focal_length = calibrationSession.CameraParameters.CameraParameters1.FocalLength;
baseline = abs(calibrationSession.CameraParameters.TranslationOfCamera2(1));
imgL=imread('C:\Users\任小猪\Desktop\毕设\Camera\left_pic\hanfeng1.jpg');
[correct_imgL,~]=undistortImage(imgL,cameraParams.CameraParameters1);%调用了相机参数
imwrite(correct_imgL,'test1.jpg');
imgR=imread('C:\Users\任小猪\Desktop\毕设\Camera\right_pic\hanfeng1.jpg');
[correct_imgR,~]=undistortImage(imgR,cameraParams.CameraParameters2);%调用了相机参数
imwrite(correct_imgR,'test2.jpg');
figure(1);
R_cat_L=Horcatimg(correct_imgL,correct_imgR);%水平拼接函数，外部导入
imshow(uint8(R_cat_L));
[m,n,p] = size(uint8(R_cat_L));
hold on
M = 30;  % 水平分量
N = 8;  % 垂直分量
lw = 0.5;  % 划线宽度
mx = ones(1,M+1);
my = linspace(1,m,M+1);
% 画水平线
for k = 1:M+1
    line([mx(k) n*mx(k)],[my(k) my(k)],'color','m','LineWidth',lw);
end
nx = linspace(1,n,N+1);
ny = ones(1,N+1);
% 画垂直线
for k = 1:N+1
    line([nx(k) nx(k)],[ny(k) m*ny(k)],'color','m','LineWidth',lw);
end
