%Firefly algorithm
%-----------------
clc
clear
close all
warning off

% Problem Statement
Npar = 3;            %problem dimension
VarLow=[-5.12 -5.12 -5.12];
VarHigh = [5.12 5.12 5.12];

% parameters
n=100;         %number of fireflies
Gen = 100;
alpha=0.3;      % Randomness 0--1 (highly random)
gamma=1.0;      % Absorption coefficient
delta=0.97;      % Randomness reduction (similar to 
                % an annealing schedule)
betamin=0.2;    %minimum value of beta

% initialize a random value as best value
nbest=rand(1,Npar) .* (VarHigh - VarLow) + VarLow;
Lightbest = fitnessFunc(nbest);
GB = Lightbest;

t=cputime;

% Initialization of fireflies and memory
ns=zeros(n,Npar);
Lightn=zeros(n,1);
for ii = 1:n
    
    ns(ii,:)= rand(1,Npar) .* (VarHigh - VarLow) + VarLow;
    Lightn(ii)= fitnessFunc(ns(ii,:));  
    
    % save the best value
    if (Lightn(ii)<Lightbest)
       nbest=ns(ii,:);
       Lightbest = Lightn(ii);
    end

end


for k=1:Gen
    % Reducing Alpha
    alpha=alpha_new(alpha,Gen);

    % Move all fireflies to the better locations
    ns=move(n,ns,Lightn,alpha,betamin,gamma,VarLow,VarHigh);

    % limit the solutions within the search space
    for ii=1:n
       ns(ii,:)=limiter(ns(ii,:),VarHigh,VarLow); 
    end
    
    % Evaluate new solutions (for all n fireflies)
    for ii=1:n
       Lightn(ii) = fitnessFunc(ns(ii,:));
       if (Lightn(ii)<Lightbest)
           nbest=ns(ii,:);
           Lightbest=Lightn(ii);
       end
    end
     
    % store the best value in each iteration
    GB = [GB Lightbest];
end   

t1=cputime;

fprintf('The time taken is %3.2f seconds \n',t1-t);
fprintf('The best value is :');
nbest
Lightbest

% Convergence Plot
figure(1)
plot(0:Gen,GB, 'linewidth',1.2);
title('Convergence');
xlabel('Iterations');
ylabel('Objective Function (Cost)');
grid('on')







