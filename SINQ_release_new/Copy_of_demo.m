% clear all;

% Load the model which already been trained in LIVE 3D Database
load model.mat;

% Read the example picture
% img = imread('demo_pic.bmp');
img = imread("F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE\ACE-VAE-V3_1_0 2\ExDark120\2015_00015_.jpg");
imshow(img)
% call function compute_feature.m to calculate the quality score of the example picture
score = compute_score(img)
