function [] = DataToGRC(filename, data, type)
    % Writing a data file so it can be read from Gnu Radio
    switch(type)
        case 'uint8'
            data = uint8(data);
        case 'single'
            data = single(data);
    end
    
    filename = strcat('../GRC/', filename, '.dat');
    f = fopen (filename, 'wb'); 
    v = fwrite (f, data , 'unsigned char'); %specify float 
    fclose (f);
end
    