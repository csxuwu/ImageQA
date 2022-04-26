function [ infor ] = ExtractInforResponse( im )

%a = ones(11,11);
%infor = entropyfilt(im,a);
 im=double(im);
 
 for scale=1:1
    
     N=2^(4-scale+1)+1;
     win=fspecial('gaussian',N,N/5);
     
     if (scale >1)
         im=filter2(win,im,'same');
         im=im(1:2:end,1:2:end);
     end
     
     mu1   = filter2(win, im, 'same');
     mu1_sq = mu1.*mu1;
     sigma1_sq = filter2(win, im.*im, 'same') - mu1_sq;
     sigma1_sq(sigma1_sq<1e-10)=0;
     
     %infor=log2(1+sigma1_sq./sigma_nsq);
     infor=log2(1+sigma1_sq);
 end

end

