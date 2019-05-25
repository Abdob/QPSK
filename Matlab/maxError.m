function errMax = maxError(grc, ml,isPlot)
% tool to look at the verification error
% function errMax = maxError(grc, ml,plot)
% set plot to true to see maxError(gr, ml, true)

    if nargin<3
      isPlot=false;
    end
    if(~isreal(ml))
        percErr = abs(real(grc)-real(ml))./(real(grc)+1e-3)*100;
        errMaxR = max(max(percErr));
        percErr = abs(imag(grc)-imag(ml))./(imag(grc)+1e-3)*100;
        errMaxI = max(max(percErr));
        errMax = max(errMaxR, errMaxI);
    else
        percErr = abs(grc-ml)./(ml+1e-3)*100;
        errMax = max(max(percErr));
    end
    
    if(isPlot==true)
        
        plot(percErr)
        
    end
end