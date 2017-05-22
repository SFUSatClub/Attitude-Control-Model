function [ Results ] = Model_Executor(Launch_Time, Orbital_Eccentricity, Orbital_Inclination, Orbital_Semimajor_Axis, Orbital_Mesh, Orbital_RAAN, Orbital_Arg_of_Perigee, Orbital_Num_of_Orbits, Magnetic_Moment)
%Main Operation with GUI Inputs
%   Output Format: [True_Anomaly, Altitude, Orbital_Number, Time_since_launch, CM_ECI_x, CM_ECI_y, CM_ECI_z, CM_ECEF_x, CM_ECEF_y, CM_ECEF_z, Cubesat_Orientation_x, Cubesat_Orientation_y, Cubesat_Orientation_z, Cubesat_Rotational_Velocity_x, Cubesat_Rotational_Velocity_y, Cubesat_Rotational_Velocity_z, Magnet_moment_x, Magnet_moment_y, Magnet_moment_z, Earth_B_x_ECEF, Earth_B_y_ECEF, Earth_B_z_ECEF, Sun_x_ECI, Sun_y_ECI, Sun_z_ECI, Sun_x_ECEF, Sun_y_ECEF, Sun_z_ECEF]
%
%

%%  Orbital Propagation Model - Harrison Handley
%   Orbit Propagation - Defines Result_Matrix as
%   [True_Anomaly, Altitude, Orbital_Number, Time_since_launch, CM_ECI_x, CM_ECI_y, CM_ECI_z, CM_ECEF_x, CM_ECEF_y, CM_ECEF_z]
Results = Orbital_Model_Function(Launch_Time, Orbital_Eccentricity, Orbital_Inclination, Orbital_Semimajor_Axis, Orbital_Mesh, Orbital_RAAN, Orbital_Arg_of_Perigee, Orbital_Num_of_Orbits);
Results = vertcat(Results, zeros(1, 10));
%%  Magnetic Field Model - Harrison Handley
%   Earth Magnetic Field Model
%   Add to Results three vectors for Earths magnetic field x, y and z components in ECEF for that rows satellite CM ECEF position
Results = horzcat(Results, zeros(size(Results, 1), 19 ));
Results(:, 20) = Magnetic_Moment(1);
Results(:, 21) = Magnetic_Moment(2);
Results(:, 22) = Magnetic_Moment(3);

%   Find magnetic field of earth at each position in Teslas
for row = 1:(size(Results, 1) - 1)
% r = vector length of xyz
% theta Latitude measured in degrees positive from equator
% phi Longitude measured in degrees positive east from Greenwich
% days Decimal days since January 1, 2015
        r = sqrt(Results(row,8)^2 + Results(row,9)^2 + Results(row,10)^2);
        theta = acosd(sqrt(Results(row,8)^2 + Results(row,9)^2)/r);
        phi = atand(Results(row,9)/Results(row,8));
        Days_since_Jan_1st_2015 = daysact('1-Jan-2015 00:00:00', (Launch_Time + seconds(Results(row, 4))));
        [Br ,Bt, Bp] = IGRF_Model(r, theta, phi,Days_since_Jan_1st_2015);
        [Bx, By, Bz] = sph2cart(Bp, Bt, Br);
        Results(row, 11) = Bx;
        Results(row, 12) = By;
        Results(row, 13) = Bz;
        
        
        Dynamics_Outputs = DynamicsFunctionPassive( Results(row+1, 4) - Results(row, 4), Results(row , 11), Results(row , 12), Results(row , 13), Results(row , 14), Results(row , 15), Results(row , 16), Results(row, 17), Results(row, 18), Results(row, 19), Results(row, 20), Results(row, 21), Results(row, 22));
        Results(row + 1, 14) = Dynamics_Outputs(1);
        Results(row + 1, 15) = Dynamics_Outputs(2);
        Results(row + 1, 16) = Dynamics_Outputs(3);
        Results(row + 1, 17) = Dynamics_Outputs(4);
        Results(row + 1, 18) = Dynamics_Outputs(5);
        Results(row + 1, 19) = Dynamics_Outputs(6);
        
        Sun_Position_Output = Suns_Orbit(Launch_Time, Results(row, 4));
        Results(row, 23) = Sun_Position_Output(1);
        Results(row, 24) = Sun_Position_Output(2);
        Results(row, 25) = Sun_Position_Output(3);
        Results(row, 26) = Sun_Position_Output(4);
        Results(row, 27) = Sun_Position_Output(5);
        Results(row, 28) = Sun_Position_Output(6);
        
        Results(row, 29) = Shadow_Detection(Results(row, 23), Results(row, 24), Results(row, 25), Results(row, 5), Results(row, 6), Results(row, 7));
end

%%  Dynamic Model



%%  End of Simulation

end

