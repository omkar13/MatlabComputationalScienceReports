function F = rhs( t, u )

% u(1) x
% u(2) y
% u(3) vx
% u(4) vy

% F(1) dx/dt
% F(2) dy/dt
% F(3) dvx/dt
% F(4) dvy/dt

% area1 is for time 0.2 to time 0.6 years
% area2 is for time 0.7 to time 1.1 years

global G Ms theta theta_prev area1 area2 year prevx prevy dt;

%theta = atan2(u(2),u(1));
%delta_theta = abs(abs(theta) - abs(theta_prev));

if(t > year*0 && t < year*0.2)
    area1 = area1 + 0.5*hypot(u(1),u(2))*hypot(u(3),u(4))*dt;
    %area1 = area1 + 0.5*(u(1)*u(1) + u(2)*u(2))*delta_theta;
    %area1 = area1 + 0.5 * (u(1)^2 + u(2)^2) * hypot(u(1) - prevx , u(2) - prevy);
end


if(t > year*0.5 && t < year*0.7)
    area2 = area2 + 0.5*hypot(u(1),u(2))*hypot(u(3),u(4))*dt;
    %area2 = area2 + 0.5*(u(1)*u(1) + u(2)*u(2))*delta_theta; 
    %area2 = area2 + 0.5 * (u(1)^2 + u(2)^2) * hypot(u(1) - prevx , u(2) - prevy);
end

theta_prev = theta;
prevx = u(1);
prevy = u(2);

F = zeros(length(u),1);

F(1) = u(3);
F(2) = u(4);
r = sqrt(u(1)*u(1) + u(2)*u(2));        %distance between sun and planet
F(3) = -G*Ms*u(1)/power(r,3);
F(4) = -G*Ms*u(2)/power(r,3);

end

