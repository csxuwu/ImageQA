function [ disp_comp_L ] = mj_computeDispCompIm( imL,imR,Dmap_L )

%   Generate merged view from disparity map

disp_comp_L=imL; % greate buffer for systhesized view
disp_comp_L(:)=0; % reset

sz=size(imL);

for x=1:sz(1)
    for y=1:sz(2)
        idxNew = y- Dmap_L(x,y);
        idxNew = max(1,idxNew);
        idxNew = min(sz(2)-1,idxNew);
        disp_comp_L(x,y)= (idxNew- floor(idxNew))*imR(x,floor(idxNew)+1)+(floor(idxNew)+1-idxNew)*imR(x,floor(idxNew)); % interpolated between pixels
    end
end

end

