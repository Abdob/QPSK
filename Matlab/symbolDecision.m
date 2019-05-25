function [out] = symbolDecision(in)
out = zeros(size(in));

for i = 1:length(in)
    
   if((real(in(i)) > 0) && (imag(in(i)) > 0))
       out(i) = 1 + 1j;
   elseif((real(in(i)) > 0) && (imag(in(i)) < 0))
       out(i) = 1 - 1j;
   elseif((real(in(i)) < 0) && (imag(in(i)) > 0))
       out(i) = -1 + 1j;
   else
       out(i) = -1 - 1j;
   end
    
end




end