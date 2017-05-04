function[x_new, y_new, z_new, wx_new, wy_new, wz_new]  = DynamicsFunctionPassive(Ts, bx_new, by_new, bz_new, x_old, y_old, z_old, wx_old, wy_old, wz_old, mu_x, mu_y, mu_z)

% 1 - define the inertia matrix

Jb = [0.0333333333333333 0 0; 0 0.0333333333333333 0; 0 0 0.00666666666666667];

% 2 - calculations from inputs

B_new = [bx_new; by_new; bz_new];
Mu = [mu_x, mu_y, mu_z];
T_New = cross(Mu, B_new);
Orientation_old = [x_old; y_old; z_old]; 
W_old = [wx_old; wy_old; wz_old];
H_old = Jb*W_old;

% 3 - Calculate the new cubesat angular velocity

W_dot = inverse(Jb)*(-T_New - cross(W_old,H_old));
W_new = W_old + W_dot;
[wx_new; wy_new; wz_new] = W_new;

% 4 - Calculate new orientation quaternion

Orientation_dot = Ts*W_dot;
Orientation_new = Orientation_old + Orientation_dot;
[x_new; y_new; z_new] = Orientation_new;

end