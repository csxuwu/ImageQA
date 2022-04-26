


filename = "F:\Area 51\9.winter_is_here\storm\compare\ACE-VAE\ACE-VAE-V3_1_0 2\ExDark120\2015_00004_.jpg";
disp(['full path : ' filename]);
 
LL = (im2double(imread(filename)));

% º∆À„
load model.mat;
qualityscore = compute_score(LL);

str = ['SINQ : ' num2str(qualityscore)];
disp(str)
