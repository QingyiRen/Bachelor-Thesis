% Auto-generated by stereoCalibrator app on 03-Jun-2021
%-------------------------------------------------------


% Define images to process
imageFileNames1 = {'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi1.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi10.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi11.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi12.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi13.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi14.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi15.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi18.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi2.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi20.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi21.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi22.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi23.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi24.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi25.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi26.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi27.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi28.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi30.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi31.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi32.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi33.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi34.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi35.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi37.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi38.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi39.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi4.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi40.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi41.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi5.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi6.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi7.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\left_pic\test3\testQi8.jpg',...
    };
imageFileNames2 = {'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi1.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi10.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi11.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi12.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi13.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi14.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi15.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi18.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi2.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi20.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi21.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi22.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi23.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi24.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi25.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi26.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi27.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi28.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi30.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi31.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi32.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi33.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi34.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi35.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi37.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi38.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi39.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi4.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi40.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi41.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi5.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi6.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi7.jpg',...
    'C:\Users\任小猪\Desktop\毕设\Camera\right_pic\test3\testQi8.jpg',...
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