%% Read Text Message
readID = fopen('message.txt');
txtScan = textscan(readID,'%768c');
tA = txtScan{1};
DataToGRC('message', tA,'uint8');   % send this to GRC as unsigned char

%% Convert to Binary
tBits = dec2bin(tA,8)';                             % unpacking 
tBits = reshape(tBits,numel(tBits),1) - 48;         % k bits
%ichar = DataFromGRC('ichar', 'uint8');
%VerifyData(ichar, tBits);

%% Randomize
pn = zeros(384*2*8,1);                                  % pn sequence generated
state = [1 0 0 0 0 0 0 0 0 1 0 0 0];
for i=1:length(pn)
    pol = state(13) + state(11) + state(10) + state(1);
    pn(i) = mod(pol,2);
    state(1:12) = state(2:13);
    state(13) = pn(i);
    if(i == 384*8)
        state = [1 0 0 0 0 0 0 0 0 1 0 0 0];    % reset after two frames
    end
end
tBits = bitxor(tBits,pn);                       % The actual randomization          


%% Derandomize
rBits = bitxor(tBits,pn);

%% Convert from Binary
delay = 0;
rBits = char(rBits/2+48.5);
rBits = rBits(1:floor(length(rBits)/8)*8);                          % truncate to make divisible by 8
rBits = [zeros(1,delay), rBits(1:end-delay)];                      % delay and align
rBits = reshape(rBits,8,numel(rBits)/8);

%% Write Back Text Message
rA = char(bin2dec(rBits')');
writeID = fopen('received.txt','w');
fprintf(writeID, rA);