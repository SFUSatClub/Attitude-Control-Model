%%%%%%%%%%%%%%%%%%
%%%% DYNAMICS %%%%
%%%%%%%%%%%%%%%%%%


% INPUTS
%--------------------------------------------------------------------------
% DYNAMICS_FUNCTION(Qs_old, XXX, Ws_old, XXX, Or_new, XXX, PWM_new)

% Qs_old = old cubesat orientation
% Ws_old = old cubesat velocity
% Or_new = new reaction wheel velocity
% PWM_new = new PWM

%--------------------------------------------------------------------------

% Program steps -> 
%
% 1 - Calculate reaction wheel torque
% 2 - Calculate the total torque
% 3 - Calculate the change in cubesat angular velocity
% 4 - Calculate the new cubesat angular velocity
% 5 - Calculate change in orientation quaternion
% 6 - Calculate the new orientation quaternion
%
%
% OUTPUTS
%--------------------------------------------------------------------------
% DYNAMICS_FUNCTION(Ws_new, XXX, Qs_new, XXX, XXX, XXX, XXX)
%
% New cubesat angular velocity
% New cubesat orientation quaternion  
%
%--------------------------------------------------------------------------
%
%%
% -- VARIABLE INITIALIZATIONS --

%%

%timestep

Ts = 0;

%%
%-------------------------------------------------
% PWM Signal
%-------------------------------------------------

PWMx = 0;
PWMy = 0;
PWMz = 0;

PWM = [PWMx; PWMy; PWMz];

%%
%-------------------------------------------------
% REACTION WHEEL CONSTANTS
%-------------------------------------------------

% thickness of the disk portion of the reaction wheel
tdisk = 1.5/1000;
% thickness of the ring portion of the reaction wheel
tring = 12/1000;
% outer radius of the reaction wheel ring
rro = 55/2000;
% inner radius of the reaction wheel ring
rri = 37/2000;
% density of the reaction wheel
drxn = 7850;

% total mass of the reaction wheel
Mr = drxn*pi*(((rri^2)*(tdisk))+(((rro^2)-(rri^2))*(tring-tdisk)));
% Moment of inertia of the disk portion of the reaction wheel
J_reac_disk = ((drxn*pi*rri^2*tdisk)*(rro^2))/2;
% Moment of inertia of the ring portion of the reaction wheel
J_reac_ring = ((drxn*pi*(((rro^2)-(rri^2))*(tring-tdisk)))*((rro^2)+(rri^2)))/2;
% Total inertia of one reaction wheel
J_reac = J_reac_disk + J_reac_ring;

J_reactionwheel_matrix = [J_reac, 0, 0; 0, J_reac, 0; 0, 0, J_reac];

%%
%-------------------------------------------------
% REACTION WHEEL TRANSIENTS
%-------------------------------------------------

% New Reaction Wheel Rotational Velocty

ox_new = 0;
oy_new = 0;
oz_new = 0;

Or_new = [ox_new, oy_new, oz_new];
Hr_new = J_reactionwheel_matrix * Or_new;

% Old Reaction Wheel Rotational Velocty

ox_old = 0;
oy_old = 0;
oz_old = 0;

Or_old = [ox_old; oy_old; oz_old];
Hr_old = J_reactionwheel_matrix * Or_old;

%%
%-------------------------------------------------
% CUBESAT CONSTANTS
%-------------------------------------------------

% NOTE: Assumption -- 
% Uniform density rectangular prism 
% used for the moment of inertia

% Cubesat Density (Not currently being used)
Dc = 7850;
% Cubesat Volume (Not currently being used)
Vc=hc*wc*dc;

% Cubesat Height
hc = 0.3; 
% Cubesat Width
wc = 0.1;
% Cubesat Depth
dc = 0.1;

% Cubesat Mass (Usually equal to Vc/Dc)
Mc = 4;

% Cubesat moment of inertia
jbxx = (1/12)*Mc*((hc^2)+(dc^2));
jbyy = (1/12)*Mc*((hc^2)+(dc^2));
jbzz = (1/12)*Mc*((wc^2)+(dc^2));

% Cubesat Inertia Matrix

J_cubesat_matrix = [jbxx 0 0; 0 jbyy 0; 0 0 jbzz];

%%
%-------------------------------------------------
% CUBESAT TRANSIENTS
%-------------------------------------------------

% Cubesat angular velocity

wx_old = 0;
wy_old = 0;
wz_old = 0;

Ws_old = [wx_old; wy_old; wz_old];

% Change in the cubesat angular velocity

wx_dot = 0;
wy_dot = 0;
wz_dot = 0;

Ws_dot = [wx_dot; wy_dot; wz_dot];

% Updated cubesat angular velocity

wx_new = 0;
wy_new = 0;
wz_new = 0;

Ws_new = [wx_new; wy_new; wz_new];

