function [largest_IFD, smallest_IFD] = extract_sl_IFD(IDs, FDs)
%EXTRACT_SL_IFD Summary of this function goes here
%   Detailed explanation goes here

pairs = [];
for I_ind = 1 : size(IDs, 2)
    for F_ind = 1 : size(FDs, 2)
        ID_now = IDs{I_ind};
        FD_now = FDs{F_ind};
        pairs = [pairs max([max(ID_now) max(FD_now)])];
    end;
end;

largest_IFD = max(pairs);
smallest_IFD = min(pairs);

end

