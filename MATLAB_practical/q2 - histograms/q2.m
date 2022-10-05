% cr1d3v
% Exercise:     q2.m
% Edited:       22.06.2021

clear all;
close all;
clc;

% Loading Img
Img = imread("testImage.bmp");

% Extracting the Red, Green & Blue parts of the RGB Img & 
% creating a 3 2-d matrice
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);

M = size(Img,1);
N = size(Img,2);

[CR,L] = imhist(R);
[CG,L] = imhist(G);
[CB,L] = imhist(B);

CRcml = cumsum(imhist(R(:)));
CGcml = cumsum(imhist(G(:)));
CBcml = cumsum(imhist(B(:)));

% Count Histogram
figure;
plot(L,CR, 'r-', 'Linewidth', 1);
hold on;
plot(L,CG, 'g-', 'Linewidth', 1);
plot(L,CB, 'b-', 'Linewidth', 1);
hold off;
xlabel('Luminance_{x}');
ylabel('Count_{y}')
xlim([0 255])
ylim([0 86549])
title('Count Histogram')

% Normalised Count Histogram
figure;
plot(L,CR.*(M*N), 'r-', 'Linewidth', 1); 
hold on;
plot(L,CG.*(M*N), 'g-', 'Linewidth', 1);
plot(L,CB.*(M*N), 'b-', 'Linewidth', 1);
hold off;
xlabel('Luminance_{x}');
ylabel('Normalised Count_{y}')
xlim([0 255])
ylim([0 37786400000])
title('Normalised Count Histogram')

% Cumulative Count Histogram
figure;
plot(L,CRcml, 'r-', 'Linewidth', 1); 
hold on;
plot(L,CGcml, 'g-', 'Linewidth', 1);
plot(L,CBcml, 'b-', 'Linewidth', 1);
hold off;
xlabel('Luminance_{x}');
ylabel('Cumulative Count_{y}')
xlim([0 255])
ylim([0 436590])
title('Cumulative Count Histogram')

% Normalised Cumulative Count Histogram
figure;
plot(L,CRcml.*(M*N), 'r-', 'Linewidth', 1); 
hold on;
plot(L,CGcml.*(M*N), 'g-', 'Linewidth', 1);
plot(L,CBcml.*(M*N), 'b-', 'Linewidth', 1);
hold off;
xlabel('Luminance_{x}');
ylabel('Normalised Cumulative Count_{y}')
xlim([0 255])
ylim([0 190611000000])
title('Normalised Cumulative Count Histogram')

% Exporting Outputs using Print for:
print('-f1', '-r300', '-dbmp', 'Count.bmp');
print('-f2', '-r300', '-dbmp', 'NormalisedCount.bmp');
print('-f3', '-r300', '-dbmp', 'CumulativeCount.bmp');
print('-f4', '-r300', '-dbmp', 'NormalisedCumulativeCount.bmp');