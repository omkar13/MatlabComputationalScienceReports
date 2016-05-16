function F = odeFunctionQ3d(t,u)
% F(1) = dx/dt 
% F(2) = dvx/dt
% F(3) = dy/dt 
% F(4) = dvy/dt
global g R constant xvel_wind yvel_wind; % constant is b/m
F=zeros(length(u),1);

F(1) = u(2) ;
F(2) = - constant  * u(2) *exp(-u(3) / 1000)*(power(u(2) - xvel_wind,2) + power(yvel_wind,2)) / sqrt(u(2)*u(2) + u(4)*u(4));

F(3) = u(4) ;
%F(4) = -1 * g * (1 - (2*u(3)/R));
% F(4) = -1*g;
F(4) = - constant  * u(4) *exp(-u(3) / 1000)*(power(u(2) - xvel_wind,2) + power(yvel_wind,2)) / sqrt(u(2)*u(2) + u(4)*u(4)) - g;

end

