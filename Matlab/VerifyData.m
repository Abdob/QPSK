function [] = VerifyData(grc, matlab)

if(sum(sum(grc==matlab))==numel(grc))
    fprintf('Verification Passed.\n');
else
    fprintf('Verification Failed.\n');
end

end