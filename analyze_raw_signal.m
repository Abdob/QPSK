%% load raw qpsk
 f = fopen('capture_record_rx30_425.dat', 'rb');
 D = fread(f, 16e6, '*float'); 
 fclose(f);
 plot(D);
%% small portion "burst"
d = D(3e6:15e6);

%% analysis of burst
N = length(d); % number of samples
fs = 16.384e6;  % sampling frequency
T = 1/fs;      % sampling interval
time = T*N;    % time of burst
R = 1.024e6;   % symbol rate

%% analysis of impulse-train
c = d(9.054e5 : 1.332e6);
c = c(2.053e5:2.179e5);
c = c(5909:7916);
N = length(c);
t = N*T;
Nsym = R*t;     % number of symbols

%% analysis of a dozen modulated symbols
Nsamps = 12*fs/R;
b = c(100:100+Nsamps);


%% frequency analysis
figure(1)
f = [-fs/2:fs/N:fs/2-fs/N]/1e6;
freq = abs(fftshift(fft(c)));
plot(f,freq);
time = [1:T:T*N];

%% frequency analysis after filtering
Nsym = 6;           % Filter span in symbol durations
beta = 0.5;         % Roll-off factor
OS = fs/R;  % oversampling
B = rcosdesign(beta,  Nsym, OS);
r = filter(B, 1, c);
freq = abs(fftshift(fft(r)));
plot(f,freq);

%% Visualize waveform



