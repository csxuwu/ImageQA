%==========================================================================
% J. Yan, J. Li, X. Fu, "No-Reference Quality Assessment of Contrast-Distorted Images using Contrast Enhancement"
% 
% Please try your own contrast distorted images with different levels.
% Larger predicted score means better contrast quality.
%==========================================================================

clear;
clc;

addpath('utils', 'data', 'images');

im0 = imread('z2.bmp');
% im00 = imread('2+.bmp');
im1 = imread('2_INet_v23_00.jpg');
im2 = imread('2_INet_v121_00.jpg');
im3 = imread('k_2.bmp');
im4 = imread('e_2.bmp');

% im0 = imread('1.png');
% im1 = imread('2.png');
% im2 = imread('3.png');

pred(1) = CEIQ(im0);
% pred(1) = CEIQ(im00);
pred(2) = CEIQ(im1);
pred(3) = CEIQ(im2);
pred(4) = CEIQ(im3);
pred(5) = CEIQ(im4);


pred