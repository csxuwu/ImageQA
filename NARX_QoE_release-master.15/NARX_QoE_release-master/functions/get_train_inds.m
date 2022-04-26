function [train_inds, only_qual, Train_Matrix_FeedIn] = get_train_inds(db_train, db_test, test_ind, ...
    TrainingMatrix_LIVENetflix_Continuous_MdlSel, ...
    TrainingMatrix_LIVENetflix_Continuous)

%GET_TRAIN_INDS Summary of this function goes here
%   Detailed explanation goes here

if strcmp(db_train, db_test) == 1
    
    db = db_train;
    
    if strcmp(db, 'LIVE_HTTP_DB')
        
        if test_ind > 10
            test_team = 3;
        elseif test_ind >5
            test_team = 2;
        else
            test_team = 1;
        end
        
        train_team = setdiff([1 2 3], test_team);
        
        train_inds = [];
        if ~isempty(find(train_team == 1, 1))
            train_inds = [train_inds 1:5];
        end
        if ~isempty(find(train_team == 2, 1))
            train_inds = [train_inds 6:10];
        end
        if ~isempty(find(train_team == 3, 1))
            train_inds = [train_inds 11:15];
        end
        
        only_qual = 1;
        Train_Matrix_FeedIn = [];
        
    elseif strcmp(db, 'Stall_DB')
        
        load contentMap.mat
        content_ind_to_kick = content_ind(test_ind);
        vids_to_kick = find(content_ind == content_ind_to_kick);
        
        train_inds = setdiff(1 : 174, vids_to_kick);
        train_inds = train_inds(randperm(length(train_inds)));
        train_inds = train_inds(1:ceil(0.8*length(train_inds)));
        
        only_qual = 0;
        Train_Matrix_FeedIn = [];
        
    elseif strcmp(db, 'LIVE_NFLX')
        
        Train_Matrix_FeedIn = TrainingMatrix_LIVENetflix_Continuous_MdlSel;
        train_inds = ...
            TrainingMatrix_LIVENetflix_Continuous{test_ind, 1};
        only_qual = 0;
        
    else
        
        disp('error')
        
    end
    
else
    
    if strcmp(db_train, 'LIVE_HTTP_DB')
        
        train_inds = 1 : 15;
        
    elseif strcmp(db_train, 'Stall_DB')
        
        train_inds = 1:174;
        
    elseif strcmp(db_train, 'LIVE_NFLX')
        
        Train_Matrix_FeedIn = [];
        train_inds = 1:112;
        only_qual = 0;

    else
        
        disp('error')
        
    end
    
end

