function [HW_preds, HW_gts] = apply_HW(train_inds_HW, test_ind, input_subj_train, input_subj_test, ...
    N_inner_trials, EXOG_train, EXOG_test, Nneurons_HW, nbs, nfs, nks)

disp('HW')

Nfeats = size(EXOG_test, 2);

nonlin = sigmoidnet('NumberOfUnits', Nneurons_HW);
nonlin2 = sigmoidnet('NumberOfUnits', Nneurons_HW);

[z_test, ~] = ...
    create_z_train(input_subj_test, test_ind, ...
    EXOG_test, Nfeats);

HW_preds = cell(N_inner_trials, length(nbs), length(nfs), length(nks));
HW_gts = cell(N_inner_trials, length(nbs), length(nfs), length(nks));

for n_inner = 1 : N_inner_trials
    
    disp(['Test # ' num2str(n_inner)])
    tic
    
    train_inds_HW = train_inds_HW(randperm(length(train_inds_HW)));
    
    [z_train, ~] = ...
        create_z_train(input_subj_train, train_inds_HW, ...
        EXOG_train, Nfeats);
    
    for nb_ind = 1 : length(nbs)
        for nf_ind = 1 : length(nfs)
            for nk_ind = 1 : length(nks)
                
                nb_concat = nbs(nb_ind) * ones(1, Nfeats);
                nf_concat = nfs(nf_ind) * ones(1, Nfeats);
                nk_concat = nks(nk_ind) * ones(1, Nfeats);
                
                hw_model_noww = idnlhw([nb_concat, nf_concat, nk_concat], nonlin, nonlin2);
                hw_model_now = nlhw(hw_model_noww, z_train);
                
                gt_now = z_test.OutputData;
                
                [y_pred_hw, ~, ~] = compare(z_test, hw_model_now);
                
                hw_pred_now = y_pred_hw.OutputData;
                
                hw_pred_now = hw_pred_now(nfs(nf_ind) + 1 : end);
                gt_now = gt_now(nfs(nf_ind) + 1 : end);
                
                HW_preds{n_inner, nb_ind, nf_ind, nk_ind} = hw_pred_now;
                HW_gts{n_inner, nb_ind, nf_ind, nk_ind} = gt_now;
                
                toc
                
            end
        end
    end 
end

end

