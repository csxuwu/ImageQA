function [speed, speed_sn] = ...
    Single_Scale_SpEED(img_ref, img_dis, times_to_down_size, ...
    blk, window, sigma_nsq)

%%%% resize reference and distorted image frames
for band_ind = 1 : times_to_down_size
    img_ref = imresize(img_ref, 0.5);
    img_dis = imresize(img_dis, 0.5);
end;

%%%% calculate local averages
mu_ref = imfilter(img_ref, window, 'replicate');
mu_dis = imfilter(img_dis, window, 'replicate');

%%%% estimate local variances and conditional entropies in the spatial
%%%% domain
[ss_ref, q_ref] = est_params(img_ref - mu_ref, blk, sigma_nsq);
spatial_ref = q_ref .* log2(1+ss_ref);
[ss_dis, q_dis] = est_params(img_dis - mu_dis, blk, sigma_nsq);
spatial_dis = q_dis .* log2(1+ss_dis);

%%%% calculate single-scale SpEED index
speed = mean2(abs(spatial_ref - spatial_dis));
speed_sn = abs(mean2(spatial_ref - spatial_dis));

end

