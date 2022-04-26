function [NARX_preds, NARX_gts] = apply_NARX(training_in_closed_loop, IDs, FDs, Hs, ...
    train_inds_NARX, test_ind, input_subj_train, input_subj_test, ...
    N_inner_trials, train_func, divide_fcn, trainRatio, valRatio, testRatio, epochs_narx, ...
    EXOG_train, EXOG_test)

disp('NARX')

[input_test_NARX, exog_test_NARX] = ...
    prepare_test(input_subj_test, EXOG_test, test_ind);

[input_train_NARX, exog_train_NARX] = ...
    prepare_train(input_subj_train, EXOG_train, train_inds_NARX);

NARX_preds = cell(N_inner_trials, size(IDs, 2), size(FDs, 2), size(Hs, 2));
NARX_gts = cell(N_inner_trials, size(IDs, 2), size(FDs, 2), size(Hs, 2));
largest_between_IFDs = cell(N_inner_trials, size(IDs, 2), size(FDs, 2), size(Hs, 2));

for n_inner = 1 : N_inner_trials
    
    disp(['Test # ' num2str(n_inner)])
    
    train_inds_NARX = train_inds_NARX(randperm(length(train_inds_NARX)));
    
    for I_ind = 1 : size(IDs, 2)
        for F_ind = 1 : size(FDs, 2)
            for H_ind = 1 : size(Hs, 2)
                
                ID = IDs{I_ind};
                FD = FDs{F_ind};
                H = Hs{H_ind};
                
                if training_in_closed_loop
                    net_for_test = closeloop(narxnet(ID, FD, H));
                else
                    net_for_test = narxnet(ID, FD, H);
                end
                
                disp(['Testing on: ID = ' num2str(max(ID)) ', FD = ' num2str(max(FD)) ', H = ' num2str(H)])
                
                net_for_test = setup_net(net_for_test, divide_fcn, ...
                    train_func, epochs_narx, trainRatio, valRatio, testRatio);
                
                [Xs, Xi, Ai, Ts] = preparets(net_for_test, exog_train_NARX, {}, input_train_NARX);
                
                [net_for_test, ~] = train(net_for_test, Xs, Ts, Xi, Ai);
                
                net_closed_for_test = closeloop(net_for_test);
                
                [Xs,Xi,Ai] = preparets(net_closed_for_test, exog_test_NARX, {}, input_test_NARX);
                
                y = net_closed_for_test(Xs, Xi, Ai);
                
                predicted = [y{:}];
                stop_loc = find(isnan(predicted));
                gt = input_subj_test{1, test_ind};
                
                largest_between_IFDs{n_inner, I_ind, F_ind, H_ind} = max(max(ID), max(FD));
                
                [gt_now, narx_pred_now] = ...
                    crop_seqs(gt, predicted, stop_loc, ...
                    largest_between_IFDs{n_inner, I_ind, F_ind, H_ind});
                
                NARX_preds{n_inner, I_ind, F_ind, H_ind} = narx_pred_now;
                NARX_gts{n_inner, I_ind, F_ind, H_ind} = gt_now;
                
            end
        end
    end
end

end

