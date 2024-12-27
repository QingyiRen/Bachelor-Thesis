%% 玩转摄像头2.2
% 查看电脑上已经安装的图像适配器
imaqhwinfo;
%使用该命令查看上一步获取到的图像适配器的具体参数：
win_info = imaqhwinfo('winvideo');
% 这里摄像头支持的格式有40多种，不方便查看，我们可以在命令行查看：
win_info.DeviceInfo.SupportedFormats;
%使用如下的命令来创建一个视频输入对象：
%adaptorname：适配器名称（必须）deviceID：设备ID号（必须）format：视频采集格式（不填写则使用默认）
%如下，我要创建USB摄像头的视频输入对象：
video_obj = videoinput('winvideo',2);%摄像头名称：'3D USB Camera'
%使用如下命令即可预览视频对象，该函数会自动打开一个窗口，播放摄像头画面：
preview(video_obj)



