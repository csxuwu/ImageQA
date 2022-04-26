
clear;
clc;

load result
CSIQ_niqmc = CSIQ_niqmc(CSIQ_ind(:,2)==6);
CSIQ_dmos  = CSIQ_dmos(CSIQ_ind(:,2)==6);
TID2008_niqmc = TID2008_niqmc(TID2008_ind(:,2)==16|TID2008_ind(:,2)==17);
TID2008_mos   = TID2008_mos(TID2008_ind(:,2)==16|TID2008_ind(:,2)==17);
TID2013_niqmc = TID2013_niqmc(TID2013_ind(:,2)==16|TID2013_ind(:,2)==17);
TID2013_mos   = TID2013_mos(TID2013_ind(:,2)==16|TID2013_ind(:,2)==17);

abs(corr(CID2013_niqmc, CID2013_mos, 'type','spearman'))
abs(corr(CCID2014_niqmc,CCID2014_mos,'type','spearman'))
abs(corr(CSIQ_niqmc,    CSIQ_dmos,   'type','spearman'))
abs(corr(TID2008_niqmc, TID2008_mos, 'type','spearman'))
abs(corr(TID2013_niqmc, TID2013_mos, 'type','spearman'))
