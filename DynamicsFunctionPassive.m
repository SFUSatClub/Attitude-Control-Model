function[Dynamics_Output]  = DynamicsFunctionPassive(Ts, bx_field_new, by_field_new, bz_field_new, x_old, y_old, z_old, wx_cubesat_old, wy_cubesat_old, wz_cubesat_old, Mu_magnet_x, Mu_magnet_y, Mu_magnet_z )

Mu_magnet = [Mu_magnet_x; Mu_magnet_y; Mu_magnet_z];
% 1 - define the inertia matrix

J_cubesat_matrix = [0.0333333333333333 0 0; 0 0.0333333333333333 0; 0 0 0.00666666666666667];

% 2 - calculations from inputs

B_field_new = [bx_field_new; by_field_new; bz_field_new];
Torque_Applied_New = cross(Mu_magnet, B_field_new);
Orientation_old = [x_old; y_old; z_old]; 
W_cubesat_old = [wx_cubesat_old; wy_cubesat_old; wz_cubesat_old];

% 3 - Calculate the new cubesat angular velocity

W_cubesat_dot = inv(J_cubesat_matrix)*Torque_Applied_New;
W_cubesat_new = W_cubesat_old + W_cubesat_dot;
wx_cubesat_new = W_cubesat_new(1);
wy_cubesat_new = W_cubesat_new(2);
wz_cubesat_new = W_cubesat_new(3);

% 4 - Calculate new orientation quaternion

Orientation_dot = Ts*W_cubesat_new;
Orientation_new = Orientation_old + Ts*W_cubesat_new;
x_new = Orientation_new(1);
y_new = Orientation_new(2);
z_new = Orientation_new(3);

Dynamics_Output = [x_new, y_new, z_new, wx_cubesat_new, wy_cubesat_new, wz_cubesat_new];
end