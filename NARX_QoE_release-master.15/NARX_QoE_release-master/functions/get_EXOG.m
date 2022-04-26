function [EXOG_train, input_subj_train, input_subj_ALL_train, ...
    EXOG_test, input_subj_test, input_subj_ALL_test, SQI_cont, final_subj_scores] = ...
    get_EXOG(db_train, db_test, quality_model, feats)

%GET_EXOG Summary of this function goes here
%   Detailed explanation goes here

if strcmp(db_train, 'LIVE_HTTP_DB')
    
    load LIVE_HTTP_DB_Data.mat
    
    quality_model_here = quality_model{1};
    EXOG_train = cell(1, size(quality_model_here, 2));
    
    for qual_ind = 1 : size(quality_model_here, 2)
        
        metric_now = eval([quality_model_here{qual_ind}]);
        EXOG_train{1, qual_ind} = num2cell(metric_now', 2)';
        
    end;
    
    input_subj_train = num2cell(TVSQ', 2)';
    input_subj_ALL_train = [];
    
elseif strcmp(db_train, 'Stall_DB')
    
    use_for_exog = feats{1};
    EXOG_train = cell(1, size(use_for_exog, 2));
    
    load vidStallData.mat
    load Stall_DB_more_EXOG.mat
    
    for feat_ind = 1 : size(use_for_exog, 2)
        EXOG_train{feat_ind} = eval(use_for_exog{feat_ind});
    end;
    
    input_subj_train = continuousQoE_s';
    input_subj_ALL_train = input_subj_ALL;
    
elseif strcmp(db_train, 'LIVE_NFLX')
    
    quality_model_here = quality_model{1};
    
    [quality, input_subj_train, input_subj_ALL_train, ...
        TSL, TSL_rate_drop, TSL_stall, ...
        Nrebuffers, bitrate_levels, ...
        TrainingMatrix_LIVENetflix_Continuous, ...
        TestingMatrix_LIVENetflix_Continuous] = ...
        loader(quality_model_here{1});
    
    use_for_exog = feats{1};
    EXOG_train = cell(1, size(use_for_exog, 2));
    for feat_ind = 1 : size(use_for_exog, 2)
        EXOG_train{feat_ind} = eval(use_for_exog{feat_ind});
    end;
    
else
    
    disp('error')
    
end;

if strcmp(db_test, 'LIVE_HTTP_DB')
    
    load LIVE_HTTP_DB_Data.mat
    
    quality_model_here = quality_model{1};
    EXOG_test = cell(1, size(quality_model_here, 2));
    
    for qual_ind = 1 : size(quality_model_here, 2)
        
        metric_now = eval([quality_model_here{qual_ind}]);
        EXOG_test{1, qual_ind} = num2cell(metric_now', 2)';
        
    end;
    
    input_subj_test = num2cell(TVSQ', 2)';
    input_subj_ALL_test = [];
    
elseif strcmp(db_test, 'Stall_DB')
    
    use_for_exog = feats{1};
    EXOG_test = cell(1, size(use_for_exog, 2));
    
    load vidStallData.mat
    Nrebuffers = stallWaveforms_s';
    
    load Stall_DB_more_EXOG.mat
    
    for feat_ind = 1 : size(use_for_exog, 2)
        EXOG_test{feat_ind} = eval(use_for_exog{feat_ind});
    end;
    
    input_subj_test = continuousQoE_s';
    input_subj_ALL_test = input_subj_ALL;
    
elseif strcmp(db_test, 'LIVE_NFLX')
    
    quality_model_here = quality_model{1};
    
    [quality, input_subj_test, input_subj_ALL_test, ...
        TSL, TSL_rate_drop, TSL_stall, ...
        Nrebuffers, bitrate_levels, ...
        TrainingMatrix_LIVENetflix_Continuous, ...
        TestingMatrix_LIVENetflix_Continuous] = ...
        loader(quality_model_here{1});
    
    use_for_exog = feats{1};
    EXOG_test = cell(1, size(use_for_exog, 2));
    for feat_ind = 1 : size(use_for_exog, 2)
        EXOG_test{feat_ind} = eval(use_for_exog{feat_ind});
    end;
        
else
    
    disp('error')
    
end;

mx = max(cellfun(@max, input_subj_train));
for ind = 1:size(input_subj_train, 2)
    input_subj_train_norm{ind} = input_subj_train{ind}/mx;
end;

if ~isempty(input_subj_test)
    mx = max(cellfun(@max, input_subj_test));
    for ind = 1:size(input_subj_test, 2)
        input_subj_test_norm{ind} = input_subj_test{ind}/mx;
    end;
else
    input_subj_test_norm = [];
end;

if strcmp(db_train, db_test) ~= 1
    input_subj_train = input_subj_train_norm;
    input_subj_test = input_subj_test_norm;
end;

if ~strcmp(db_test, 'LIVE_NFLX') && ~strcmp(db_test, 'Waterloo')
    SQI_cont = [];
end;

if ~strcmp(db_test, 'Waterloo')
    final_subj_scores = [];
end;

end

