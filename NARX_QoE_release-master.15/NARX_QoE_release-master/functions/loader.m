function [quality, input_subj, input_subj_ALL, ...
    TSL, TSL_rate_drop, TSL_stall, ...
    Nrebuffers, bitrate_levels, TrainingMatrix_LIVENetflix_Continuous, ...
    TestingMatrix_LIVENetflix_Continuous] = ...
    loader(quality_model)

load(['ContinuousQoE_LIVE_Nflx_Data.mat'])
load('TrainingMatrix_LIVENetflix_Continuous.mat')
load('TestingMatrix_LIVENetflix_Continuous.mat')

quality = [];

eval(['quality=exog_' quality_model ';']);

end

