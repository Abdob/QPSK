%% Read Text Message
readID = fopen('message.txt');
txtScan = textscan(readID,'%760c');
tA = txtScan{1};
DataToGRC('message', tA,'uint8');   % send this to GRC as unsigned char

%% Convert to Binary
tBits = dec2bin(tA,8)';                             % unpacking 
tBits = reshape(tBits,numel(tBits),1) - 48;         % k bits
%ichar = DataFromGRC('ichar', 'uint8');
%VerifyData(ichar, tBits);

%% QPSK Encoding
tSyms = tBits(1:2:end) + j*tBits(2:2:end);          % iChar to Complex
tSyms = (tSyms-.5 -.5i)*2;                          % QPSK symbols
% complexSyms = DataFromGRC('complex','complex');
% VerifyData(tSyms, complexSyms);

%% Differntial Encoding
tdSyms = zeros(size(tSyms));
tdSyms(1) = tSyms(1);
for i=2:length(tSyms)
    tdSyms(i) = tdSyms(i-1)*exp(-j*angle(tSyms(i)))*exp(-j*pi*3/4);
end

%% Pulse Shaper
OS = 8;
tUpSyms = upsample(tdSyms, OS);
beta = 0.5; span = 9;
B = rcosdesign(beta, span, OS);
tx = filter(B, 1, tUpSyms);
 
%%  Transmitter Portion
%%  Here On UP
%%  Addititve Gaussian White Noise Channel
rng(201);
nr = randn(size(tx));
rng(157);
ni = randn(size(tx));
noise = nr + i*ni;

%%  Receiver Portion
%%  Here On Down
%%  Receiver Sampler
rx = tx;

%% Match filtering
rUpSyms = filter(B, 1, rx);
rdSyms = rUpSyms(1:OS:end);                               % Down sample before
                                                       % differential decoding
%% Differential Decoding
rdSyms = [0;rdSyms].*conj([rdSyms;0]);                 % phase difference
rdSyms = rdSyms(1:end-1)*exp(-j*pi*3/4)/sqrt(2);       % phase rotation  
rdSyms = symbolDecision(rdSyms);

%% QPSK Decoding
rSyms(1:2:numel(rdSyms)*2) = real(rdSyms);
rSyms(2:2:numel(rdSyms)*2) = imag(rdSyms);

%% Convert from Binary
rBits = char(rSyms/2+48.5);
rBits = [zeros(1,6), rBits(1:end-6)];                      % delay and align
rBits = reshape(rBits,8,numel(rBits)/8);

%% Write Back Text Message
rA = char(bin2dec(rBits')')
writeID = fopen('received.txt','w');
fprintf(writeID, rA);