% Updated cubesat omega matrix

Ws_new_Omega_matrix = [       0, -wx_new, -wy_new, -wz_new
                         wx_new,        0,  wz_new, -wy_new
                        -wy_new, -wz_new,        0,  wx_new
                         wz_new,  wy_new, -wx_new,        0 ];

% Orientation Quaternion

qs0_old = 0;
qsi_old = 0;
qsj_old = 0;
qsk_old = 0;

Qs_old = [qs0_old; qsi_old; qsj_old; qsk_old];

% Change in Orientation Quaternion

qs0_dot = 0; 
qsi_dot = 0; 
qsj_dot = 0; 
qsk_dot = 0;
Qs_dot = [qs0_dot; qsi_dot; qsj_dot; qsk_dot];

% Updated Orientation Quaternion

qs0_new = 0; 
qsi_new = 0; 
qsj_new = 0; 
qsk_new = 0;
Qs_new = [qs0_new; qsi_new; qsj_new; qsk_new];

% Position Quaternion

% qg0 = 0;
% qgi = 0;
% qgj = 0;
% qgk = 0;
%Qg = [qg0; qgi; qgj; qgk];

%%
%-------------------------------------------------
% Inertial to Body Rotation Matrix
%-------------------------------------------------

Aib = [(qs0^2 + qsi^2 - qsj^2 - qsk^2),           2*(qsi*qsj - qsk*qs0),           2*(qsi*qsk + qsi*qs0) 
                 2*(qsi*qsj + qsk*qs0), (qs0^2 - qsi^2 + qsj^2 - qsk^2),           2*(qsj*qsk - qsi*qs0) 
                 2*(qsi*qsk - qsj*qs0),           2*(qsj*qsk + qsi*qs0), (qs0^2 - qsi^2 - qsj^2 + qsk^2)];
             
             
%%
%-------------------------------------------------
% EXTERNAL TORQUES
%-------------------------------------------------

% AERODYNAMIC DRAG TORQUE
%
%
% T_aero = (1/2)*d_atmos*(v_sat^2)*Cd*A*(cross(uv,scp));
%
% d_atmos    - is the atmospheric density (dependent on altitude)
% v_sat      - is the orbital velocity of the cubesat
% Cd         - is the drag coefficient
% A          - is the area facing the velocity vector (can be calculated if the
%              orientation is known)
% uv         - is the unit velocity vector
% scp        - is the vector from the center of pressure to the center of mass
%
%
% GRAVITY GRADIENT TORQUE
%
%
% T_grav = (3*mu*cross(ue,J*ue))/(Ro^3)
% 
% mu        - geocentric gravitational constant
% ue        - unit vector towards nadir
% Ro        - distance from the center of Earth to the satellite 
% J         - cubesat inertia matrix
%
%
% SOLAR RADIATION TORQUE
%
%
% T_sol = F(cp-cg);
% F = (Fs/c)*As*(1+q)*cos(beta)
%
% Fs        - solar constant (1367 W/m^2)
% c         - speed of light
% As        - surface area
% q         - reflectance factor (either 0 or 1)
% beta      - angle of incidence of the sun
% cp        - center of pressure
% cg        - center of gravity
%
%
%
%%
%-------------------------------------------------
%-------------------------------------------------
%-----------                           -----------
%-----------       MAIN PROGRAM        -----------
%-----------                           -----------
%-------------------------------------------------
%-------------------------------------------------
%
%%
%
% Input Package entering
%
%  S = [  qs0      qg0       wx       Ox   PWMx
%         qsi      qgi       wy       Oy   PWMy
%         qsj      qgj       wz       Oz   PWMz
%         qsk      qgk       Ts        T      0   ]
%
%
% ----------------------------------------------------------------------
% -- Take all the variables from S and assign them to local variables --
% ----------------------------------------------------------------------
%
%
% 1 - orientation quaternion

%qs0_old = S(1,1);
%qsi_old = S(2,1);
%qsj_old = S(3,1);
%qsk_old = S(4,1);
%Qs_old = [qs0_old; qsi_old; qsj_old; qsk_old];

% 2 - position quaternion
% (not in use)

%qg0 = S(1,2);
%qgi = S(2,2);
%qgj = S(3,2);
%qgk = S(4,2);

%Qgi = [qg0; qgi; qgj; qgk];

% 3 - Cubesat angular velocity

%wx_old = S(1,3);
%wy_old = S(2,3);
%wz_old = S(3,3);
%Ws_old = [wx_old; wy_old; wz_old];

% 4 - time step

%Ts = S(4,3);

% 5 - Reaction Wheel angular velocity 

ox_new = S(1,4);
oy_new = S(2,4);
oz_new = S(3,4);
Or_new = [ox_new; oy_new; oz_new];

% 5 - time total

% T = S(4,4);

% 7 - PWM Signal 

