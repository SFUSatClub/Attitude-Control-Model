function [ Results ] = Model_Executor(Launch_Time, Orbital_Eccentricity, Orbital_Inclination, Orbital_Semimajor_Axis, Orbital_Mesh, Orbital_RAAN, Orbital_Arg_of_Perigee, Orbital_Num_of_Orbits)
%Main Operation with GUI Inputs
%   Output Format: [True_Anomaly, Altitude, Orbital_Number, Time_since_launch, CM_ECI_x, CM_ECI_y, CM_ECI_z, CM_ECEF_x, CM_ECEF_y, CM_ECEF_z, Earth_B_x_ECEF, Earth_B_y_ECEF, Earth_B_z_ECEF]


%%  Orbital Propagation Model - Harrison Handley
%   Orbit Propagation - Defines Result_Matrix as
%   [True_Anomaly, Altitude, Orbital_Number, Time_since_launch, CM_ECI_x, CM_ECI_y, CM_ECI_z, CM_ECEF_x, CM_ECEF_y, CM_ECEF_z]
Results = Orbital_Model_Function(Launch_Time, Orbital_Eccentricity, Orbital_Inclination, Orbital_Semimajor_Axis, Orbital_Mesh, Orbital_RAAN, Orbital_Arg_of_Perigee, Orbital_Num_of_Orbits);

%%  Magnetic Field Model - Harrison Handley
%   Earth Magnetic Field Model
%   Add to Results three vectors for Earths magnetic field x, y and z components in ECEF for that rows satellite CM ECEF position
Results = horzcat(Results, zeros(size(Results, 1), 3 ));

%   Find magnetic field of earth at each position in Teslas
for row = 1:size(Results, 1)
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
end

%%  Dynamic Model



%%  End of Simulation
save('Results', 'Results');

end

