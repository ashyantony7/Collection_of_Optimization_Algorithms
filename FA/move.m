function ns=move(n,ns,Lightn,alpha,betamin,gamma,VarLow,VarHigh)
  
% Scaling of the system
scale=abs(VarHigh-VarLow);
d=length(VarLow);

% make a copy of original values
nso = ns;
Lighto=Lightn;

% Updating fireflies
for i=1:n
    % The attractiveness parameter beta=exp(-gamma*r)
    for j=1:n
        r=sqrt(sum((ns(i,:)-ns(j,:)).^2)); % distance between fireflies
        
        if Lightn(i)>Lighto(j) % Brighter and more attractive
            % Update moves
            beta0=1; 
            beta=(beta0-betamin)*exp(-gamma*r.^2)+betamin;
            tmpf=alpha.*(rand(1,d)-0.5).*scale;
            ns(i,:)=ns(i,:).*(1-beta)+nso(j,:).*beta+tmpf;
        end
    end 

end 

end
