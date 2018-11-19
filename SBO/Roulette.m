function f = Roulette(prob)
%ROULETTE Function to perfrom Roulette Wheel selection
% based on probability

C=cumsum(prob);
f=find(rand<=C,1,'first');
    
end

