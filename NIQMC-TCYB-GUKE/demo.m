
%==========================================================================
% 1) Please cite the paper (K. Gu, W. Lin, G. Zhai, X. Yang, W. Zhang, and 
% C. W. Chen, "No-reference quality metric of contrast-distorted images
% based on information maximization," IEEE Trans. Cybernetics, 2017, in 
% press.)
% 2) If any question, please contact me through guke.doctor@gmail.com; 
% gukesjtuee@gmail.com. 
% 3) Welcome to cooperation, and I am very willing to share my experience.
%==========================================================================

clear;
clc;

im1 = imread('im1.png');
im2 = imread('im2.png');
score(1) = NIQMC(im1);
score(2) = NIQMC(im2);
score
