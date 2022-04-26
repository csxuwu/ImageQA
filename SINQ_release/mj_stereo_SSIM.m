
%-----------------------------------------------------------------
% This code is modified from the package provided by Shawn Lankton (http://www.shawnlankton.com) Feb. 2008
% The modification uses SSIM to replace SAD in computing disparities
% Ming-Jun Chen May 2012
%-----------------------------------------------------------------
% function [dsp_f dsp] = stereo(img_R,img_L, maxs)
%
% 3D from stereo.  This function takes a stereo pair
% (that should already be registered so the only difference is in the
% 'x' dimension), and produces a 'disparity map.'  The output here is
% pixel disparity, which can be converted to actual distance from the
% cameras if information about the camera geometry is known.
% 
% The output here does show which objects are closer.
% Brighter = closer
%
% EXAMPLE:
% img_R = imread('tsuR.jpg');
% img_L = imread('tsuL.jpg');
% [dsp_f dsp] = stereo(img_R,img_L,20);
%
% Inputs:
%   img_R  = right image
%   img_L  = left image
%   maxs   = maximum pixel disparity.  (depends on image pair)
%
% Outputs:
%   dsp   = pixel disparities before final filtering (0 indicates bad pixel)
%   dsp_f = final disparity map after mode filtering
%
% Algorithm: 
% 1) Compute pixel disparity by comparing shifted versions of images.  
% 2) Use 2D mode filter to replace low-confidence information with 
%    information from high-confidence neighbors.
% 
% Coded by Shawn Lankton (http://www.shawnlankton.com) Feb. 2008
%-----------------------------------------------------------------

function [fdsp dsp confidence difference] = mj_stereo_SSIM(i1,i2, maxs)
  win_size  = 7; %-- size of window used when smoothing
  tolerance = 2; %-- how close R-L and L-R values need to be
  weight    = 1; %-- weight on gradients opposed to color
  
  %--determine pixel correspondence Right-to-Left and Left-to-Right
  [dsp1, diff1, cor1] = slide_images(i1,i2, 1, maxs, win_size, weight);
  [dsp2, diff2, cor2] = slide_images(i2,i1, -1, -maxs, win_size, weight);
  
  %--keep only high-confidence pixels
  [dsp conf diff] = winner_take_all(dsp1,diff1,cor1,dsp2,diff2,cor2,tolerance);
  
  confidence = conf;
  difference = diff;
  %--try to eliminate bad pixesl 
 % fdsp = modefilt2((dsp),[win_size,win_size],2);  -- MJ take out the smoothing step    
    fdsp = dsp;
%%----- HELPER FUNCTIONS

%-- takes the best disparity when we're within tolerance
function [pd  conf diff] = winner_take_all(d1,m1,cor1,d2,m2,cor2,tolerance,maxs)
%   pixel_dsp = zeros(size(d1));               %-- initialize output
%   conf = zeros(size(d1));
%     diff = zeros(size(d1));
%     
   idx1 = find(m1>m2); %-- find where d1 is best
   idx2 = find(m2>m1); %-- find where d2 is best
%   
%   pixel_dsp(idx1) = d1(idx1);                %-- fill with d1
%   diff(idx1) = m1(idx1);
%   conf(idx1) = cor1(idx1);
  
  pixel_dsp = d1;                %-- fill with d2
  diff = m1;  
  conf = cor1;  
  
  pixel_dsp(idx2) = d2(idx2);                %-- fill with d2
  diff(idx2) = m2(idx2);  
  conf(idx2) = cor2(idx2);  
  
  pd = shift_image(pixel_dsp,5);             %-- shift to match i1
  diff = shift_image(diff,5);             %-- shift to match i1  
  conf = shift_image(conf,5);             %-- shift to match i1
  
%-- slides images across each other to get disparity estimate
function [disparity mindiff corrmap ] = slide_images(i1,i2,mins,maxs,win_size,weight)
  [dimy,dimx,c] = size(i1);
  disparity = zeros(dimy,dimx);    %-- init outputs
  mindiff = inf(dimy,dimx);    
  corrmap = zeros(dimy,dimx);  
  
  h = ones(win_size)/win_size.^2;  %-- averaging filter

  [g1x] = gradient(double(i1)); %-- get gradient for each image
  [g2x] = gradient(double(i2));
  Precision=1;
  step = sign(maxs-mins)*Precision;          %-- adjusts to reverse slide
  for(i=mins:step:maxs)
    s  = shift_image(i2,i);        %-- shift image and derivs
    sx = shift_image(g2x,i);


    %--CSAD  is Cost from Sum of Absolute Differences
    %--CGRAD is Cost from Gradient of Absolute Differences

      %-- get CSAD and CGRAD
    [s1 ,ssimmap]= ssim(i1,s);           % -- MJ use SSIM
    [sg1,gssimmap]= ssim(g1x,sx);   	 % -- MJ use SSIM
    
    diffs = (i1-s);       %-- get CSAD and CGRAD
        
    CSSIM  = imfilter(ssimmap,h);           % -- MJ use SSIM
    CGSSIM = imfilter(gssimmap,h);           % -- MJ use SSIM
    d = 0.5*double(CSSIM)+0.5*CGSSIM;          %-- total 'difference' score
    
    idx = find(d>corrmap);          %-- put corresponding disarity
    disparity(idx) = abs(i)*Precision;        %   into correct place in image
    mindiff(idx) = diffs(idx);
    corrmap(idx) = d(idx);    
  end
  
%-- Shift an image
function I = shift_image(I,shift)
  dimx = size(I,2);
  if(shift > 0)
    I(:,shift:dimx,:) = I(:,1:dimx-shift+1,:);
    I(:,1:shift-1,:) = 0;
  else 
    if(shift<0)
      I(:,1:dimx+shift+1,:) = I(:,-shift:dimx,:);
      I(:,dimx+shift+1:dimx,:) = 0;
    end  
  end
  