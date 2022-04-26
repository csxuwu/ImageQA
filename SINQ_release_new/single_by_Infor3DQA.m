function [single, dot] = single_by_Infor3DQA(imDL,imDR,dmap_test)



if(size(imDL,3)==3)
    imDL = rgb2gray(imDL);
    imDR = rgb2gray(imDR);
end

[ disp_comp_dl] = mj_computeDispCompIm( imDL,imDR,dmap_test );

[D_L_Infor]=ExtractInforResponse(imDL);
[Syn_D_Infor]=ExtractInforResponse(imDR);


[ disp_comp_GBdl ] = mj_computeDispCompIm( D_L_Infor,Syn_D_Infor,dmap_test );
[ single ] = mj_GenMergeWEntropy( imDL,disp_comp_dl,D_L_Infor,disp_comp_GBdl );
dot = double(imDL) .* double(disp_comp_dl);

end




