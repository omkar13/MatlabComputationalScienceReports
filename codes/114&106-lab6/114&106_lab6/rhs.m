function  F = rhs( t ,u )
% This function is used to solve the equation given.

% u(1) = x
% u(2) = vx
% u(3) = y
% u(4) = vy
% F(1) = dx/dt
% F(2) = dvx/dt
% F(3) = dy/dt
% F(4) = dvy/dt

global G M R;

F = zeros(4 , 1);

% the else clause handels the case when the ball hits the ground.
% we want it to bounce back with velocity halved.

%if(u(1)>=0 || u(2) > 0)
    F(1) = u(2);
%else
    %F(1) = -u(2);
%end


F(2) = -G*M/(power(u(1) + R , 2)) ; 
F(3) = u(4);
F(4) = 0;


% this is for making a movie
% hold on
%{
plot(u(1) , u(3) , 'O')
axis([0 0.06 -0.2 10])
pause on
pause(0.02);
%}
end

