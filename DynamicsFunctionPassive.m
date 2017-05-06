function[Outputs]  = DynamicsFunctionPassive(Ts, bx_new, by_new, bz_new, x_old, y_old, z_old, wx_old, wy_old, wz_old, mu_x, mu_y, mu_z)

%%
%Definitions

%Inertia Matrix

Jb = [0.0333333333333333 0                  0 
      0                  0.0333333333333333 0 
      0                  0                  0.00666666666666667];

%Earths Magnetic Field

B_new = [bx_new 
         by_new 
         bz_new];

%Magnetic Moment of the Bar Magnet

Mu = [mu_x 
      mu_y 
      mu_z];
  
%Direction of Bar Magnet Applied Torque

T_New = cross(Mu, B_new);

%Satellite Orientation from previous timestep

O_old = [x_old 
         y_old 
         z_old]; 

%Satellite angular velocity from previous timestep

W_old = [wx_old 
         wy_old
         wz_old];

%Satellite momentum from the previous timestep

H_old = Jb*W_old;

%Output variable initialization

wx_new = 0;
wy_new = 0;
wz_new = 0;
ox_new = 0;
oy_new = 0;
oz_new = 0;

%%
%Calculations

% Step 1 - Calculate the new satellite angular velocity

W_dot = inv(Jb)*(-T_New - cross(W_old,H_old));
W_new = W_old + W_dot;

% Step 2 - Calculate the new satellite orientation

O_dot = Ts*W_dot;
O_new = O_old + O_dot;

% Step 3 - Assign calculated values to the output variables

%wx_new = W_new(1);
%wy_new = W_new(2);
%wz_new = W_new(3);
%ox_new = O_new(1);
%oy_new = O_new(2);
%oz_new = O_new(3);

Outputs = [O_new(1), O_new(2), O_new(3), W_new(1), W_new(2), W_new(3)];


end