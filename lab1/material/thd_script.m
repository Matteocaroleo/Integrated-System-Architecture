%% BEFORE THIS MUST RUN my_fir_filter.m

%% read file with c results and compute THD 
out=readlines("cFilterOut.txt");
out_1= str2double(out);
out_1 = out_1(1:201);
my_thd = thd(out_1);

% with SHAMT = 20 thd = -46.5850
