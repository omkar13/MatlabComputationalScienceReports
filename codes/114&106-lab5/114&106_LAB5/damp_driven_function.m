
function F = damp_driven_function( t , u )
%DAMPINGFUNCTION Summary of this function goes here

%{
u(1) -> theta     
u(2) -> omega

F(1) -> omega
F(2) -> derivative of omega
%}

global C mass l g beta Fd driver_angular_freq max_ampl simulationt;
global driver_time_period ;

F = zeros(length(u) , 1);

F(1) = u(2);
F(2) = -(2*beta)*u(2) - (g/l)*u(1) + (Fd/(mass*l))*cos(driver_angular_freq*t); %cosine !!!!!!!!!!!!!!!!!!!!


if(t>(simulationt - driver_time_period)) %because the oscillations stabilise during this time
    if(u(1) > max_ampl)
        max_ampl = u(1);    
    end    
end
%}
end
