function errMax = maxError(grc, ml)
    if(~isreal(ml))
        percErr = abs(real(grc)-real(ml))./real(ml)*100;
        errMaxR = max(max(percErr));
        percErr = abs(imag(grc)-imag(ml))./imag(ml)*100;
        errMaxI = max(max(percErr));
        errMax = max(errMaxR, errMaxI);
    else
        percErr = abs(grc-ml)./ml*100;
        errMax = max(max(percErr));
    end
end