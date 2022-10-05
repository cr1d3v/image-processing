% cr1d3v
% Exercise:     q4.m
% Edited:       14.07.2021

% Reset
clear all;
close all;
clc;

% Loading Imgs
newImg = imread('SpareBinaryImage.bmp');
Img = imread('testImage.bmp');

% M- rows and N- column values
M = size(newImg,1);
N = size(newImg,2);

% Red, Green & Blue parts of the binaryImage.bmp
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

emptyRMatrix = zeros(size(R));
emptyGMatrix = zeros(size(G));
emptyBMatrix = zeros(size(B));

% RED thresholding values
emptyRMatrix(R<196) = 0;
emptyRMatrix(R>225) = 2;
emptyRMatrix(R>=196 & R<=225) = 1;

% for loop to traverse through the matrix &
% if statement to organise the values
for i2=2:M
    for j2=2:N
       if emptyRMatrix(i2,j2)==1
           random = round(rand);
           emptyRMatrix(i2,j2)=random;
       end
    end
end

newR = R.*uint8(emptyRMatrix);

% Green thresholding values
emptyGMatrix(R<160) = 0;
emptyGMatrix(R>225) = 2;
emptyGMatrix(R>=160 & R<=225) = 1;

% for loop to traverse through the matrix &
% if statement to organise the values
for i1=2:M
    for j1=2:N       
       if emptyGMatrix(i1,j1)==1
           random = round(rand);
           emptyGMatrix(i1,j1)=random;     
       end
    end
end
 
newG = G.*uint8(emptyGMatrix);

% Blue thresholding values
emptyBMatrix(R<0) = 0;
emptyBMatrix(R>100) = 2;
emptyBMatrix(R>=0 & R<=100) = 1;

% for loop to traverse through the matrix &
% if statement to organise the values
for i3=2:M
    for j3=2:N
       if emptyBMatrix(i3,j3)==2            
           random = round(rand);
           emptyBMatrix(i3,j3)=random;     
       end
    end
end

newB = B.*uint8(emptyBMatrix);

% combining the 3x values with each other
RGBImg = cat(3,newR,newG,newB);

% Majority Filter Variable &
% A matrix to hold values
MajorityFilterV = 5; 
SecondMatrix = zeros(size(newImg));

% for loop to apply the majority filter to the Img &
% initialise the window
for i=1+floor(MajorityFilterV/2):M-floor(MajorityFilterV/2)    
    for j=1+floor(MajorityFilterV/2):N-floor(MajorityFilterV/2)          
        window = newImg(i-floor(MajorityFilterV/2):i+floor(MajorityFilterV/2),j-floor(MajorityFilterV/2):j+floor(MajorityFilterV/2));        
        window = window(:);        
        outputValue = mode(window);        
        SecondMatrix(i,j) = uint8(outputValue);        
    end
end

% Binarizing the newly created Img
BinarizingRGB = im2bw(RGBImg);

% Counting The Clusters
CountingClusters1 = bwconncomp(BinarizingRGB);
CountingClusters2 = bwconncomp(SecondMatrix);
% Displaying The Clusters
display(CountingClusters1);
display(CountingClusters2);

% Exporting Outputs:
figure;
subplot(1,3,1);
imagesc(newImg);
axis image;
colormap gray;
subplot(1,3,2);
imagesc(BinarizingRGB);
axis image;
colormap gray;
subplot(1,3,3);
imagesc(SecondMatrix);
axis image;
colormap gray;

imwrite(BinarizingRGB,'BinarizedH.bmp');
imwrite(RGBImg,'HysteresisT.bmp');
imwrite(SecondMatrix,'MajorityF.bmp');      