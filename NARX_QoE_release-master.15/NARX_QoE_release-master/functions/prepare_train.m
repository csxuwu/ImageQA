function [input_train, exog_train] = prepare_train(input, EXOG, train_inds)

input_train = catsamples(num2cell(input{1, train_inds(1)}), ...
    num2cell(input{1, train_inds(2)}), 'pad');

exogs_all = cell(1, size(EXOG, 2));

for feat_ind = 1 : size(EXOG, 2)
    
    exog_cell = EXOG{1, feat_ind};
    exogs_all{1, feat_ind} = catsamples(num2cell(exog_cell{1, train_inds(1)}), ...
        num2cell(exog_cell{1, train_inds(2)}), 'pad');
    
end;

for train_ind = 3 : length(train_inds)
    
    input_train = catsamples(input_train, ...
        num2cell(input{1, train_inds(train_ind)}),  'pad');
    
    for feat_ind = 1 : size(EXOG, 2)
    
        exog_cell = EXOG{1, feat_ind};
        exogs_all{1, feat_ind} = catsamples(exogs_all{1, feat_ind}, ...
            num2cell(exog_cell{1, train_inds(train_ind)}), 'pad');
    
    end;
    
end;

exog_train = exogs_all{1, 1};
for feat_ind = 2 : size(EXOG, 2)
    exog_train = cellfun(@vertcat, exog_train, ...
        exogs_all{1, feat_ind}, 'UniformOutput', false);
end;

end

