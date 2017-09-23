function[Outputs]  = DynamicsFunctionPassive(Ts, MagneticFieldVectorECEF_x, MagneticFieldVectorECEF_y, MagneticFieldVectorECEF_z, Roll_Old, Pitch_Old, Yaw_Old, AngularVelocityRoll_Old, AngularVelocityPitch_Old, AngularVelocityYaw_Old, MagneticMomentPermanentMagnet, MagneticMomentHysteresisRods)

%%

% Definitions

Inertial_Tensor = [0.0333333333333333 0                  0 
                   0                  0.0333333333333333 0 
                   0                  0                  0.00666666666666667];

% ^^ The inertial Tensor should be passed in as a parameter (eventually)

% -- Respective input definitions --
  
% B_ECI - Earths Magnetic Field Vector WRT ECI (Teslas)

% B_Body - Earths Magnetic Field Vector WRT BodyFrame (Teslas)

% Mu    - Magnetic Moment Vector (which includes the permanent magnet as 
% well as both sets of hysteresis rods) (A*m^2 or Nm/Tesla)

% T_new - Direction of the applied torque, due to the magnet, hyst rods,
% and external torques (Nm)

% O_old - Satellite Orientation from previous timestep (rad)

% O_dot - The descretized change in satellite orientation (aka angular 
% velocity) between the last timestep and the current timestep (rad/s)

% O_new - Newly calculated satellite orientation (rad)

% W_old - Satellite angular velocity from previous timestep (rad/s)

% W_dot - The descetized change in satellite angular velocity (aka angular
% acceleration) between the last timestep and the current timestep (rad/s)

% W_new - Newly calculated satellite angular velocity (rad)

% H_old - Satellite angular momentum from the previous timestep (kg*m^2/s)


%Define the DCMs that describe the orientation of the satellite with
%respect to the ECI frame of reference
DCMroll = [1, 0, 0; 0, cos(Roll_Old), sin(Roll_Old); 0, -sin(Roll_Old), cos(Roll_Old)];
DCMpitch = [cos(Pitch_Old), 0, -sin(Pitch_Old); 0, 1, 0; sin(Pitch_Old), 0, cos(Pitch_Old)];
DCMyaw = [cos(Yaw_Old), sin(Yaw_Old), 0; -sin(Yaw_Old), cos(Yaw_Old), 0; 0, 0, 1];

%convert the magnetic field vector from ECEF into ECI
MagneticFieldVectorECEFtoECI_DCM = dcmeci2ecef('IAU-2000/2006', datevec(SystemTimeObj.dateAndTime));
B_ECI = transpose(MagneticFieldVectorECEFtoECI_DCM)*[MagneticFieldVectorECEF_x; MagneticFieldVectorECEF_y; MagneticFieldVectorECEF_z];

%convert the magnetic field vector B from ECEF into Body Frame
B_Body = (Ryaw*(Rpitch*(Rroll*[bx_new; by_new; bz_new])));

Mu = [2*MagneticMomentHysteresisRods, 2*MagneticMomentHysteresisRods, MagneticMomentPermanentMagnet];
O_old = [Roll_Old; Pitch_Old; Yaw_Old]; 
W_old = [AngularVelocityRoll_Old; AngularVelocityPitch_Old; AngularVelocityYaw_Old];
H_old = Inertial_Tensor*W_old;

%Mu_body = Mu_body_rotate(O_old(1), O_old(2), O_old(3));

% Output variable initialization
Roll_new = 0;
Pitch_new = 0; 
Yaw_new = 0;
AngularVelocity_Roll_New = 0; 
AngularVelocity_Pitch_New = 0; 
AngularVelocity_Yaw_New = 0;

%%
% Calculations
% Step 1 - Find the new applied torque to the body
T_new = cross(Mu, B_Body);

% Step 2 - Calculate the new satellite angular velocity using the new torque 
% (this equation accounts for the systems non-linearity aka gyroscopic forces
%  aka precessive forces)
W_dot = transpose(Inertia_Tensor)*(-T_new - cross(W_old, H_old));
W_new = W_old + Ts*W_dot;

% Step 3 - Calculate the new satellite orientation
O_dot = [      0,  wz_old, -wy_old 
         -wz_old,       0,  wx_old 
          wy_old, -wx_old,       0] * O_old;

      
O_new = O_old + Ts*O_dot;

% Step 3 - Assign calculated values to the output variables
Outputs = [O_new(1), O_new(2), O_new(3), W_new(1), W_new(2), W_new(3)];

end