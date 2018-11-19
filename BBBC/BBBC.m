%Big Bang Big Crunch Algorithm
%-----------------------------
clc
clear
close all

% Problem Statement
Npar = 3;
VarLow=[-5.12 -5.12 -5.12];
VarHigh = [5.12 5.12 5.12];

%BBBC parameters
N=100;       %number of candidates
MaxIter=100;  %number of iterations

% initialize a random value as best value
XBest = rand(1,Npar).* (VarHigh - VarLow) + VarLow;
FBest=fitnessFunc(XBest);
GB=FBest;
t = cputime;

%intialize solutions and memory
X = zeros(N, Npar);
F = zeros(N, 1);

for ii = 1:N
    X(ii,:) = rand(1,Npar).* (VarHigh - VarLow) + VarLow;
    
    % calculate the fitness of solutions
    F(ii) = fitnessFunc(X(ii,:));
end

%Main Loop
for it=1:MaxIter

    %Find the centre of mass 
    %-----------------------

    %numerator term
    num=zeros(1,Npar);
    for ii=1:N
        for jj=1:Npar
            num(jj)=num(jj)+(X(ii,jj)/F(ii));
        end
    end

    %denominator term
    den=sum(1./F);

    %centre of mass
    Xc=num/den; 

    %generate new solutions
    %----------------------
    for ii=1:N

        %new solution from centre of mass
        for jj=1:Npar      
            New=X(ii,:);
            New(jj)=Xc(jj)+((VarHigh(jj)*rand)/it^2);
        end

        %boundary constraints
        New=limiter(New,VarHigh,VarLow);
        %new fitness
        newFit=fitnessFunc(New);

        %check whether the solution is better than previous solution
        if newFit<F(ii)
            X(ii,:)=New;
            F(ii)=newFit;
            if F(ii)<FBest
                XBest=X(ii,:);
                FBest=F(ii);   
            end
        end

    end

    % store the best value in each iteration
    GB=[GB FBest];
end

t1=cputime;

fprintf('The time taken is %3.2f seconds \n',t1-t);
fprintf('The best value is :');
XBest
FBest

% Convergence Plot
figure(1)
plot(0:MaxIter,GB, 'linewidth',1.2);
title('Convergence');
xlabel('Iterations');
ylabel('Objective Function (Cost)');
grid('on')