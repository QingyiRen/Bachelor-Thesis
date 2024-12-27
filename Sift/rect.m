% cameraParams = calibrationSession.CameraParameters;  %������Ҫ����CameraParameters
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
imgL=imread('C:\Users\��С��\Desktop\����\Camera\left_pic\hanfeng1.jpg');
[correct_imgL,~]=undistortImage(imgL,cameraParams.CameraParameters1);%�������������
imwrite(correct_imgL,'test1.jpg');
imgR=imread('C:\Users\��С��\Desktop\����\Camera\right_pic\hanfeng1.jpg');
[correct_imgR,~]=undistortImage(imgR,cameraParams.CameraParameters2);%�������������
imwrite(correct_imgR,'test2.jpg');
figure(1);
R_cat_L=Horcatimg(correct_imgL,correct_imgR);%ˮƽƴ�Ӻ������ⲿ����
imshow(uint8(R_cat_L));
[m,n,p] = size(uint8(R_cat_L));
hold on
M = 30;  % ˮƽ����
N = 8;  % ��ֱ����
lw = 0.5;  % ���߿��
mx = ones(1,M+1);
my = linspace(1,m,M+1);
% ��ˮƽ��
for k = 1:M+1
    line([mx(k) n*mx(k)],[my(k) my(k)],'color','m','LineWidth',lw);
end
nx = linspace(1,n,N+1);
ny = ones(1,N+1);
% ����ֱ��
for k = 1:N+1
    line([nx(k) nx(k)],[ny(k) m*ny(k)],'color','m','LineWidth',lw);
end
