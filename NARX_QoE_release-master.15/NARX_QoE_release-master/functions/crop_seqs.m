function [gt_new, pred_new] = crop_seqs(gt, pred, stop_loc, lagg)

gt_new = gt(lagg+1:end);

if ~isempty(stop_loc)
    gt_new = gt_new(1:stop_loc(1)-1);
    pred_new = pred(1:stop_loc(1)-1);
else
    pred_new = pred;
end;

end

