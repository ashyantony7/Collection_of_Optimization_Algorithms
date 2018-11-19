%Bio-geography based Krill Herd Migration 
%----------------------------------------
clc
clear
close all

% Problem Statement
Npar = 3;
VarLow=[-5.12 -5.12 -5.12];
VarHigh = [5.12 5.12 5.12];

% parameters
NP=100;       %number of krills
MaxIter=100;  %number of iterations
Vf=0.2;       %foraging velocity
Dmax=0.005;   %max diffusion
Nmax=0.01;   
pmod=0.5;
wf = 0.3;     %inertia for foraging
wn= 0.3;      %inertia for movement
mu=0.3;

XBest = [0.5 0.5 0.5];
XBestFit = fitnessFunc(XBest);
GB=XBestFit;
t = cputime;

%Initialization only for memory allocation
Krill=repmat(struct('Position',zeros(1,Npar),'Velocity',zeros(1,Npar)),NP,1);

%Random Population
for ii = 1:NP
    Krill(ii).Position = rand(1,Npar).* (VarHigh - VarLow) + VarLow;
    Krill(ii).N=rand(1,Npar);
    Krill(ii).F=rand(1,Npar);
    Krill(ii).Fit = fitnessFunc(Krill(ii).Position);
end

%main loop
for kk = 1:MaxIter
    
   %Sorting the population according to their fitness
   [~,sortind]=sort([Krill.Fit]);
   Krill = Krill(sortind);

   %store the best krill
   if Krill(1).Fit<XBestFit
      XBest=Krill(1).Position;
      XBestFit=Krill(1).Fit;
   end
  
   for ii=1:NP
 
       %movement
       Krill(ii).N=Nmax+wn*(Krill(ii).N);

       %foraging
       beta=XBest-Krill(ii).Position;
       Krill(ii).F=Vf*beta+ wf*(Krill(ii).F);

       %diffusion
       D=Dmax*rand(1,Npar);

       %new position
       Krill(ii).Position=Krill(ii).Position+Krill(ii).N+D+Krill(ii).F;

       %Krill Migration operator
       if rand<pmod
           for jj=1:Npar
              j=randperm(NP,1);
              if rand<mu
                 Krill(ii).Position(jj)=Krill(j).Position(jj);
              end
           end
       end

       %limit within boundaries
       Krill(ii).Positon=limiter(Krill(ii).Position,VarLow,VarHigh);

       %find the fitness value
       Krill(ii).Fit =fitnessFunc(Krill(ii).Position);
   end
   
   % store the best value in each iteration
   GB=[GB XBestFit];
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


