function[Outputs]  = DynamicsFunctionPassive(Ts, bx_new, by_new, bz_new, x_old, y_old, z_old, wx_old, wy_old, wz_old, mu_x, mu_y, mu_z)

%%
%Definitions

%Inertia Matrix

Jb = [0.0333333333333333 0                  0 
      0                  0.0333333333333333 0 
      0                  0                  0.00666666666666667];

% -- Respective input definitions --
  
% B_new - Earths Magnetic Field
% Mu    - Magnetic Moment of the Bar Magnet
% T_new - Direction of Bar Magnet Applied Torque
% O_old - Satellite Orientation from previous timestep
% W_old - Satellite angular velocity from previous timestep
% H_old - Satellite momentum from the previous timestep

A=zeros(100,3);
B_new = [bx_new; by_new; bz_new];
Mu = [mu_x; mu_y; mu_z];
T_mag = cross(Mu, B_new);
O_old = [x_old; y_old; z_old]; 
W_old = [wx_old; wy_old; wz_old];
H_old = Jb*W_old;

% Output variable initialization
wx_new = 0; 
wy_new = 0; 
wz_new = 0;
ox_new = 0;
oy_new = 0; 
oz_new = 0;

%%
% Calculations

% Step 1 - Find the total torque

%%
%-------------------------------------------------
% EXTERNAL TORQUES (Given in Nm)
%-------------------------------------------------

% AERODYNAMIC DRAG TORQUE

% d_atmos    - is the atmospheric density (dependent on altitude)
% v_sat      - is the orbital velocity of the cubesat
% Cd         - is the drag coefficient
% A          - is the area facing the velocity vector (can be calculated if the
%              orientation is known)
% uv         - is the unit velocity vector
% scp        - is the vector from the center of pressure to the center of mass

% T_aero = (1/2)*d_atmos*(v_sat^2)*Cd*A*(cross(uv,scp));

% GRAVITY GRADIENT TORQUE

% mu        - geocentric gravitational constant
% ue        - unit vector towards nadir
% Ro        - distance from the center of Earth to the satellite 
% J         - cubesat inertia matrix

%T_grav = (3*mu*cross(ue,J*ue))/(Ro^3)

% SOLAR RADIATION TORQUE

% Fs        - solar constant (1367 W/m^2)
% c         - speed of light (m/s)
% As        - surface area (m^2)                    -- external
% q         - reflectance factor (either 0 or 1)    -- external
% beta      - angle of incidence of the sun         -- external
% cp        - center of pressure                  -- calculate in shadow detection 
% cg        - center of gravity

%Fs = 1367;
%c = 2.998e+8;

%F = (Fs/c)*As*(1+q)*cos(beta)
%T_sol = F*abs(cp-cg);

% Step 1 - Calculate the new satellite angular velocity
W_dot = inv(Jb)*(-T_mag - cross(W_old,H_old));
W_new = W_old + W_dot;

% Step 2 - Calculate the new satellite orientation
O_dot = Ts*W_dot;
O_new = O_old + O_dot;

% Step 3 - Assign calculated values to the output variables
Outputs = [O_new(1), O_new(2), O_new(3), W_new(1), W_new(2), W_new(3)];

end