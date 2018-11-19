% Particle Swarm Optimization
%-----------------------------
clc
clear
close all

% Problem Statement
Npar = 3;
VarLow=[-5.12 -5.12 -5.12];
VarHigh = [5.12 5.12 5.12];

% Parameters
C1 = 2;
C2 = 4-C1;
Inertia = .3;
DampRatio = .95;
ParticleSize = 100;
MaxIter = 100;

% initialize a random value as best value
GlobalBest = rand(1,Npar).* (VarHigh - VarLow) + VarLow;
GlobalBestCost = fitnessFunc(GlobalBest);
GB = GlobalBestCost;
t = cputime;

% Initialization of particles and memory
Particle=repmat(struct('Position',zeros(1,Npar),'Velocity',zeros(1,Npar)),ParticleSize,1);

for ii = 1:ParticleSize
    
    % initialize with a random position
    Particle(ii).Position = rand(1,Npar).* (VarHigh - VarLow) + VarLow;

    % find the cost for that position
    Particle(ii).Cost = fitnessFunc(Particle(ii).Position);

    % initialize velocity as random
    Particle(ii).Velocity = rand(1,Npar);
    
    % store current position and cost as localbest
    Particle(ii).LocalBest = Particle(ii).Position;
    Particle(ii).LocalBestCost = Particle(ii).Cost;
    
    % update globalbest cost
    if Particle(ii).Cost < GlobalBestCost
        GlobalBest = Particle(ii).Position;
        GlobalBestCost = Particle(ii).Cost;
    end
end

% Main Loop
for jj = 1:MaxIter
    for ii = 1:ParticleSize
        Inertia = Inertia * DampRatio;
        
        % update velocity 
        Particle(ii).Velocity = rand * Inertia * Particle(ii).Velocity + C1 * rand * (Particle(ii).LocalBest - Particle(ii).Position) +  C2 * rand * (GlobalBest - Particle(ii).Position);
        
        % update to new position
        Particle(ii).Position = Particle(ii).Position + Particle(ii).Velocity;

        % limit position within search space
        Particle(ii).Position = limiter(Particle(ii).Position,VarHigh,VarLow);
        
        % calculate the new cost
        Particle(ii).Cost = fitnessFunc(Particle(ii).Position);

        % update local best and global best
        if Particle(ii).Cost < Particle(ii).LocalBestCost
            Particle(ii).LocalBest = Particle(ii).Position;
            Particle(ii).LocalBestCost = Particle(ii).Cost;

            if Particle(ii).Cost < GlobalBestCost
                GlobalBest = Particle(ii).Position;
                GlobalBestCost = Particle(ii).Cost;
            end
        end
    end
    
    % store the best value in each iteration
    GB = [GB GlobalBestCost];
end

t1=cputime;

fprintf('The time taken is %3.2f seconds \n',t1-t);
fprintf('The best value is :');
GlobalBest
GlobalBestCost

% Convergence Plot
figure(1)
plot(0:MaxIter,GB, 'linewidth',1.2);
title('Convergence');
xlabel('Iterations');
ylabel('Objective Function (Cost)');
grid('on')

