clear
close all
clc

%%%% add to path necessary files
addpath(genpath('functions'))
addpath(genpath('Demo_Images'))

%%%% SpEED parameters
blk_speed = 3;
Nscales = 5;
sigma_nsq = 0.1;
down_size_ss = 2;
window = fspecial('gaussian', 7, 7/6);
window = window/sum(sum(window));

%%%% input reference and distorted images
img_ref = double(rgb2gray(imread('bikes.bmp')));
% img_dis = double(rgb2gray(imread('bikes_distorted.bmp')));
img_dis = double(rgb2gray(imread('bikes.bmp')));

%%%% Single-Scale SpEED
[SPEED_ss, SPEED_ss_SN] = ...
    Single_Scale_SpEED(img_ref, img_dis, ...
    down_size_ss, blk_speed, window, sigma_nsq);

%%%% Multi-Scale SpEED
[SPEED_ms, SPEED_ms_SN] = ...
    Multi_Scale_SpEED(img_ref, img_dis, ...
    Nscales, blk_speed, window, sigma_nsq);
tp =0;

