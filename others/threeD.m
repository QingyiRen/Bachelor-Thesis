% 利用视差图重建3D
%% Reconstruct the 3-D Scene
disparityMap=imresize(yDepth,[551 781]);%将图片尺度归一化为551*781imgdiff_histeqN;
imshow(disparityMap);
% Reconstruct the 3-D world coordinates of points corresponding to each
% pixel from the disparity map.
pointCloud = reconstructScene(disparityMap, stereoParams);


% Convert from millimeters to meters.
pointCloud = pointCloud / 1000;
%% Visualize the 3-D Scene
%Plot the 3-D points by calling the plot3 function. We have to call the
%function in a loop for each color, because it can only plot points of a
%single color at a time. To minimize the number of iteration of the loop,
%reduce the number of colors in the image by calling rgb2ind.


% Reduce the number of colors in the image to 128.
[reducedColorImage, reducedColorMap] = rgb2ind(J1, 128);


%这里的坐标是怎么回事？840 630？
% Plot the 3D points of each color.
hFig = figure; hold on;
set(hFig, 'Position', [1 1 840 630]);
hAxes = gca;


X = pointCloud(:, :, 1);
Y = pointCloud(:, :, 2);
Z = pointCloud(:, :, 3);

Wnew=[];
for i = 1:size(reducedColorMap, 1)
% Find the pixels of the current color.
x = X(reducedColorImage == i-1);
y = Y(reducedColorImage == i-1);
z = Z(reducedColorImage == i-1);


 if isempty(x)
    continue;
 end


% Eliminate invalid values.
idx = isfinite(x);
x = x(idx);
y = y(idx);
z = z(idx);


 % Plot points between 3 and 7 meters away from the camera.
maxZ = 7;
minZ = 2;
x = x(z > minZ & z < maxZ);
y = y(z > minZ & z < maxZ);
z = z(z > minZ & z < maxZ);
plot3(hAxes, x, y, z, '.', 'MarkerEdgeColor', reducedColorMap(i, :));
hold on;
end
Wnew=[x y z];
[m,n]=size(Wnew);
% [m,n]=size(Wnew);
fid=fopen('1.txt','w');%写入文件路径
 for i=1:m
    for j=1:1:n
       if j==n
         fprintf(fid,'%g\n',Wnew(i,j));
      else
        fprintf(fid,'%g\t',Wnew(i,j));
       end
    end
 end
fclose(fid);

% Set up the view.
grid on;
cameratoolbar show;
axis vis3d
axis equal;
set(hAxes,'YDir','reverse', 'ZDir', 'reverse');
camorbit(-20, 25, 'camera', [0 1 0]);
