function feature= feat_exrt(img)
	[~, ~, d] = size(img);
	if (d ~= 1)
		img = rgb2gray(img);
	end
	img = double(img);
	size_img = size(img);
	imDL = img(:,1:size_img(2)/2);
	imDR = img(:,size_img(2)/2+1:end);  
	max_disp = 25;
	[fdsp, dmapD, confD, diffD] = mj_stereo_SSIM(imDL,imDR, max_disp);
	dmapgra=gradient(dmapD);
	dmapgra=abs(dmapgra);
	dmapgra1=1./(1+dmapgra); 
	[single, dot] = single_by_Infor3DQA(imDL,imDR,dmapD);
	feature = [ExtractFeatureWithSailency(single, dmapgra1), ExtractFeature(dot), ExtractFeature(imDL), ExtractFeature(imDR)];
end