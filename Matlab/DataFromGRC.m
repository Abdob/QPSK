function [v] = DataFromGRC(filename,len)
    filename = strcat('../GRC/',filename,'.dat');
    f = fopen(filename, 'rb'); 
    v = fread(f,len,'float');
    v = v';
fclose(f);
