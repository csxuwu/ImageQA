function [z_train, output_single] = create_z_train(input_subj, train_inds, ...
    EXOG, Nfeats)

%CREATE_Z_TRAIN Summary of this function goes here
%   Detailed explanation goes here

exog_now = EXOG{1};
input_train_now = exog_now{train_inds(1)}';

for feat_ind = 2 : Nfeats
    exog_now = EXOG{feat_ind};
    input_train_now = [input_train_now exog_now{train_inds(1)}'];
end

output_train_now = input_subj{train_inds(1)}';
z_now = iddata(output_train_now, input_train_now);
output_single = input_subj{train_inds(1)}';

if length(train_inds) > 1
    
    input_train_now = [];
    exog_now = EXOG{1};
    input_train_now = exog_now{train_inds(2)}';

    for feat_ind = 2 : Nfeats
        exog_now = EXOG{feat_ind};
        input_train_now = [input_train_now exog_now{train_inds(2)}'];
    end
    
    output_train_now = input_subj{train_inds(2)}';
    z_now2 = iddata(output_train_now, input_train_now);
    
    z_train = merge(z_now, z_now2);
    
    for kk = 3 : length(train_inds)
        
        exog_now = EXOG{1};
        input_train_now = exog_now{train_inds(kk)}';

        for feat_ind = 2 : Nfeats
            exog_now = EXOG{feat_ind};
            input_train_now = [input_train_now exog_now{train_inds(kk)}'];
        end       
        
        output_train_now = input_subj{train_inds(kk)}';
        z_now = iddata(output_train_now, input_train_now);
        z_train = merge(z_train, z_now);
        
    end
    
else
    
    z_train = z_now;
    
end

