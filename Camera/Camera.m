%% ��ת����ͷ2.2
% �鿴�������Ѿ���װ��ͼ��������
imaqhwinfo;
%ʹ�ø�����鿴��һ����ȡ����ͼ���������ľ��������
win_info = imaqhwinfo('winvideo');
% ��������ͷ֧�ֵĸ�ʽ��40���֣�������鿴�����ǿ����������в鿴��
win_info.DeviceInfo.SupportedFormats;
%ʹ�����µ�����������һ����Ƶ�������
%adaptorname�����������ƣ����룩deviceID���豸ID�ţ����룩format����Ƶ�ɼ���ʽ������д��ʹ��Ĭ�ϣ�
%���£���Ҫ����USB����ͷ����Ƶ�������
video_obj = videoinput('winvideo',2);%����ͷ���ƣ�'3D USB Camera'
%ʹ�����������Ԥ����Ƶ���󣬸ú������Զ���һ�����ڣ���������ͷ���棺
preview(video_obj)



