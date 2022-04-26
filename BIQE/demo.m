


clear;
clc;

im1 = imread('im1.png');
im2 = imread('im2.png');

templateModel = load('templatemodel.mat');
templateModel = templateModel.templateModel;
mu_prisparam = templateModel{1};
cov_prisparam = templateModel{2};
meanOfSampleData = templateModel{3};
principleVectors = templateModel{4};

score(1) = computequality(im1,mu_prisparam,cov_prisparam,principleVectors,meanOfSampleData);
score(2) = computequality(im2,mu_prisparam,cov_prisparam,principleVectors,meanOfSampleData);

score