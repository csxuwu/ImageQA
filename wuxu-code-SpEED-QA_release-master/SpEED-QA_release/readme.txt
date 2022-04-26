Spatial Efficient Entropic Differencing (SpEED-QA) Software release.
=================================================================
-----------COPYRIGHT NOTICE STARTS WITH THIS LINE------------
Copyright (c) 2017 The University of Texas at Austin
All rights reserved.
Permission is hereby granted, without written agreement and without license or royalty fees, to use, copy, modify, and distribute this code (the source files) and its documentation for any purpose, provided that the copyright notice in its entirety appear in all copies of this code, and the original source of this code, Laboratory for Image and Video Engineering (LIVE, http://live.ece.utexas.edu) and Center for Perceptual Systems (CPS, http://www.cps.utexas.edu) at the University of Texas at Austin (UT Austin, http://www.utexas.edu), is acknowledged in any publication that reports research using this code. The research is to be cited in the bibliography as:
1)  C. G. Bampis, P. Gupta, R. Soundararajan and A. C. Bovik, "SpEED-QA: Spatial Efficient Entropic Differencing for Image and Video Quality," in IEEE Signal Processing Letters, vol. 24, no. 9, pp. 1333-1337, Sept. 2017.
2)  C. G. Bampis, Praful Gupta, Rajiv Soundararajan and A. C. Bovik, "SpEED-QA Software Release" 
URL: http://live.ece.utexas.edu/research/quality/ SpEED_QA_release.zip, 2017
IN NO EVENT SHALL THE UNIVERSITY OF TEXAS AT AUSTIN BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OF THIS DATABASE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF TEXAS AT AUSTIN HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. THE UNIVERSITY OF TEXAS AT AUSTIN SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE DATABASE PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND THE UNIVERSITY OF TEXAS AT AUSTIN HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
-----------COPYRIGHT NOTICE ENDS WITH THIS LINE------------%
Authors  : Christos Bampis and Praful Gupta
Version : 1.0
The authors are with the Laboratory for Image and Video Engineering (LIVE), Department of Electrical and Computer Engineering, The University of Texas at Austin, Austin, TX.
Kindly report any suggestions or corrections to cbampis@gmail.com or praful_gupta@utexas.edu
=================================================================
The current release implements SpEED-QA, an efficient image and video quality reduced-reference predictor in the spatial domain. SpEED-QA is based on local operations in the spatial domain and entropic differencing. It calculates the conditional entropies of mean-subtracted coefficients and applies entropic differencing between the reference and distorted image or video. For videos the aforementioned process is repeated on the frame differences as well yielding a temporal quality scores. This score is then combined with the spatial (still picture) quality indicator yielding the video version of SpEED: SpEED-VQA.
The attached code also implements multi-scale SpEED for Image Quality Assessment (IQA), where the still picture SpEED is applied on 5 scales, then combined into a single score using MS-SSIM weights.
The current release contains demo images for testing. For videos, you need to include a reference and a distorted video and call them from the code.
For further questions, feel free to e-mail at cbampis@gmail.com or praful_gupta@utexas.edu
=================================================================
Further details:
SpEED for Image Quality Assessment (IQA):
blk_speed: size of the wavelet block used in the GSM model, set to 3x3 for images
Nscales: number of scales to decompose the image. This parameter is related to the multi-scale version of SpEED.
sigma_nsq: neural noise term, set to 0.1 (default value)
down_size_ss: number of times to downscale the original image. For IQA, SpEED-IQA performs best for down_size_ss = 2
window: Gaussian window, same as in BRISQUE

SpEED for Image Quality Assessment (VQA):
blk_speed: size of the wavelet block used in the GSM model, set to 5x5 for videos
sigma_nsq: neural noise term, set to 0.1 (default value)
down_size: number of times to downscale the original image and the frame difference. For VQA, SpEED-VQA performs best for down_size = 4
window: Gaussian window, same as in BRISQUE

For videos, you need to supply the full path of the reference and the distorted video.


