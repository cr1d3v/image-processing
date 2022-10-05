% cr1d3v
% Exercise:     q3.m
% Edited:       02.07.2021

% Loading MainImg
MainImg = imread('testImage.bmp');

% M- rows and N- column values
M=size(MainImg,1);
N=size(MainImg,2);

% creating a masked Img
[BW,maskedRGBImage] = maskedImg(MainImg);

function [BW,maskedRGBImage] = maskedImg(RGB)
%------------------------------------------------------

% RGB to chosen colour space
MainImg=RGB;

% Define thresholds for channel 1 based on histogram settings
channel1Min = 196.000;
channel1Max = 225.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 160.000;
channel2Max = 225.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 100.000;

% Create mask based on chosen histogram thresholds
sliderBW = (MainImg(:,:,1) >= channel1Min ) & (MainImg(:,:,1) <= channel1Max) & ...
    (MainImg(:,:,2) >= channel2Min ) & (MainImg(:,:,2) <= channel2Max) & ...
    (MainImg(:,:,3) >= channel3Min ) & (MainImg(:,:,3) <= channel3Max);
BW = sliderBW;

% Initialize output masked image based on input image.
maskedRGBImage = MainImg;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

% Converting MainImg to DoublePrecision
MainImg = im2double(MainImg);

% Calcl HProd
HadamardProduct = MainImg .* BW;

%function to count how many clusters exist on the image
CountingClusters1 = bwconncomp(BW);

% Hadamard Product
figure;
imagesc(HadamardProduct);
title('Hadamard Product')

% Binary Image
figure;
imagesc(BW);
colormap('gray');
title('Binary Image')

%displaying the cluster values
disp(CountingClusters1);

% Exporting Outputs using Print for:
print('-f1', '-r300', '-dbmp', 'HadamardProduct.bmp');
print('-f2', '-r300', '-dbmp', 'BinaryImage.bmp');

% To be used later on for q4++
imwrite(BW, 'SpareBinaryImage.bmp');

end
