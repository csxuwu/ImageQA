
%==========================================================================
% 1) Please cite the paper (K. Gu, D. Tao, J.-F. Qiao, and W. Lin, "Learning
% a no-reference quality assessment model of enhanced images with big data,"
% IEEE Trans. Neural Netw. Learning Syst., 2017, in press.)
% 2) If any question, please contact me through guke.doctor@gmail.com; 
% gukesjtuee@gmail.com. 
% 3) Welcome to cooperation, and I am very willing to share my experience.
%==========================================================================

clear;
clc;

im0 = imread('im0.png');
im1 = imread('im1.png');
im2 = imread('im2.png');
score1 = CPCQI(im0,im1);
score2 = CPCQI(im0,im2);
[score1,score2]

[pred1,feature1] = BIQME(im1);
[pred2,feature2] = BIQME(im2);
[pred1,pred2]

