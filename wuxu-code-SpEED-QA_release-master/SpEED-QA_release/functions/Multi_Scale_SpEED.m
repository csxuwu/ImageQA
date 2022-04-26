function [speed_ms, speed_sn_ms] = ...
    Multi_Scale_SpEED(img1r, img2r, Nscales, ...
    blk, window, sigma_nsq)

weights_msssim = [0.0448 0.2856 0.3001 0.2363 0.1333];
speed_now = zeros(1, Nscales);
speed_sn_now = zeros(1, Nscales);

band_ind = 1;

%%%% calculate local averages
mu1r = imfilter(img1r, window, 'replicate');
mu2r = imfilter(img2r, window, 'replicate');

%%%% estimate local variances and conditional entropies in the spatial
%%%% domain 
[ss_ref, q_ref] = est_params(img1r - mu1r,blk,sigma_nsq);
spatial_ref = q_ref.*log2(1+ss_ref);
[ss_dis, q_dis] = est_params(img2r - mu2r,blk,sigma_nsq);
spatial_dis = q_dis.*log2(1+ss_dis);

%%%% calculate SpEED for the finest scale
speed_now(band_ind) = mean2(abs(spatial_ref-spatial_dis));
speed_sn_now(band_ind) = abs(mean2(spatial_ref-spatial_dis));

for band_ind = 2 : Nscales
    
    %%%% resize all frames
    img1r = imresize(img1r, 0.5);
    img2r = imresize(img2r, 0.5);
    
    %%%% calculate local averages
    mu1r = imfilter(img1r, window, 'replicate');
    mu2r = imfilter(img2r, window, 'replicate');
    
    %%%% estimate local variances and conditional entropies in the spatial
    %%%% domain 
    [ss_ref, q_ref] = est_params(img1r - mu1r,blk,sigma_nsq);
    spatial_ref = q_ref.*log2(1+ss_ref);
    [ss_dis, q_dis] = est_params(img2r - mu2r,blk,sigma_nsq);
    spatial_dis = q_dis.*log2(1+ss_dis);
    
    %%%% calculate SpEED for this scale
    speed_now(band_ind) = mean2(abs(spatial_ref-spatial_dis));
    speed_sn_now(band_ind) = abs(mean2(spatial_ref-spatial_dis));
    
end;

%%%% apply MS-SSIM weights
speed_ms = mean(speed_now .* weights_msssim);
speed_sn_ms = mean(speed_sn_now .* weights_msssim);

end

