% cr1d3v
% Exercise:     q5.m
% Edited:       22.07.2021

% Reset
clear all;
close all;
clc;

%Loading Img
Img = imread('SpareBinaryImage.bmp');

% size 6 to not compromise the end result
StrelOne = strel('disk', 6);
% size 10 as the best identified overall
StrelTwo = strel('square', 10);

% disk
DiskOne = imdilate(Img,StrelOne); % *Good*
DiskTwo = imerode(Img,StrelOne); % *Bad*
DiskThree = imopen(Img,StrelOne); % *Bad*
DiskFour = imclose(Img,StrelOne); % *Good*

% square
SquareOne = imdilate(Img,StrelTwo); % *Good*
SquareTwo = imerode(Img,StrelTwo); % Bad
SquareThree = imopen(Img,StrelTwo); % Bad
SquareFour = imclose(Img,StrelTwo); % *Chosen*

% Counting The Clusters
CountingClusters1 = bwconncomp(DiskOne);
CountingClusters2 = bwconncomp(DiskFour);
CountingClusters3 = bwconncomp(SquareOne);
CountingClusters4 = bwconncomp(SquareFour);

% Displaying The Clusters
display(CountingClusters1);
display(CountingClusters2);
display(CountingClusters3);
display(CountingClusters4);

% Exporting Outputs for Disk
figure;

subplot(2,2,1);
imagesc(DiskOne);
colormap gray;
axis image;
axis off;

subplot(2,2,2);
imagesc(DiskTwo);
colormap gray;
axis image;
axis off;

subplot(2,2,3);
imagesc(DiskThree);
colormap gray;
axis image;
axis off;

subplot(2,2,4);
imagesc(DiskFour);
colormap gray;
axis image;
axis off;

% Exporting Outputs for Square
figure;
subplot(2,2,1);
imagesc(SquareOne);
colormap gray;
axis image;
axis off;

subplot(2,2,2);
imagesc(SquareTwo);
colormap gray;
axis image;
axis off;

subplot(2,2,3);
imagesc(SquareThree);
colormap gray;
axis image;
axis off;

subplot(2,2,4);
imagesc(SquareFour);
colormap gray;
axis image;
axis off;

imwrite(DiskOne,'DiskOne.bmp');
imwrite(DiskTwo,'DiskTwo.bmp');
imwrite(DiskThree,'DiskThree.bmp');
imwrite(DiskFour,'DiskFour.bmp');

imwrite(SquareOne,'SquareOne.bmp');
imwrite(SquareTwo,'SquareTwo.bmp');
imwrite(SquareThree,'SquareThree.bmp');
imwrite(SquareFour,'SquareFour.bmp');