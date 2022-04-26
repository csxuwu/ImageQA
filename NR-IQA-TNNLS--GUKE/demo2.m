
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
im1 = BOIEM(im0);

figure(1);imshow(im0)
figure(2);imshow(im1)
