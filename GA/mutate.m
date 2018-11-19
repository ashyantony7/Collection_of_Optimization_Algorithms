function mutant=mutate(pop,genl,res,off)
% MUTATION function to performs the process of a 
% randomized mutation

% perfom bias and resolution change
pop=(pop+off)*(10^res);

% convert to binary
pop=dec2bin(pop,genl);

% get a random bit to mutate
mutbit=randperm(genl, 1);

if pop(:,mutbit)=='1'
   pop(:,mutbit)='0';
else
    pop(:,mutbit)='1';
end

% convert back to decimal
pop=bin2dec(pop)';

% convertion back to floating point
mutant=((pop/10^res) - off);

end