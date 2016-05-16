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
%F(1) is dx/dt
%F(2) is dv/dt

F(1)=u(2);

if(u(2) > 0)
   F(2)=g*(sin(theta) - uk*cos(theta));
elseif(u(2) < 0)
   F(2)=g*(sin(theta) + uk*cos(theta));     
else
   if(us>tan(theta))
        F(2) = 0 ;
   else
       F(2) = g*(sin(theta) - uk*cos(theta));
   end     
end        