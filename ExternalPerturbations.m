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