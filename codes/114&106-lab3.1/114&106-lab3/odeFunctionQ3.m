function F = odeFunctionQ3(t,u)
% F(1) = dx/dt 
% F(2) = dvx/dt
% F(3) = dy/dt 
% F(4) = dvy/dt
global g R;
F=zeros(length(u),1);

F(1) = u(2) ;
F(2) = 0;

F(3) = u(4) ;
F(4) = -1 * g * (1 - (2*u(3)/R));
% F(4) = -1*g;


end

