function [] = DataToGRC(filename, data)
    % Writing a data file so it can be read from Gnu Radio
    data = single(data);  % needs to be single precision

    filename = strcat('../GRC/', filename, '.dat');
    f = fopen (filename, 'wb'); 
    v = fwrite (f, data , 'float'); %specify float 
    fclose (f);
end
    