function [input_test, exog_test] = prepare_test(input, EXOG, test_inds)

if ~isempty(input)
    input_test = num2cell(input{1, test_inds});
else
    input_test = [];
end;

exog_now = EXOG{1};
exog_test = num2cell(exog_now{1, test_inds});

for feat_ind = 2 : size(EXOG, 2)
    exog_now = EXOG{1, feat_ind};
    exog_test = cellfun(@vertcat, exog_test, ...
        num2cell(exog_now{1, test_inds}), 'UniformOutput', false);
end;

end

