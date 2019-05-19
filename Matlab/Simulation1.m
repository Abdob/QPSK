%% Read Text Message
readID = fopen('message.txt');
txtScan = textscan(readID,'%760c');
tA = txtScan{1};
DataToGRC('message', tA,'uint8');   % send this to GRC as unsigned char

%% Convert to Binary
tBits = dec2bin(tA,8)';           
tBits = reshape(tBits,numel(tBits),1);

%% QPSK Encoding

%% Convert from Binary
rBits = reshape(tBits,8,numel(tBits)/8);

%% Write Back Text Message
rA = char(bin2dec(rBits')');
writeID = fopen('received.txt','w');
fprintf(writeID, rA);