function F=odeFunctionQ2(t,u)
% function output =name(input)
% right-hand side function for Matlab's ODE solver,


% In our case we will use:
% u(1) -> x
% u(2) -> v

% declare the globals so its value
% set in the main script can be used here
global g theta us uk; %initial_vel;

% make the column vector F filled with zeros
F=zeros(length(u),1);

% Now build the elements of F
%
% so the equation dx/dt=v means that F(1)=u(2)
F(1)=u(2);
% Again, in our original ODEs we have:

% so the equation dv/dt=g*sin(theta)
F(2)=g*sin(theta) - uk*g*cos(theta);