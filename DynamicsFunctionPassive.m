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


%convert mu vector into angular displacements (ie angles) about the x y and
%z axes

B_new = [bx_new; by_new; bz_new];
Mu = [mu_x, mu_y, mu_z];
O_old = [x_old; y_old; z_old]; 
W_old = [wx_old; wy_old; wz_old];
H_old = Jb*W_old;
%Mu_body = Mu_body_rotate(O_old(1), O_old(2), O_old(3));

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
T_mag = cross(Mu, B_new);

% Step 1 - Calculate the new satellite angular velocity
W_dot = inv(Jb)*(-T_mag - cross(W_old, H_old));
W_new = W_old + Ts*W_dot;

% Step 2 - Calculate the new satellite orientation
O_dot = -[     0,  wz_old, -wy_old 
          -wz_old,       0,  wx_old 
          wy_old, -wx_old,       0]*O_old;

      
O_new = O_old + Ts*O_dot;

% Step 3 - Assign calculated values to the output variables
Outputs = [O_new(1), O_new(2), O_new(3), W_new(1), W_new(2), W_new(3)];

end