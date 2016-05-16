%this script is used to calculate the variation of amplitude of the damped
%oscillations with driving frequency

clear all;
close all;

global C mass l g beta Fd driver_angular_freq max_ampl driver_time_period simulationt;


g=9.8;
l=9.8; % so that g/l is 1

%natural angular_frequency is 1. We will run the code for driving_freq = 0
%to 5.

timescale=2*pi*sqrt(l/g);

mass = 0.1;

%we will be considering only the underdamped case.
C = 0.02/3 % C is the drag constant Fdamp = C*length*omega 
beta = C/(2*mass);
Fd = 1.5 % this is the driving force

driver_angular_freq = 1; % its the angular frequency
 
dt=timescale/100;
simulationt=50*timescale;
start_time = 0;


theta_degrees_initial = 0.5*180/pi; %given 0.5 radians
omega_initial = 0;
 
%using ode solver
%give initial conditions
u0 = zeros(2,1);
u0(1) = theta_degrees_initial*pi/180;
u0(2) = omega_initial;

start_freq = 0.1;
end_freq = 5;
incremental_freq = 0.02;

frequency_array = start_freq : incremental_freq : end_freq ; 
amplitude_array1 = zeros(length(frequency_array));
amplitude_array1_analytical = zeros(length(frequency_array));

amplitude_array2 = zeros(length(frequency_array));
amplitude_array3 = zeros(length(frequency_array));

index = 1;

% we are now plotting 3 graphs based on different values of beta and
% comparing their quality factors.

C = 0.02; 
beta = C/(2*mass);

for driver_angular_freq = start_freq : incremental_freq : end_freq    
    
    max_ampl = 0;
    driver_time_period = 2*pi / driver_angular_freq;
    
    %explain this step 
    simulationt = -48.979*driver_angular_freq + 304.897;                % for optimising the simulation time
    %for under damping
    [t,u] = ode45(@damp_driven_function , [start_time : dt : simulationt] , u0); 
    amplitude_array1(index) = max_ampl;
    %analytical solution
    amplitude_array1_analytical(index) = (Fd/mass)/sqrt((1-driver_angular_freq)*(1-driver_angular_freq) + 4*driver_angular_freq*driver_angular_freq*beta*beta);
    index = index + 1;
    theta2=u(:,1);
    %omega2 = u(:,2);
end
%{
C = 0.02;
beta = C/(2*mass);
index = 1;
for driver_angular_freq = start_freq : incremental_freq : end_freq    
    
    max_ampl = 0;
    driver_time_period = 2*pi / driver_angular_freq;
    
    %explain this step 
    simulationt = -48.979*driver_angular_freq + 304.897;                % for optimising the simulation time
    %for under damping
    [t,u] = ode45(@damp_driven_function , [start_time : dt : simulationt] , u0); 
    amplitude_array2(index) = max_ampl;
    index = index + 1;
    %theta2=u(:,1)*180/pi;
    %omega2 = u(:,2);
end
%}
%{
C=0.02*3;
beta = C/(2*mass);
index = 1;

for driver_angular_freq = start_freq : incremental_freq : end_freq    
    
    max_ampl = 0;
    driver_time_period = 2*pi / driver_angular_freq;
    
    %explain this step 
    simulationt = -48.979*driver_angular_freq + 304.897;                % for optimising the simulation time
    %for under damping
    [t,u] = ode45(@damp_driven_function , [start_time : dt : simulationt] , u0); 
    amplitude_array3(index) = max_ampl;
    index = index + 1;
    %theta2=u(:,1)*180/pi;
   % omega2 = u(:,2);
end
%}
plot(frequency_array , amplitude_array1,'r',frequency_array, amplitude_array1_analytical, 'b' ); %, frequency_array,amplitude_array2 ,'g',frequency_array, amplitude_array3,'b')
xlabel('frequency of driving force')
ylabel('amplitude of oscillations')
title('observation of resonance phenomena')

%figure();
%plot(t,theta2);