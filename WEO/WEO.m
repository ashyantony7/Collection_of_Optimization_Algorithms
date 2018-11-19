%Water Evaporation optimization
%------------------------------

clc
clear
close all

% Problem Statement
Npar = 3;
VarLow=[-5.12 -5.12 -5.12];
VarHigh = [5.12 5.12 5.12];

%initial value
XBest =  rand(1,Npar).* (VarHigh - VarLow) + VarLow;
XBestCost = fitnessFunc(XBest);
GB = XBestCost;

%algorithm parameters
iter=100;   %maximum number of iterations
% step=0.9/iter;
nWM=100;       %number of water molecules
tmax=100;     %Maximum number of iterations
Emax=-0.5;
Emin=-3.5;
themin=-50;
themax=-20;

%initializations for memory allocation
molecule=zeros(nWM,Npar);
Fit=zeros(1,nWM);  
Esub=zeros(1,nWM);
MEP=zeros(1,nWM);
DEP=zeros(1,nWM);
theta=zeros(1,nWM);

%Intialization of water molecules
for ii = 1:nWM
    molecule(ii,:)= rand(1,Npar).* (VarHigh - VarLow) + VarLow;
    Fit(ii) = fitnessFunc(molecule(ii,:));
  
    if Fit(ii) < XBestCost
        XBest = molecule(ii,:);
        XBestCost = Fit(ii);
    end
end

% Main Loop
for t=1:tmax
    
    if t<=(tmax/2)
      for ii=1:nWM
       %Monolayer evaporation phase
       %===========================
       %calculate substrate energy vector
       Esub(ii)=((Emax-Emin)*(Fit(ii)-min(Fit(ii)))/(max(Fit)-min(Fit)))+Emin;
       Esub(ii)=min((max(Emin,Esub(ii))),Emax);
       
       %calculate evaporation probability
       MEP(ii)=(rand<exp(Esub(ii)));

      end
    else
        %Droplet evaporation phase
        %=========================
         for ii=1:nWM  
           %calculate substrate energy vector
            theta(ii)=((themax-themin)*(Fit(ii)-min(Fit(ii)))/(max(Fit)-min(Fit)))+themin;
            theta(ii)=min((max(themin,theta(ii))),themax);
       
           %calculate evaporation probability          
            DEP(ii)=(rand<calcJ(theta(ii)));
             
         end
    end
    
    %Evaporation of molecules
    count=0;
    for ii=1:nWM
       if t<=(tmax/2)
          if MEP(ii)==1
            molecule(ii-count,:)=[];
            Fit(ii-count)=[];
            count=count+1;        
          end
       else
           
           
       end
    end


    %Regeneration of lost water molecules
    %====================================
    curr=length(molecule(:,1));  %current water molecules
    nlost=nWM-curr;
    for ii=1:nlost
      for jj=1:Npar
       i=round(rand*curr +0.5);
       molecule((curr+ii),jj)=molecule(i,jj);
      end
      
       %new fitness
       Fit(curr+ii)=fitnessFunc(molecule((curr+ii),:));
       
       %Check new fitness better than previous best
        if Fit(curr+ii) < XBestCost
           XBest = molecule(ii,:);
           XBestCost = Fit(curr+ii);
        end
    end
    
    GB=[GB XBestCost];
end

t1=cputime;

fprintf('The time taken is %3.2f seconds \n',t1-t);
fprintf('The best value is :');
XBest
XBestCost

% Convergence Plot
figure(1)
plot(0:tmax,GB, 'linewidth',1.2);
title('Convergence');
xlabel('Iterations');
ylabel('Objective Function (Cost)');
grid('on')