%% load raw qpsk
 f = fopen('capture_record_rx30_425.dat', 'rb');
 D = fread(f, inf, '*float'); 
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
OS = fs/R;  % oversampling

%% frequency analysis
figure(1)
freq = abs(fftshift(fft(c)));
figure(2)
freq = abs(fft(c));
plot(freq)
time = [1:T:T*N];

%%
Nsym = 6;           % Filter span in symbol durations
beta = 0.5;         % Roll-off factor
sampsPerSym = 16;    % Upsampling factor
% Design and normalize filter.
sqrtRcosRxFlt = comm.RaisedCosineReceiveFilter(...
  'Shape',                  'normal', ...
  'RolloffFactor',          beta, ...
  'FilterSpanInSymbols',    Nsym, ...
  'InputSamplesPerSymbol',  sampsPerSym, ...
  'DecimationFactor',       1);


% Visualize the impulse response
fvtool(rcosFlt, 'Analysis', 'impulse')



