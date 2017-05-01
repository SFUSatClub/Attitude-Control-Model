function [ Sun_Position ] = Suns_Orbit( Launch_Time, Time_After_Launch )

% Satellite: SUN
% Catalog: 0
% Epoch Time: 15001.00000000000 (year 2015, day 1.00000) 
% Inclination: 23.4406 deg (Earth's axis tilted 23 deg from ecliptic)
% RA of Node: 0.0000 deg (definition of Right Ascension) 
% Eccentricity: 0.0167133 
% Arg of Perigee: 282.7685 deg (perihelion in early January)
% Mean Anomaly: 357.6205 deg (The Earth is quite close to perihelion on Jan 1) 
% Mean Motion: 0.002737778522 Rev/day (one revolution per year) 
% Decay rate: 0.00000 Rev/day^2 
% Epoch rev: 2017 (orbit number equals the year) 
% Semimajor Axis: 149597870 km

Inclination = 23.4406*pi/180;
RAAN = 0;
Eccentricity = 0.0167133;
Arg_of_Perigee = (282.7685*pi/180);
Mean_Anomaly = (357.6205*pi/180);
Semimajor_Axis = 149597870*1000;

Num_of_Terms_in_infinite_Series = 10;
GM = 3.986005*10^14;

%   [ECI_x, ECI_y, ECI_z, ECEF_x, ECEF_y, ECEF_z]
Sun_Position = zeros(1, 6);
Total_Time = Launch_Time + second(Time_After_Launch);
Time_Since_Perigee = second(Total_Time - year(Total_Time));
Orbital_Period = 365*24*3600;

M = 2*pi*(Time_Since_Perigee/Orbital_Period); %   Mean Anomaly

% Calculate true anomaly at each point
    E = M;
    for n = 1:Num_of_Terms_in_infinite_Series
        E = E + 2/n * besselj(n,n*Eccentricity).*sin(n*M);
    end

% calculate polar coordinates where theta = 0 is perigee
Sun_Position_True_Anomaly = 2 .* atan(sqrt((1+Eccentricity)/(1-Eccentricity)) .* tan(E/2));
Sun_Position_Altitude = Semimajor_Axis * (1-Eccentricity^2)./ (1 + Eccentricity.*cos(Sun_Position_True_Anomaly));


%   Euler Transformation Matrix
B = [cos(Arg_of_Perigee), sin(Arg_of_Perigee), 0; -sin(Arg_of_Perigee), cos(Arg_of_Perigee), 0; 0, 0, 1];
C = [1, 0, 0; 0, cos(Inclination), sin(Inclination); 0, -sin(Inclination), cos(Inclination)];
D = [cos(RAAN), sin(RAAN), 0; -sin(RAAN), cos(RAAN), 0; 0, 0, 1];
Euler_Transformation_Matrix = B*C*D;

%   ECI Coordinates
Temp_Array = [Sun_Position_Altitude.*cos(Sun_Position_True_Anomaly), Sun_Position_Altitude.*sin(Sun_Position_True_Anomaly), 0]*Euler_Transformation_Matrix;
Sun_Position(1) = Temp_Array(1);
Sun_Position(2) = Temp_Array(2);
Sun_Position(3) = Temp_Array(3);

%   ECI to ECEF Coordinates
Data_Array = [year(Total_Time), month(Total_Time), day(Total_Time), hour(Total_Time), minute(Total_Time), second(Total_Time)];
ECI2ECEF_Matrix = dcmeci2ecef('IAU-2000/2006', Data_Array);
Temp_Array = [Sun_Position(1), Sun_Position(2), Sun_Position(3)]*ECI2ECEF_Matrix;
Sun_Position(4) = Temp_Array(1);
Sun_Position(5) = Temp_Array(2);
Sun_Position(6) = Temp_Array(3);

end

