%Symbiotic organism Search 
%-------------------------

clc
clear
close all
warning off

%Problem Statement
Npar = 3;
VarLow=[-5.12 -5.12 -5.12];
VarHigh = [5.12 5.12 5.12];

% parameters
n=50;
MaxIter=50;

XBest = rand(1,Npar).* (VarHigh - VarLow) + VarLow;
XBestFit = fitnessFunc(XBest);
GB = XBestFit;

%Initialization of memory
X=repmat(struct('Position',zeros(1,Npar),'Velocity',zeros(1,Npar)),n,1);

t=cputime;

%Initialize Random ecosystem
for ii = 1:n
    X(ii).Position = rand(1,Npar).* (VarHigh - VarLow) + VarLow;
    X(ii).Position=limiter(X(ii).Position,VarHigh,VarLow);
    X(ii).Fit = fitnessFunc(X(ii).Position);

    if X(ii).Fit < XBestFit
        XBest = X(ii).Position;
        XBestFit = X(ii).Fit;
    end
end


%Main Loop
for jj=1:MaxIter
    for ii=1:n
        %MUTUALISM PHASE
        j=randperm(n,1);   %random organism to interact
        Mutual_Vector=(X(ii).Position+X(j).Position)/2; % mutual vector
        
        % new solutions
        Xinew = X(ii).Position+rand(1,Npar).*(XBest-Mutual_Vector);
        Xjnew = X(j).Position+rand(1,Npar).*(XBest-Mutual_Vector);
        
        % limit solutions within search space
        Xinew=limiter(Xinew,VarHigh,VarLow);
        Xjnew=limiter(Xjnew,VarHigh,VarLow);
        
        % find new fitness values
        Xinewfit=fitnessFunc(Xinew);
        Xjnewfit=fitnessFunc(Xjnew);

        % update organisms if better
        if Xinewfit<X(ii).Fit
            X(ii).Position=Xinew;
            X(ii).Fit=Xinewfit;
            if X(ii).Fit < XBestFit
              XBest = X(ii).Position;
              XBestFit = X(ii).Fit;
            end
        end
        if Xjnewfit<X(j).Fit
            X(j).Position=Xjnew;
            X(j).Fit=Xjnewfit;
            if X(j).Fit < XBestFit
              XBest = X(j).Position;
              XBestFit = X(j).Fit;
            end
        end

        %COMMENSALISM PHASE
        j=randperm(n,1);   %random organism to interact
        Xinew = X(ii).Position+(rand).*(XBest-X(ii).Position);
        Xinew=limiter(Xinew,VarHigh,VarLow); % limit within search space
        Xinewfit=fitnessFunc(Xinew);  % update fitness
        
        % update organism if better
        if Xinewfit<X(ii).Fit
            X(ii).Position=Xinew;
            X(ii).Fit=Xinewfit;
            if X(ii).Fit < XBestFit
              XBest = X(ii).Position;
              XBestFit = X(ii).Fit;
            end
        end

        %PARASITISM PHASE
        j=randperm(n,1);   %random organism to become parasite
        Xpar=X(j).Position;
        Xm=randperm(Npar,1); %random vector dimension
        Xpar(Xm) = rand* (VarHigh(Xm) - VarLow(Xm)) + VarLow(Xm);
        
        % limit within search space
        Xpar=limiter(Xpar,VarHigh,VarLow);
        Xparfit=fitnessFunc(Xpar);  % update fitness

        % update organism if better
        if Xparfit<X(ii).Fit
            X(ii).Position=Xpar;
            X(ii).Fit=Xparfit;
            if X(ii).Fit < XBestFit
              XBest = X(ii).Position;
              XBestFit = X(ii).Fit;
            end
        end

    end
    
    % store the best value in each iteration
    GB = [GB XBestFit];
end

t1=cputime;

fprintf('The time taken is %3.2f seconds \n',t1-t);
fprintf('The best value is :');
XBest
XBestFit

% Convergence Plot
figure(1)
plot(0:MaxIter,GB, 'linewidth',1.2);
title('Convergence');
xlabel('Iterations');
ylabel('Objective Function (Cost)');
grid('on')

