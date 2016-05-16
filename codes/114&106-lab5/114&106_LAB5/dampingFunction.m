function F = dampingFunction( t , u )
%DAMPINGFUNCTION Summary of this function goes here

%{
u(1) -> theta     
u(2) -> omega

F(1) -> omega
F(2) -> derivative of omega
%}

global C mass l g beta;

F = zeros(length(u) , 1);

F(1) = u(2);
F(2) = -(2*beta)*u(2) - (g/l)*u(1);

end

