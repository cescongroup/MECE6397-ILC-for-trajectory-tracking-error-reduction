%% Simulation parameters
tsim_ILC = 50; % total simulation time
tsamp_ILC = 0.10; % sample time
ref_period = 2*pi; 

time_ILC = t; %[0:tsamp_ILC:tsim_ILC-tsamp_ILC]';

%% Reference trajectory
xc_ILC = x_c;
correction_ILC = zeros(size(xc_ILC));
pitch_c_ILC=pitch_c;
pitch_ILC=pitch.Data;
yc_ILC = y_c;
correction_roll_ILC = zeros(size(yc_ILC));
roll_c_ILC=roll_c;
roll_ILC=roll.Data;

% x_c=;
% y_c=;
% z_c=;

% ---  To describe transfer functions in discrete and continous time 
z = tf([1 0],1,tsamp_ILC);     
s = tf([1 0],1);

%% Heuristic filter design
% X filter parameters
p=25;
p1=6;
p2=10;
alpha=0.8;
beta=10;
Qd = c2d( 1/(s/p+1),tsamp_ILC);
%Qd = c2d( tf([0 1],[1 20 60]),tsamp_ILC);
Ld = alpha*z^beta;

[Ld_B,Ld_A] = tfdata(Ld,'v');
[Qd_B,Qd_A] = tfdata(Qd,'v');


% y filter parameters
p_y=18;
p1=6;
p2=10;
alpha_y=2;
beta_y=8;%2;
Qd_y = c2d( 1/(s/p_y+1),tsamp_ILC);
%Qd_y = c2d( tf([0 1],[1 5 3]),tsamp_ILC);
Ld_y = alpha_y*z^beta_y;

[Ld_By,Ld_Ay] = tfdata(Ld_y,'v');
[Qd_By,Qd_Ay] = tfdata(Qd_y,'v');

%% Initialize ILC iterations
err=[];
err_x=[];
err_y=[];
idx_ILC=1;