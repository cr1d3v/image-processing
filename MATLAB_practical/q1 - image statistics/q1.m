% cr1d3v
% Exercise:     q1.m
% Edited:       17.06.2021

clear all;
close all;
clc;

% Loading Inputs
Img = imread('testImage.bmp');
ImgGray = rgb2gray(Img);
ImgGray = double(ImgGray(:));

% Matrix change from (2D) to (1D)
OneM = ImgGray(:);
% Horizontal change
OneM = OneM';
% Sorted values (1D Matrix)
SortedOneM = sort(OneM);

% Columns values
M= size(ImgGray,1);
% Rows values
N= size(ImgGray,2);

% Max values (img pixel value)
maxImg = max(ImgGray(:));
% Min values (img pixel value)
minImg = min(ImgGray(:));

% Range of the pixel value
RangeImg = double(maxImg-minImg);
RangeRev = double(maxImg+minImg);

% Normalised Range
RangeNorm = double(RangeImg/255);

% Michelson Contrast
MichCon = double(RangeImg/RangeRev);

% Arithmetic mean
FArithMean = sum(sum(ImgGray))./(M*N);
ArithMean = mean(ImgGray(:));

% RMS Constrast - Had to calculate Arith Mean 1st in order to get RMSCon
RMSCon = sqrt((sum(sum((ImgGray-ArithMean).^2)))/(M*N));

% Harmonic Mean
FHarmMean = (M*N)/((sum(sum(1./double(ImgGray)))));
HarmMean = harmmean(double(ImgGray),'all');

% Geometric Mean
GeometricM = geomean(double(ImgGray),'all');

% Midrange
MidRange = double(maxImg+minImg)/2;

% 10% Winsorised Mean (transform in 1D first)
L = size(SortedOneM,2);
W = 0.1*L;
CutMatrix = SortedOneM(:, [W+2:L-W-1]);
ttl = sum(CutMatrix);
WinsMean = ((W+1)*ImgGray(W+1) + ttl + (W+1)*ImgGray(L-W))/L;

% 10% Trimmed Mean (transform in 1D first)
TrimMean = trimmean(ImgGray,10,'all');

% Displaying Outputs for:
disp(RangeImg); % Range
disp(RangeNorm); % Normalised range
disp(MichCon); % Michelson Contrast
disp(RMSCon); % RMS Contrast
disp(ArithMean); % Arithmetic mean
disp(HarmMean); % Harmonic mean
disp(GeometricM); % Geometric mean
disp(MidRange); % Midrange
disp(WinsMean); % 10% Winsorised Mean (transform in 1D first)
disp(TrimMean); % 10% Trimmed Mean (transform in 1D first)


