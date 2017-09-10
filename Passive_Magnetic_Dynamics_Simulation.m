%definitions
%
% theta_1 = euler angle 1
% theta_2 = euler angle 2
% theta_3 = euler angle 3

% theta_dot_1 = euler angle rate of change 1
% theta_dot_2 = euler angle rate of change 2
% theta_dot_3 = euler angle rate of change 3

% omega_dot_x = body fixed change in angular velocity x
% omega_dot_y = body fixed change in angular velocity y
% omega_dot_z = body fixed change in angular velocity z

% omega_x = body fixed angular velocity x
% omega_y = body fixed angular velocity y
% omega_z = body fixed angular velocity z

% Ixx = Cubesat inertia x
% Iyy = Cubesat inertia y
% Izz = Cubesat inertia x

% Equations of Motion

%[theta_dot_1; theta_dot_2; theta_dot_3] = (1/cos(theta_2))*[            0,             sin(theta_3),                cos(theta_3) 
%                                                                         0, cos(theta_3)*cos(theta_2), -sin(theta_3)*cos(theta_2) 
%                                                              cos(theta_2), sin(theta_3)*sin(theta_2),  cos(theta_3)*sin(theta_2) ] * (omega_x; omega_y; omega_z);

% Ixx*omega_dot_x = -(Izz-Iyy)*omega_y*omega_z + Lz;
% Iyy*omega_dot_y = -(Ixx-Izz)*omega_z*omega_x + Ly;
% Izz*omega_dot_z = -(Ixx-Izz)*omega_z*omega_x + Ly;

% DCM

% [                                              cos(theta_2)*cos(theta_1),                                              cos(theta_2)*sin(theta_1),               -sin(theta_2)
%       (sin(theta_3)*sin(theta_2)*cos(theta_1)-cos(theta_3)*sin(theta_1)), ((sin(theta_3)*sin(theta_2)*sin(theta_1))+cos((theta_3)*cos(theta_1))),   sin(theta_3)*cos(theta_2)
%   ((cos(theta_3)*sin(theta_2)*cos(theta_1))+(sin(theta_3)*sin(theta_1))),   ((cos(theta_3)*sin(theta_2)*sin(theta_1))-sin(theta_3)*cos(theta_1)), (cos(theta_3)*cos(theta_2))];

% H1 =  3*Heq*sin(i)*cos(i)*sin^2(u);
% H2 = -3*Heq*sin(i)*sin(u)*cos(u);
% H3 = Heq(1-(3*sin(i)^2*sin(u)^2));