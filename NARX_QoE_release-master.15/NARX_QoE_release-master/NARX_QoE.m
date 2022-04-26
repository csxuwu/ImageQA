clear
clc
close all

if isunix
    use_bracket = '/';
else
    use_bracket = '\';
end

addpath(genpath([pwd use_bracket 'functions']))
addpath(genpath([pwd use_bracket 'DatasetFiles']))
fnt_sz = 20;

%%%% choose database to apply NARX-QoE

db_test = 'Stall_DB';

%%%%%% LIVE_NFLX
if strcmp(db_test, 'LIVE_NFLX')
    feats_all = {{'quality', 'Nrebuffers', 'TSL'}};
    load('LIVE_NFLX_Network_Impairments.mat');
    load('TrainingTestingContinuousData.mat');
end

%%%%%% LIVE STALL II
if strcmp(db_test, 'Stall_DB')
    feats_all = {{'Nrebuffers', 'TSL'}};
    TrainingMatrix_LIVENetflix_Continuous_MdlSel = -1;
    TrainingMatrix_LIVENetflix_Continuous = -1;
end

% %%%%%% LIVE_HTTP
if strcmp(db_test, 'LIVE_HTTP_DB')
	feats_all = {{'quality'}};
    TrainingMatrix_LIVENetflix_Continuous_MdlSel = -1;
    TrainingMatrix_LIVENetflix_Continuous = -1;
end

db_train = db_test;

%%%% set input and external variable lags
IDs = {0:10};
FDs = {1:10};

%%%% set number of hidden nodes in hidden layer
Hs = {8};

%%%% set other NARX-related parameters
quality_models = {{'STRRED'}};
training_in_closed_loop = false;
N_inner_trials = 1;
train_func = 'trainlm';
divide_fcn = 'divideblock';
trainRatio = 0.80;
valRatio = 0.20;
testRatio = 0;
epochs_narx = 200;

%%%% set other HW-related parameters
nbs_hw = [5];
nfs_hw = [5];
nks_hw = [1];
Nneurons_HW = 5;

%%%% get randomized test indices and then pick the first for demo purposes
%%%% note: some train/test combinations will not work well for some
%%%% algorithms
test_inds = get_test_inds(db_test);
test_inds = test_inds(1);

%%%% TODO: add RNN predictor
algorithms = {'NARX', 'HW'};

%%%% repeat for all test indices
for n_trial = 1 : length(test_inds)
    
    test_ind = test_inds(n_trial);
    if strcmp(db_test, 'LIVE_NFLX')
        figure_title = [db_test ', ' num2str(LIVE_NFLX_Network_Impairments{test_ind, 1})];
    else
        figure_title = [db_test ', test video: ' num2str(test_ind)];
    end
    
    disp(figure_title);
    
    feats_ind = 0;
    
    %%%% repeat for all feature combinations
    for feats = feats_all
        
        feats_ind  = feats_ind + 1;
        
        %%%% repeat for all possible quality models (for now showing only ST-RRED)
        for quality_model = quality_models
            
            %%%% get train indices for this particular test index
            [train_inds, only_qual, Train_Matrix_FeedIn] = get_train_inds(db_train, db_test, ...
                test_ind, ...
                TrainingMatrix_LIVENetflix_Continuous_MdlSel, ...
                TrainingMatrix_LIVENetflix_Continuous);
            
            %%%% get exogenous variables, like VQA
            [EXOG_train, input_subj_train, input_subj_ALL_train, ...
                EXOG_test, input_subj_test, input_subj_ALL_test] = ...
                get_EXOG(db_train, db_test, ...
                quality_model, feats);
            
            disp(['Training with: ' num2str(length(train_inds)) ' videos'])
            disp(['Testing: ' num2str(length(test_ind)) ' video(s)'])
            
            if training_in_closed_loop
                training_in_closed_loop_now = true;
            else
                training_in_closed_loop_now = false;
            end
            
            %%%% train and test the predictors
            
            if ismember('NARX', algorithms)
                [NARX_preds, NARX_gts] = apply_NARX(training_in_closed_loop_now, IDs, FDs, Hs, ...
                    train_inds, test_ind, input_subj_train, input_subj_test, ...
                    N_inner_trials, train_func, ...
                    divide_fcn, trainRatio, valRatio, testRatio, epochs_narx, ...
                    EXOG_train, EXOG_test);
            end
            
            if ismember('HW', algorithms)
                [HW_preds, HW_gts] = apply_HW(train_inds, test_ind, input_subj_train, input_subj_test, ...
                    N_inner_trials, EXOG_train, EXOG_test, Nneurons_HW, nbs_hw, nfs_hw, nks_hw);
            end
            
        end
        
    end

    %%%% show results
    %%%% note: output may not be as good for some testcases
    %%%% you can try adding more features, re-running the network with
    %%%% different initial weights or setup a different architecture

    for algorithm = algorithms

        preds_all = eval([algorithm{1} '_preds']);
        gts_all = eval([algorithm{1} '_gts']);
                
        %%%% show only the first result (more parameters will enlarge the cell output) 
        preds = preds_all{1};
        gts = gts_all{1};

        figure
        plot(preds, 'r', 'LineWidth', 2.5)
        hold on
        plot(gts, 'b', 'LineWidth', 2.5)
        grid
        title(figure_title, 'Interpreter', 'none')
        h = legend(algorithm{1}, 'Ground Truth', 'Location', 'SouthWest');
        h.FontWeight = 'bold';
        h.FontSize = 15;
        xlabel('Sample #', 'fontweight', 'bold', 'FontSize', fnt_sz)
        ylabel('QoE', 'fontweight', 'bold', 'FontSize', fnt_sz)

    end
    
end

