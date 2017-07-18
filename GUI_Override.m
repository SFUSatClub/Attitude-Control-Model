%Main Operation with GUI Inputs
%   Output Format: [True_Anomaly, Altitude, Orbital_Number, Time_since_launch, CM_ECI_x, CM_ECI_y, CM_ECI_z, CM_ECEF_x, CM_ECEF_y, CM_ECEF_z, Earth_B_x_ECEF, Earth_B_y_ECEF, Earth_B_z_ECEF]

%% 
%   GUI Replacement
Launch_Date = datetime();
%   Orbital Properties
Eccentricity = 0.0007373;
Inclination = 0.9013;     %[rad]
Semimajor_Axis = 6775200;   %[m]
Orbital_Interval = 100;
RAAN = 2.1078; %[rad]
Arg_of_Perigee = 5.95;  %[rad]
Num_of_Orbits = 5;
Magnetic_Moment = [ 0.5; 0.1; 0.1];

%   Dynamic Properties
Inertia_Tensor = [0.0267, 0.03, 0.1; 0.03, 0.1333, 0.01; 0.03, 0.01, 0.1333]; % x in long direction [kg*m2]
Results = Model_Executor(Launch_Date, Eccentricity, Inclination, Semimajor_Axis, Orbital_Interval, RAAN, Arg_of_Perigee, Num_of_Orbits, Magnetic_Moment);
Column_Header = {'True Anomaly [rad]', 'Altitude [m]', 'Satellite Orbital Number', 'Time (s)', 'Sat ECI_x [rad]', 'Sat ECI_y [rad]', 'Sat ECI_z [rad]', 'Sat ECEF_x [m]', 'Sat ECEF_y [m]', 'Sat ECEF_z [m]', 'Bx_ECEF [T]', 'By_ECEF [T]', 'Bz_ECEF [T]', 'Sat x_Orientation_ECI', 'Sat y_Orientation_ECI', 'Sat z_Orientation_ECI', 'Sat x_Angular_Velocity_ECI [rad/s]', 'Sat y_Angular_Velocity_ECI [rad/s]', 'Sat z_Angular_Velocity_ECI [rad/s]', 'Magnetic Moment_x', 'Magnetic Moment_y', 'Magnetic Moment_z', 'Sun x_ECI [m]', 'Sun y_ECI [m]', 'Sun z_ECI [m]', 'Sun x_ECEF [m]', 'Sun y_ECEF [m]', 'Sun z_ECEF [m]', 'Shadow [T or F]'};
Final_Results = [Column_Header; num2cell(Results)];
%   Model Operation

%%  Orbital Propagation Model - Harrison Handley
%   Orbit Propagation - Defines Result_Matrix as
%   [True_Anomaly, Altitude, Orbital_Number, Time_since_launch, CM_ECI_x, CM_ECI_y, CM_ECI_z, CM_ECEF_x, CM_ECEF_y, CM_ECEF_z]
% Results = Orbital_Model_Function(Launch_Time, Orbital_Eccentricity, Orbital_Inclination, Orbital_Semimajor_Axis, Orbital_Mesh, Orbital_RAAN, Orbital_Arg_of_Perigee, Orbital_Num_of_Orbits);

%%  Magnetic Field Model - Harrison Handley
%   Earth Magnetic Field Model
%   Add to Results three vectors for Earths magnetic field x, y and z components in ECEF for that rows satellite CM ECEF position
% Results = horzcat(Results, zeros(size(Results, 1), 3 ));

%   Find magnetic field of earth at each position in Teslas
% for row = 1:size(Results, 1)
% % r = vector length of xyz
% % theta Latitude measured in degrees positive from equator
% % phi Longitude measured in degrees positive east from Greenwich
% % days Decimal days since January 1, 2015
%         r = sqrt(Results(row,8)^2 + Results(row,9)^2 + Results(row,10)^2);
%         theta = acosd(sqrt(Results(row,8)^2 + Results(row,9)^2)/r);
%         phi = atand(Results(row,9)/Results(row,8));
%         Days_since_Jan_1st_2015 = daysact('1-Jan-2015 00:00:00', (Launch_Time + seconds(Results(row, 4))));
%         [Br ,Bt, Bp] = IGRF_Model(r, theta, phi,Days_since_Jan_1st_2015);
%         [Bx, By, Bz] = sph2cart(Bp, Bt, Br);
%         Results(row, 11) = Bx;
%         Results(row, 12) = By;
%         Results(row, 13) = Bz;
% end

%%  Dynamic Model

