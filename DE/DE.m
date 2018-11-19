%Differential Evolution
%----------------------
clc
clear
close all

% Problem Statement
Npar = 3;  % problem dimension
VarLow=[-5.12 -5.12 -5.12];
VarHigh = [5.12 5.12 5.12];

% parameters
N=100;                %Number of population members
MaxIter=100;         %Maximum number of iterations (generations)
F=0.85;              %DE-scaling factor
CR = 0.7;            %crossover probability
Pmu=0.5;             %mutation probability

%initialize a random value as default best value
Best=rand(1,Npar).* (VarHigh - VarLow) + VarLow; %default starting point
bestVal=fitnessFunc(Best);
GB=bestVal;

t=cputime;

%intialize a random population and memory
pop = zeros(N, Npar);
fitness = zeros(N, 1);

for ii=1:N
    % initialize with a random solution
    pop(ii, :) = rand(1,Npar) .* (VarHigh - VarLow) + VarLow;

    % calculate the fitness of the solution
    fitness(ii) = fitnessFunc(pop(ii,:));
    
    % Evaluate the best member
    if fitness(ii)<bestVal
        Best=pop(ii,:);
        bestVal=fitness(ii);
    end
end

rot  = (0:1:N-1);   % rotating index array (size N)

%Main loop
for ii=1:MaxIter
    popold=pop;    %Save the old population

    ind=randperm(4);          % index pointer array
    a1  = randperm(N);        % shuffle locations of vectors
    rt  = rem(rot+ind(1),N);  % rotate indices by ind(1) positions
    a2  = a1(rt+1);           % rotate vector locations
    rt  = rem(rot+ind(2),N);
    a3  = a2(rt+1);                
    rt  = rem(rot+ind(3),N);
    a4  = a3(rt+1);               
    rt  = rem(rot+ind(4),N);
    a5  = a4(rt+1);                

    pm1 = popold(a1,:);             % shuffled population 1
    pm2 = popold(a2,:);             % shuffled population 2
    pm3 = popold(a3,:);             % shuffled population 3
    pm4 = popold(a4,:);             % shuffled population 4
    pm5 = popold(a5,:);             % shuffled population 5

    for k=1:N                       % population filled with the best member
        bm(k,:) = Best;                 % of the last iteration
    end

    mui = rand(N,Npar) < CR;  % all random numbers < CR are 1, 0 otherwise
    mpo = mui < Pmu;          % inverse mask to FM_mui

    ui = popold + F*(bm-popold) + F*(pm1 - pm2); %differntial variation
    ui = popold.*mpo + ui.*mui;         %crossover

    %-----parent+child selection-----------------------------------------
    %-----Select which vectors are allowed to enter the new population-----

    for k=1:N
        % limit solutions within the search space
        ui(k,:)=limiter(ui(k,:),VarHigh,VarLow); 
        
        % check cost of competitor
        tempval=fitnessFunc(ui(k,:));

        if tempval<fitness(k)   
            pop(k,:) = ui(k,:);                     
            fitness(k) = tempval;                   

            if (tempval<bestVal)  
                bestVal = tempval;     % new best value
                Best = ui(k,:);        % new best solution
            end
        end
    end

    % store the best value in each iteration
    GB=[GB bestVal];

end

t1=cputime;

fprintf('The time taken is %3.2f seconds \n',t1-t);
fprintf('The best value is :');
Best
bestVal

% Convergence Plot
figure(1)
plot(0:MaxIter,GB, 'linewidth',1.2);
title('Convergence');
xlabel('Iterations');
ylabel('Objective Function (Cost)');
grid('on')
