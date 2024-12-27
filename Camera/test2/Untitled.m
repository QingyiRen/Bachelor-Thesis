% Auto-generated by stereoCalibrator app on 03-Jun-2021
%-------------------------------------------------------


% Define images to process
imageFileNames1 = {'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard11.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard12.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard21.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard22.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard23.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard24.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard25.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard26.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard3.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard4.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard5.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test2\keyboard6.jpg',...
    };
imageFileNames2 = {'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard11.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard12.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard21.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard22.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard23.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard24.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard25.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard26.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard3.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard4.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard5.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test2\keyboard6.jpg',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames1, imageFileNames2);

% Generate world coordinates of the checkerboard keypoints
squareSize = 25;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Read one of the images from the first stereo pair
I1 = imread(imageFileNames1{1});
[mrows, ncols, ~] = size(I1);

% Calibrate the camera
[stereoParams, pairsUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(stereoParams);

% Visualize pattern locations
h2=figure; showExtrinsics(stereoParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, stereoParams);

% You can use the calibration data to rectify stereo images.
I2 = imread(imageFileNames2{1});
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('StereoCalibrationAndSceneReconstructionExample')
% showdemo('DepthEstimationFromStereoVideoExample')