function alpha=alpha_new(alpha,NGen)
% ALPHA_NEW Function to generate new value of alpha
% alpha_n=alpha_0(1-delta)^NGen=10^(-4);
% alpha_0=0.9

delta=1-(10^(-4)/0.9)^(1/NGen);
alpha=(1-delta)*alpha;

end