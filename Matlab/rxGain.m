% script allowing us to find optimal rx gain through visual inspection
for n = 2:8
subplot(4,2,n);
dB = (n-2)*10;
data = 'first';
data = strcat(data,num2str(dB));
first = DataFromGRC(data,'complex');
y = real(filter(B, 1, first));
seg = y(1250000:1251000);
plot(seg);
tString = strcat('rx : ', num2str(dB), ' dB'); 
title(tString);
end

subplot(421)
rs = real(rx(end-length(seg):end));
plot(rs)
title('tx : 20dB');
