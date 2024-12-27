% �����Ӳ�ͼ�ؽ� 3D ͼ
points3D = reconstructScene(double(imgdiff), stereoParams);

% �����뵥λ�� mm -> m
points3D = points3D ./ 1000;

% �洢 3D ͼ�ĵ�������
ptCloud = pointCloud(points3D, 'Color', J1_C3);

% ʹ�� pcplayer �۲����ͼ
player3D = pcplayer([-1, 1], [-1, 1], [0, 2], 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Up');
view(player3D, ptCloud);
%%
% ��ά�ؽ�
points3D = reconstructScene(double(imgdiff), stereoParams);

% Convert to meters and create a pointCloud object
points3D = points3D ./ 1000;
ptCloud = pointCloud(points3D, 'Color', frameLeftRect);

% Create a streaming point cloud viewer
player3D = pcplayer([-3, 3], [-3, 3], [0, 8], 'VerticalAxis', 'y', ...
    'VerticalAxisDir', 'down');

% Visualize the point cloud
view(player3D, ptCloud);