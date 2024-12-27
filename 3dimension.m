% 利用视差图重建 3D 图
points3D = reconstructScene(double(imgdiff), stereoParams);

% 将距离单位由 mm -> m
points3D = points3D ./ 1000;

% 存储 3D 图的点云数据
ptCloud = pointCloud(points3D, 'Color', J1_C3);

% 使用 pcplayer 观察点云图
player3D = pcplayer([-1, 1], [-1, 1], [0, 2], 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Up');
view(player3D, ptCloud);
%%
% 三维重建
points3D = reconstructScene(double(imgdiff), stereoParams);

% Convert to meters and create a pointCloud object
points3D = points3D ./ 1000;
ptCloud = pointCloud(points3D, 'Color', frameLeftRect);

% Create a streaming point cloud viewer
player3D = pcplayer([-3, 3], [-3, 3], [0, 8], 'VerticalAxis', 'y', ...
    'VerticalAxisDir', 'down');

% Visualize the point cloud
view(player3D, ptCloud);