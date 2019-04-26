%% load raw qpsk
 f = fopen('capture_record_rx30_424.dat', 'rb');
 D = fread(f, inf, '*float'); 
 fclose(f);
 plot(D);
%% small portion "burst"
d = D(1:1e8);
d = d(.2*1e7:1.2e7);
d = d(1.184e6:7.328e6);

%% analysis of burst
N = length(d); % number of samples
fs = 6.144e6;  % sampling frequency
T = 1/fs;      % sampling interval
time = T*N;    % time of burst
R = 1.024e6;   % symbol rate

%% analysis of impulse-train
c = d(1.598e6:1.843e6);
c = c(1.207e5:1.255e5);
c = c(1258:2472);
N = length(c);
t = N*T;
Nsym = R*t;     % number of symbols

%% analysis of a dozen symbols
Nsamps = 12*fs/R;
b = c(100:100+Nsamps);
OS = fs/R;  % oversampling





