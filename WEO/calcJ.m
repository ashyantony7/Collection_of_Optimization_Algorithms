function J = calcJ(theta)
%CALCJ
theta=deg2rad(theta);  %conversion to radians

  J=(1/2.6)*(( (2/3) +((cos(theta))^3)/3  - cos(theta))^(-2/3))*(1-cos(theta));

end

