function [v] = DataFromGRC(filename,len,type)
    filename = strcat('../GRC/',filename,'.dat');
    f = fopen(filename, 'rb');
    switch(type)
        case 'uint8'
            v = fread(f,len,'uint8');
        case 'complex'
            r = fread(f,len,'float');
            v = r(1:2:end) + j*r(2:2:end);
    end
    
    v = v';
    fclose(f);
end