PWMx = S(1,5);
PWMy = S(2,5);
PWMz = S(3,5);
PWM = [PWMx; PWMy; PWMz];

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%            timestep Ts            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 1 - calculate reaction wheel torque

% IANS PWM TORQUE CONVERSION
%----------------------------------------------------------------------
%----------------------------------------------------------------------

%Torque to wheels (Or, PWM)

% (wheel speed*(-torque at no speed)/(max motor speed)) + torque at no speed
% T_reac = (Or*(-5/20000) + 5);
% O_want = ((20000/1) * PWM); %max duty / max speed
% dO_want = O_want - Or;
% A_want = dO_want/Ts;
% T_want = J_reactionwheel_matrix * transpose(A_want);

%checking if the requested torque is greater than the torque available, and
%updates the torque applied matrix with either, the requested torque or the
%torque available.
% i = 1;
% while(i <=3)
% if(T_want(i) > L_available(i))
%   Lbw(i) = L_available(i);
% else
%   Lbw(i) = T_want(i);
% end
% i = i + 1;
%end

%Lbw is the output of this code, it is the torque applied to the reaction
%wheels from the motors. Still missing is the precession componennt which
%whill change the O vector based on how the w vector is, so the speed
%dumped from the body into the wheels from spinning. We will need to add
%this in later.

% 1 - Calculate the reaction wheel torque

% Lbw = [lbwx, lbwy, lbwz];

%----------------------------------------------------------------------
%----------------------------------------------------------------------
% ^^ THIS WILL OUTPUT T_reac

% FOR NOW, JUST CALCULATE THE INPUT TORQUE FROM THE REACTION WHEELS BY
% CALCULATING THE DIFFERENCE BETWEEN THE REACTION WHEEL ROTATIONAL VELOCITY
% LAST TIME STEP BY THE REACTION WHEEL ROTATIONAL VELOCITY THIS TIME STEP 

% Calculate the new reaction wheel momentum

Hr_new = J_reactionwheel_matrix * Or_new;

% L = Hdot = T_reac

T_reac = Hr_new - Hr_old;

% Update the old reaction wheel velocities

Or_old = Or_new;
Hr_old = Hr_new;

% 2 - Calculate the total torque

%T_sol = 0;
%T_grav = 0;
%T_aero = 0;

T_tot = (T_sol + T_grav + T_aero) - T_reac; 

% 3 - Calculate the change in cubesat angular velocity

Ws_dot = inverse(J_cubesat_matrix)*(T_tot);

%     Calculate the cubesat inertia to body rotation matrix
%     ONLY APPLICABLE TO THE EXTERNAL PERTURBATIONS 
%
% Aib = [(qs0^2 + qsi^2 - qsj^2 - qsk^2),           2*(qsi*qsj - qsk*qs0),           2*(qsi*qsk + qsi*qs0) 
%                 2*(qsi*qsj + qsk*qs0), (qs0^2 - qsi^2 + qsj^2 - qsk^2),           2*(qsj*qsk - qsi*qs0) 
%                 2*(qsi*qsk - qsj*qs0),           2*(qsj*qsk + qsi*qs0), (qs0^2 - qsi^2 - qsj^2 + qsk^2)];


% 4 - Calculate the new cubesat angular velocity

Ws_new = Ws_old + Ws_dot;

% update the old velocity

Ws_old = Ws_new;

% 5 - Calculate change in orientation quaternion

Ws_new_Omega_matrix = [       0,  -wx_new, -wy_new, -wz_new
                         wx_new,        0,  wz_new, -wy_new
                        -wy_new,  -wz_new,       0,  wx_new
                         wz_new,   wy_new, -wx_new,       0 ];
 
Qs_dot = (1/2)*Ws_new_Omega_matrix*Qsi;

% 6 - Calculate the new orientation quaternion

Qs_new = Qs_old + Ts*(Qs_dot);

% update the old quaternion

Qs_old = Qs_new;

%%

% Define the outputs

% 1 - updated orientation quaternion 

S(1,1) = qs0_new;
S(2,1) = qsi_new;
S(3,1) = qsj_new;
S(4,1) = qsk_new;

% 2 - updated position quaternion

%S(1,2) = qg0;
%S(2,2) = qgi;
%S(3,2) = qgj;
%S(4,2) = qgk;

% 3 - updated cubesat velocity

S(1,3) = wx_new;
S(2,3) = wy_new;
S(3,3) = wz_new;

% 4 - updated reaction wheel velocity

%S(1,3) = ox_new;
%S(2,3) = oy_new;
%S(3,3) = oz_new;

% 5 - final timestep

%S(4,3) = Ts;

% Output Package Leaving
%
%
%
%
% S = [  qs0      qg0       wx       Ox
%        qsi      qgi       wy       Oy
%        qsj      qgj       wz       Oz
%        qsk      qgk       Ts       Tt  ]

%END