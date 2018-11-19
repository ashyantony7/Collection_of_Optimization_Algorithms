function X=sortPop(X)
% SORTPOP Function to sort the population of Krills

[~,sortind]=sort([X.Fit]);

X = X(sortind);

end