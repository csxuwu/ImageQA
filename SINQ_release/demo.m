clear all;

% Load the model which already been trained in LIVE 3D Database
load model.mat;

% Read the example picture
img = imread('demo_pic.bmp');

% call function compute_feature.m to calculate the quality score of the example picture
score = compute_score(img);
disp([score]);