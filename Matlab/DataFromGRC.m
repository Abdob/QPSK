filename = '../GRC/receivedGRC.dat';
%filename = 'mlVector.dat';
f = fopen(filename, 'rb'); 
v = fread(f,9,'float'); 
fclose(f);
