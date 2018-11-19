function fitness = fitnessFunc(x)

%Sphere
% fitness=sum(x(1)^2+x(2)^2+x(3)^2);

%Booth
%    fitness=(x(1)+2*x(2)-7)^2 + (2*x(1) + x(2) - 5)^2;

%Beale's Function
% fitness=(1.5 -x(1)+x(1)*x(2))^2+(2.25-x(1)+x(1)*x(2)^2)^2+(2.625-x(1)+x(1)*x(2)^3)^2;

%six hump camel back
%   fitness=4*x(1)^2 - 2.1*x(1)^4 +(1/3)*x(1)^6 +x(1)*x(2)-4*x(2)^2+4*x(2)^4;

%Rastrigin
fitness = x(1)^2 - 10*cos(2*pi*x(1)) + 10;
fitness= fitness+ x(2)^2 - 10*cos(2*pi*x(2)) + 10;
fitness= fitness+ x(3)^2 - 10*cos(2*pi*x(3)) + 10;

%step
%     fitness=(x(1)+0.5)^2+(x(2)+0.5)^2;

%Rosenbrock
%    fitness=100*(x(2)-(x(1)^2))^2+ (x(1)-(x(1)^2))^2;

%trignometric
%    fitness=x(1)*sin(4*(x(1)))+1.1*x(2)*sin(2*(x(2)));

%trignometric 2
%  fitness=0.5+(sin(sqrtm(x(1)^2+x(2)^2))^2 - 0.5)/(1+0.1*(x(1)^2+x(2)^2));

%McCormick function
% fitness=sin(x(1)+x(2))+(x(1)-x(2))^2 -1.5*x(1)+2.5*x(2)+1;

%Greiwank function
%  fitness=(1/4000)*((x(1)-100)^2-(cos(x(1)-100)+(x(2)-100)^2-(cos(x(2)-100))));

%Matyas Function
% fitness=0.26*(x(1)^2 +x(2)^2)-0.48*x(1)*x(2);

%Schubert
%   fitness=((cos(2)+2*cos(3)+3*cos(4)+4*cos(5))*x(1)+1)*((cos(2)+2*cos(3)+3*cos(4)+4*cos(5))*x(2)+1);


%Quartic
% fitness=x(1)^4+2*x(2)^4+0.7886*(x(1));

%Drop wave function
%   fitness = (-1+cos(12*sqrtm(x(1)^2+x(2)^2)))/(0.5*(x(1)^2+x(2)^2));

%Cross intray
% fact1 = sin(x(1))*sin(x(2));
% fact2 = exp(abs(100 - sqrt(x(1)^2+x(2)^2)/pi));
% fitness= -0.0001 * (abs(fact1*fact2)+1)^0.1;


% MICHALEWICZ FUNCTION
% x(3)=[];
% d = length(x);
% sum = 0;
% for ii = 1:d
% 	xi = x(ii);
% 	new = sin(xi) * (sin(ii*xi^2/pi))^(2*10);
% 	sum  = sum + new;
% end
% fitness = -sum;

%EGGHOLDER FUNCTION
% x1 = x(1);
% x2 = x(2);
% term1 = -(x2+47) * sin(sqrt(abs(x2+x1/2+47)));
% term2 = -x1 * sin(sqrt(abs(x1-(x2+47))));
% 
% fitness = term1 + term2;

% ACKLEY FUNCTION
% d = length(x);
%  a = 20;
%  b = 0.2;
%  c = 2*pi;
% 
% sum1 = 0;
% sum2 = 0;
% for ii = 1:d
% 	xi = x(ii);
% 	sum1 = sum1 + xi^2;
% 	sum2 = sum2 + cos(c*xi);
% end
% 
% term1 = -a * exp(-b*sqrt(sum1/d));
% term2 = -exp(sum2/d);
% fitness = term1 + term2 + a + exp(1);

% SCHWEFEL FUNCTION
% x(3)=[];
% d = length(x);
% sum = 0;
% for ii = 1:d
% 	xi = x(ii);
% 	sum = sum + xi*sin(sqrt(abs(xi)));
% end
% fitness = 418.9829*d - sum;

% SCHAFFER FUNCTION N. 2
% x1 = x(1);
% x2 = x(2);
% fact1 = (sin(x1^2-x2^2))^2 - 0.5;
% fact2 = (1 + 0.001*(x1^2+x2^2))^2;
% 
% fitness = 0.5 + fact1/fact2;

% SCHAFFER FUNCTION N. 4
% x1 = x(1);
% x2 = x(2);
% fact1 = cos((sin(abs(x1^2-x2^2))))^2 - 0.5;
% fact2 = (1 + 0.001*(x1^2+x2^2))^2;
% 
% fitness = 0.5 + fact1/fact2;

%EASOM FUNCTION
% fitness=-cos(x(1))*cos(x(2))*exp(-((x(1)-pi)^2+(x(2)-pi)^2));

end