%Grey Wolf Optimization
% ---------------------
clc
clear
close all

% Problem Statement
Npar = 3;
VarLow=[-5.12 -5.12 -5.12];
VarHigh = [5.12 5.12 5.12];

% parameters
WolfSize = 100;
MaxIter = 100;

% initialize a random value as best value
alpha.Position=rand(1,Npar).* (VarHigh - VarLow) + VarLow;
alpha.Fit = fitnessFunc(alpha.Position);
GB=alpha.Fit;

t=cputime;

% Initialization of memory
X = repmat(struct('Position',zeros(1,Npar),'Fit',zeros(1,Npar)),WolfSize,1);
X(1) = alpha; % first wolf is alpha

for ii = 2:WolfSize
    %initial position of wolves
    X(ii).Position= rand(1,Npar).* (VarHigh - VarLow) + VarLow;
    
    % fitness of the solutions
    X(ii).Fit=fitnessFunc(X(ii).Position);
    
    % evaluate alpha
    if (X(ii).Fit < alpha.Fit)
        alpha.Position = X(ii).Position;
        alpha.Fit = X(ii).Fit;
    end
end
% sort wolves according to fitness
[~, sortind] = sort([X.Fit]);
X = X(sortind);

%initialize alpha beta and delta
alpha = X(1);
Beta = X(2);
delta = X(3);

%initialize A and C vectors
a=2*ones(1,Npar);
A1=2*rand(1,Npar).*a -a;
A2=2*rand(1,Npar).*a -a;
A3=2*rand(1,Npar).*a -a;
C1=2*rand(1,Npar);
C2=2*rand(1,Npar);
C3=2*rand(1,Npar);

% Main Loop
for jj = 1:MaxIter
    for ii = 1:WolfSize
        
        %compute encircling vectors
        Da=abs(C1.*alpha.Position-X(ii).Position);
        Db=abs(C2.*Beta.Position-X(ii).Position);
        Dd=abs(C3.*delta.Position-X(ii).Position);
        
        %update wolf position
        X1=alpha.Position - A1.*Da;
        X2=Beta.Position - A2.*Db;
        X3=delta.Position - A3.*Dd;
        X(ii).Position = (X1 + X2 + X3)/3;
        
        %maintian constraints
        X(ii).Position=limiter(X(ii).Position,VarHigh,VarLow);
        
        %update fitness
        X(ii).Fit=fitnessFunc(X(ii).Position);
        
        % update alpha if better
        if X(ii).Fit < alpha.Fit
            alpha = X(ii);
        end
    end
       
    % sort wolves according to fitness
    [~, sortind] = sort([X.Fit]);
    X = X(sortind);
    
    %update beta and delta
    Beta = X(2);
    delta = X(3);
    
    %update A and C vectors
    a=2*(1-jj/MaxIter);
    A1=2*rand(1,Npar).*a -a;
    A2=2*rand(1,Npar).*a -a;
    A3=2*rand(1,Npar).*a -a;
    C1=2*rand(1,Npar);
    C2=2*rand(1,Npar);
    C3=2*rand(1,Npar);
    
    % store the best value in each iteration
    GB = [GB alpha.Fit];
end

t1=cputime;

fprintf('The time taken is %3.2f seconds \n',t1-t);
fprintf('The best value is :');
alpha.Position
alpha.Fit

% Convergence Plot
figure(1)
plot(0:MaxIter,GB, 'linewidth',1.2);
title('Convergence');
xlabel('Iterations');
ylabel('Objective Function (Cost)');
grid('on')


