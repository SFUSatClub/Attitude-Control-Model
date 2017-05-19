function [ Output_Matrix ] = Orbital_Model_Function( Start_Datetime, eccentricity, inclination, semimajor_axis, Num_Intervals, RAAN, argument_of_perigee, num_of_orbits)

%   Keplerian Orbital Model
%   eccentricity is the eccentricity of the orbit specified by GUI
%   inclination is the incliation of the orbit specified by GUI
%   semimajor_axis is half the length of the elliptical orbit specified by
%   GUI in [meters]
%   Num_Intervals is the number of intervals one orbit is split into
%   RAAN is the right ascension of ascending node
%   argument_of_perigee is the the polar angle on the orbital plane from
%   RAAN to the closest point of the orbit to the earth. It is 0 for
%   eccentricity of 0. [Radians]
%   Time values are with respect to the starting time values of the orbit
%   Stuff
Num_of_Terms_in_infinite_Series = 10;
GM = 3.986005*10^14;
%   [Sat_True_Anomaly, Altitude, Orbit #, Time,
%   ECI_x, ECI_y, ECI_z, ECEF_x, ECEF_y, ECEF_z]

% Orbital_Matrix = zeros(Num_Intervals, 3) + repmat(datetime, Num_Intervals, 1) + zeros(Num_Intervals, 6);
Orbital_Matrix = zeros(Num_Intervals, 10 );

E = zeros(1, Num_Intervals); %   Mean Anomaly
%   Provides the angle vector for which the orbit is divided up into when
%   considering the same orbit with e = 0
M = linspace(0,2*pi,Num_Intervals); %   Mean Anomaly

% Calculate true anomaly at each point
for j = 1:Num_Intervals
        E(j) = M(j);
        for n = 1:Num_of_Terms_in_infinite_Series
            E(j) = E(j) + 2/n * besselj(n,n*eccentricity).*sin(n*M(j));
        end
end

% calculate polar coordinates where theta = 0 is perigee
Orbital_Matrix (:,1) = 2 .* atan(sqrt((1+eccentricity)/(1-eccentricity)) .* tan(E/2));
Orbital_Matrix (:,2) = semimajor_axis * (1-eccentricity^2)./ (1 + eccentricity.*cos(Orbital_Matrix(:,1)));
Orbital_Matrix (:,3) = 1;
Orbital_Matrix (:,4) = sqrt((4*(pi^2)*(semimajor_axis)^3)/(GM)).*(M./(2*pi));
Output_Matrix = Orbital_Matrix;

%   Add in additional orbits
for k = 2:num_of_orbits
    Temp_Matrix = Orbital_Matrix;
    Temp_Matrix (:,3) = k;
    Temp_Matrix (:,4) = Orbital_Matrix(:,4) + sqrt((4*(pi^2)*(semimajor_axis)^3)/(GM))* (k-1);
    Output_Matrix = vertcat(Output_Matrix, Temp_Matrix);
end
%   Euler Transformation Matrix
B = [cos(argument_of_perigee), sin(argument_of_perigee), 0; -sin(argument_of_perigee), cos(argument_of_perigee), 0; 0, 0, 1];
C = [1, 0, 0; 0, cos(inclination), sin(inclination); 0, -sin(inclination), cos(inclination)];
D = [cos(RAAN), sin(RAAN), 0; -sin(RAAN), cos(RAAN), 0; 0, 0, 1];
Euler_Transformation_Matrix = B*C*D;

%   ECI Coordinates
for k = 1:length(Output_Matrix)
    Temp_Array = [Output_Matrix(k,2).*cos(Output_Matrix(k,1)), Output_Matrix(k,2).*sin(Output_Matrix(k,1)), 0]*Euler_Transformation_Matrix;
    Output_Matrix(k, 5) = Temp_Array(1);
    Output_Matrix(k, 6) = Temp_Array(2);
    Output_Matrix(k, 7) = Temp_Array(3);
end
%   ECI to ECEF Coordinates
for k = 1:length(Output_Matrix)
    Temp_Date = Start_Datetime + seconds(Output_Matrix(k, 4));
    Data_Array = [year(Temp_Date), month(Temp_Date), day(Temp_Date), hour(Temp_Date), minute(Temp_Date), second(Temp_Date)];
    ECI2ECEF_Matrix = dcmeci2ecef('IAU-2000/2006', Data_Array);
    Temp_Array = [Output_Matrix(k,5), Output_Matrix(k,6), Output_Matrix(k,7)]*ECI2ECEF_Matrix;
    Output_Matrix(k, 8) = Temp_Array(1);
    Output_Matrix(k, 9) = Temp_Array(2);
    Output_Matrix(k, 10) = Temp_Array(3);
end
Output_Matrix;
end

