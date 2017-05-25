%function [ output_args ] = Harrisons_Dynamics( Inertia_Tensor_BodyFrame, Magnetic_Moment_BodyFrame, Bx_Earth, By_Earth, Bz_Earth, Pitch_Orientation, Roll_Orientation, Yaw_Orientation, Pitch_AngVel, Roll_AngVel, Yaw_AngVel, Time_step, Current_Time )
%   Inertia_Tensor_BodyFrame - Satellites Inertia Matrix in Body Reference
%   Frame
%   Magnetic_Moment_BodyFrame - Satellites Magnetic Moment (Pitch, Roll and
%   Yaw axis) in Body Reference Frame
%   Bx_Earth, By_Earth, Bz_Earth - - Earths Magnetic Field in ECEF from CM
%   of satellite in Teslas
%   Pitch_Orientation - Pitch Orientation from ECI CM to Body Frame
%   Roll_Orientation - Roll Orientation from ECI CM to Body Frame
%   Yaw_Orientation - Yaw Orientation from ECI CM to Body Frame
%   Pitch_AngVel - Angular Velocity of satellite around the pitch axis
%   Roll_AngVel - Angular Velocity of satellite around the roll axis
%   Yaw_AngVel - Angular Velocity of satellite around the yaw axis
%   Time_step - Time Step between iterations

Inertia_Tensor_BodyFrame = [0.0267, 0.03, 0.1; 0.03, 0.1333, 0.01; 0.03, 0.01, 0.1333]; 
Magnetic_Moment_BodyFrame = [0.1, 0.5, 0.3];
Bx_Earth = 0.05;
By_Earth = 0.0001;
Bz_Earth = 0.003;
Pitch_Orientation = 0;
Roll_Orientation = 0;
Yaw_Orientation = 0;
Pitch_AngVel = 0;
Roll_AngVel = 0;
Yaw_AngVel = 0;
Time_step = 10;
Current_Time = datetime();

%   Convert Earth Magnetic field frame to Body Reference
%   Convert from ECEF to ECI
Date_Array = [year(Current_Time), month(Current_Time), day(Current_Time), hour(Current_Time), minute(Current_Time), second(Current_Time)];
ECI2ECEF_Matrix = dcmeci2ecef('IAU-2000/2006', Date_Array);
%ECI2ECEF_Matrix = eye(3); For Testing
Earth_Magnetic_Field_ECI = [Bx_Earth, By_Earth, Bz_Earth]*inv(ECI2ECEF_Matrix)
Rz_ECI2BodyRefFrame = [cos(Yaw_Orientation), -sin(Yaw_Orientation), 0;...
                      sin(Yaw_Orientation), cos(Yaw_Orientation), 0;...
                      0, 0, 1];
Ry_ECI2BodyRefFrame = [cos(Pitch_Orientation), 0, sin(Pitch_Orientation);...
                      0, 1, 0;...
                      -sin(Pitch_Orientation), 0, cos(Pitch_Orientation)];
Rx_ECI2BodyRefFrame = [1, 0, 0;...
                      0, cos(Roll_Orientation), -sin(Roll_Orientation);...
                      0, sin(Roll_Orientation), cos(Roll_Orientation)];
RzRyRx = Rz_ECI2BodyRefFrame*Ry_ECI2BodyRefFrame*Rx_ECI2BodyRefFrame
Earth_Magnetic_Field_BodyRefFrame = Earth_Magnetic_Field_ECI*RzRyRx
Magnetic_Torque_BodyRefFrame = cross(Magnetic_Moment_BodyFrame, Earth_Magnetic_Field_BodyRefFrame)
Total_Torque = Magnetic_Torque_BodyRefFrame
%end

