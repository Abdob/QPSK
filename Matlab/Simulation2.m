% Read Text Message
readID = fopen('message.txt');
txtScan = textscan(readID,'%3072c');
tA = txtScan{1};
DataToGRC('message', tA,'uint8');   % send this to GRC as unsigned char

% Convert to Binary
tBits = dec2bin(tA,8)';                             % unpacking 
tBits = reshape(tBits,numel(tBits),1) - 48;         % k bits
%ichar = DataFromGRC('ichar', 'uint8');
%VerifyData(ichar', tBits);

%% Randomize
pn = zeros(384*8,1);                                  % pn sequence generated
state = [1 0 0 0 0 0 0 0 0 1 0 0 0];
for i=1:length(pn)
    pol = state(13) + state(11) + state(10) + state(1); % added and taking
    pn(i) = mod(pol,2);                                 % mod 2 is xor'ing
    state(1:12) = state(2:13);
    state(13) = pn(i);  
end

for i=1:length(tBits)
    ind = mod(i,3072);
    if(ind==0)
        ind =3072;
    end
    tBits(i) = bitxor(tBits(i),pn(ind));                       % The actual randomization      
end    
%%

% QPSK Encoding
tSyms = tBits(1:2:end) + j*tBits(2:2:end);          % iChar to Complex
tSyms = (tSyms-.5 -.5i)*2;                          % QPSK symbols
% complexSyms = DataFromGRC('complex','complex');
% VerifyData(tSyms, complexSMyms);

% Differntial Encoding
tdSyms = zeros(size(tSyms));
tdSyms(1) = tSyms(1);
for i=2:length(tSyms)
    tdSyms(i) = tdSyms(i-1)*exp(-j*angle(tSyms(i)))*exp(-j*pi*3/4);
end

% Pulse Shaper
OS = 8;
tUpSyms = upsample(tdSyms, OS);
beta = 0.5; span = 9;
B = rcosdesign(beta, span, OS);
tx = filter(B, 1, tUpSyms);
 
%  Addititve Gaussian White Noise Channel
rng(201);
nr = randn(size(tx));
rng(157);
ni = randn(size(tx));
noise = nr + i*ni;

%  Receiver Sampler
rx = tx;

% Match filtering
rUpSyms = filter(B, 1, rx);
rdSyms = [rUpSyms(1:OS:end)];                               % Down sample before
                                                       % differential decoding

% Differential Decoding
rdSyms = [0;rdSyms].*conj([rdSyms;0]);                 % phase difference
rdSyms = rdSyms(1:end-1)*exp(-j*pi*3/4)/sqrt(2);       % phase rotation  
rdSyms = symbolDecision(rdSyms);


% QPSK Decoding
rSyms = zeros(length(rdSyms)*2,1);
rSyms(1:2:numel(rdSyms)*2) = real(rdSyms);
rSyms(2:2:numel(rdSyms)*2) = imag(rdSyms);
rBits = rSyms/2+0.5;


%% Derandomize
delay = 18;                                     % Delay is now with respect to bits because
rBits = [rBits(delay+1:end);zeros(delay,1)];    % alignment must be before derandomizing 

for i = 1:length(rBits)
    ind = mod(i,3072);
    if(ind==0)
        ind =3072;
    end
    rBits(i) = bitxor(rBits(i),pn(ind));
end

%%
   

% Convert from Binary
delay = 0;
rBits = char(rBits+48);
rBits = rBits(1:floor(length(rBits)/8)*8);                          % truncate to make divisible by 8
rBits = reshape(rBits,8,numel(rBits)/8);


% Write Back Text Message
rA = char(bin2dec(rBits')');
writeID = fopen('received.txt','w');
fprintf(writeID, rA);