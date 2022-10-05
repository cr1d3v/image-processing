% cr1d3v
% Exercise:     q7.m
% Edited:       30.08.2021

% Reset
clear all;
close all;
clc;

%Loading the Vid
CarVideo = VideoReader('RedCar.mp4');

% size 30 as the best identified overall
StrelOne = strel('square', 30);

% while loop to iterate through the video
while hasFrame(CarVideo)
    
    ReadEachFrame = readFrame(CarVideo);

    % RGB to grayscale
    GrayFrame = rgb2gray(ReadEachFrame);
    [BW,maskedRGBImage] = maskedImg(ReadEachFrame);
    
    % FilterTheFrame for deviations
    FilterFrame = bwareaopen(BW,300);
    
    % Binary Frame
    SourcedSampleFromQ5m = imclose(FilterFrame,StrelOne);

    % RGB * BinaryImg
    imageProduct = ReadEachFrame.*uint8(SourcedSampleFromQ5m);
    
    im2bw = SourcedSampleFromQ5m > 0;
    Label2Img = bwlabel(im2bw);
    
    % finding the ImgSizes of the bounding box
    ImgSizes = regionprops(Label2Img, 'BoundingBox');
    BBox = [ImgSizes(:).BoundingBox];
   
    % Cropping a Section of the img
    CropSection = imcrop(GrayFrame, BBox);
    
    % Binarizing the newly created Cropped Section
    BinarizingRGB = imbinarize(CropSection);
    
    % OCR Function to identify the NumberPlate
    NumberPlate = ocr(BinarizingRGB,'CharacterSet','0123456789ABCDEFGHIJKLMNOPQRSTUWVYXZ');
    disp(NumberPlate);
    

    % Exporting Outputs:
    subplot(2,2,1);
    imshow(ReadEachFrame);
    axis image;

    subplot(2,2,2);
    imshow(CropSection);
    axis image;

    subplot(2,2,3);
    imagesc(imageProduct);
    colormap gray;


    subplot(2,2,4);
    imagesc(BinarizingRGB);
    axis image;

    % to show the real-time movement
    pause(0.000010);
    
end

function [BW,maskedRGBImage] = maskedImg(RGB)
%------------------------------------------------------

% Convert RGB image to chosen color space
MainImg = RGB;

% Define thresholds for channel 1 based on histogram settings
channel1Min = 120.000;
channel1Max = 225.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 80.000;
channel2Max = 225.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 75.000;

% Create mask based on chosen histogram thresholds
sliderBW = (MainImg(:,:,1) >= channel1Min ) & (MainImg(:,:,1) <= channel1Max) & ...
    (MainImg(:,:,2) >= channel2Min ) & (MainImg(:,:,2) <= channel2Max) & ...
    (MainImg(:,:,3) >= channel3Min ) & (MainImg(:,:,3) <= channel3Max);
BW = sliderBW;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end
