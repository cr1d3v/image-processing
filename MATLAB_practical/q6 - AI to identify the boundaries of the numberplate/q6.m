% cr1d3v
% Exercise:     q6.m
% Edited:       05.08.2021

% Reset
clear all;
close all;
clc;

% LoadingImg
Img = imread('testImage.bmp');
SourcedSampleFromQ5m = imread('SquareFour.bmp');

% RGB * BinaryImg
imageProduct = Img.*uint8(SourcedSampleFromQ5m);

im2bw = SourcedSampleFromQ5m > 0;
Label2Img = bwlabel(im2bw);

% finding the ImgSizes of the bounding box
ImgSizes = regionprops(Label2Img, 'BoundingBox');
BBox = [ImgSizes.BoundingBox];

% Cropping a Section of the img
CropSection = imcrop(Img, BBox);

% Binarizing the newly created Cropped Section
BinarizingRGB = imbinarize(CropSection);

% OCR Function to identify the plate
NumberPlate = ocr(BinarizingRGB);

% Displaying NumberPlate in the program
disp(NumberPlate);

% Exporting Outputs:
imagesc(CropSection);
axis image;
imwrite(CropSection,'TestingSquareFour.bmp');