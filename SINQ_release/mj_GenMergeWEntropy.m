function [ M_L ] = mj_GenMergeWEntropy( imL,imR,EN_L,EN_R )

%   Generate merged view from L, shifted_L, and their entropy map

    % normalized 
    %minT = min(min(EN_L(:)),min(EN_R(:)));
    %maxT = max(max(EN_L(:)),max(EN_R(:)));
    
    %EN_L=EN_L-minT;
    %EN_R=EN_R-minT;
    %EN_L=EN_L+0.01; %%% avoid 0
    %EN_R=EN_R+0.01; %%%avoid 0
    EN_L(EN_L==0)=0.0001;
    EN_R(EN_R==0)=0.0001;
    
    alfa = 1;
    EN_L = EN_L.^alfa;
    EN_R = EN_R.^alfa;
      
    EN_Sum=EN_L+EN_R;
   

    EN_L = EN_L./EN_Sum;
    EN_R = EN_R./EN_Sum;    


    M_L=(double(imL).*EN_L+double(imR).*EN_R);
end
