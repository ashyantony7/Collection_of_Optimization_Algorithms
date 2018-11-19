function offspring=crossover(male,female,genl,cx,res,off)
% CROSSOVER function to perform crossover of parent genomes to 
% produce offspring

% get the crossover bit length
cx=cx*genl;
cx=round(cx);

% convert male to binary
maleb=(male+off)*(10^res);
malestr=dec2bin(maleb,genl);

% convert female to binary
femaleb=(female+off)*100;
femalestr=dec2bin(femaleb,genl);

% perfrom crossover
 for k=1:1:(genl-cx)
   offspringstr(:,k)=malestr(:,k); 
 end
 
 for k=genl:-1:genl-(cx-1)
    offspringstr(:,k)=femalestr(:,k);
 end
 
% convert back to decimal and then to float
offspring=bin2dec(offspringstr)';
offspring=((offspring/10^res) - off);

end