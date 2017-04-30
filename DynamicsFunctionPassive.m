function[x_new, y_new, z_new, wx_cubesat_new, wy_cubesat_new, wz_cubesat_new]  = DynamicsFunctionPassive(Ts, bx_field_new, by_field_new, bz_field_new, x_old, y_old, z_old, wx_cubesat_old, wy_cubesat_old, wz_cubesat_old, Mu_magnet_new)

% 1 - define the inertia matrix

J_cubesat_matrix = [0.0333333333333333 0 0; 0 0.0333333333333333 0; 0 0 0.00666666666666667];

% 2 - calculations from inputs

B_field_new = [bx_field_new; by_field_new; bz_field_new];
Torque_Applied_New = cross(Mu_magnet_new, B_field_new);
Orientation_old = [x_old; y_old; z_old]; 
W_cubesat_old = [wx_cubesat_old; wy_cubesat_old; wz_cubesat_old];

% 3 - Calculate the new cubesat angular velocity

W_cubesat_dot = inv(J_cubesat_matrix)*Torque_Applied_New;
W_cubesat_new = W_cubesat_old + W_cubesat_dot;

% 4 - Calculate new orientation quaternion

Orientation_dot = Ts*W_cubesat_new;
Orientation_new = Orientation_old + Ts*W_cubesat_new;

end