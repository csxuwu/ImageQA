function test_inds = get_test_inds(db)

if strcmp(db, 'LIVE_HTTP_DB')
    test_inds = datasample(1 : 15, 15, 'Replace', false);
elseif strcmp(db, 'LIVE_NFLX')
    test_inds = datasample(1 : 112, 112, 'Replace', false);
elseif strcmp(db, 'Stall_DB')
    test_inds = datasample(1 : 174, 174, 'Replace', false);
elseif strcmp(db, 'Waterloo')
    test_inds = datasample(1 : 180, 1, 'Replace', false);
else
    disp('error')
end;

end

