% Orbital Model Summary
%   The orbit of the satellite is defined in Earth-Centered Inertial
%   Reference Frame and requires converting into ECEF to provide
%   positioning information.
%   All orbits are assumed to start at the ascending node for prograde
%   orbits and at the descending node for retrograde orbits
%   The IC of the orbit is assumed to be at the intercept of the Equinox
%   and the equator
%   The position of the satellite is reference to Right acension node
%   called the Arguement_of_Latitude
%   Eccentricity of the Arguement_of_Latitude is when the orbit is changed
%   to an eccentricity of 0 for easier calculations
%   The model currently does not account for inclinations of 0 or 180
%   degrees. Nor does it consider any perturbations such as
%   radiation pressure
%   aerodynamic drag
%   Orbital precession

%   Constants
GM = 3.986005*10^14;

%   Year, Month, Day, Hour, Minutes, Seconds, eccentricity, inclination, semimajor_axis, Argument_of_Latitude, Interval, RAAN
Year = 2015;
Month = 1;
Day = 1;
Hour = 0;
Minutes = 0;
Seconds = 0;
eccentricity = 0.5;
inclination = 45;
semimajor_axis = 6800000;
Argument_of_Latitude = pi %radians
Argument_of_Perigee = 0.5; %radians only for eccentricity != 0
Time_Interval = 10;
RAAN = 0;

%   Find semiminor axis, total area of the ellipse/circle and the orbital
%   period
semiminor_axis = sqrt((semimajor_axis^2)-(eccentricity*semimajor_axis)^2);
Total_Area = pi*semiminor_axis*semimajor_axis;
Orbital_Period=sqrt((4*(pi^2)*(semimajor_axis)^3)/(GM));

%   Find area per second of the orbit
Area_per_second_travelled = Total_Area/Orbital_Period;

%   Find Area of the orbit so far from current True Anomaly by
%   making the orbit into a circle (Eccentricity = 0)

%  Keep True Anomaly within 0 to 2pi
Current_True_Anomaly = Argument_of_Latitude - Argument_of_Perigee;
if Current_True_Anomaly < 0
    Current_True_Anomaly = Current_True_Anomaly + 2*pi;
end 
    
%   Find the Eccentricity_True_Anomaly and area covered by True_Anomaly so
%   far in the orbit
Current_Eccentricity_True_Anomaly = 2*atan(sqrt((1-eccentricity)/(1+eccentricity))*tan(Current_True_Anomaly/2));
Current_True_Anomaly_Area = 0.5*semimajor_axis*semiminor_axis*(Current_Eccentricity_True_Anomaly-eccentricity*sin(Current_Eccentricity_True_Anomaly));

%   Find new area and subsequently new True_Anomaly
New_Area = Current_True_Anomaly_Area + Area_per_second_travelled*Time_Interval;
    if New_Area > Total_Area
       New_Area = New_Area - Total_Area;
    end

%   Find the new True_Anomaly that correlates with the New Area covered by the
%   orbit

fun = @(variable1) variable1*(1-eccentricity*sin(variable1))-(2*New_Area/(semimajor_axis*semiminor_axis));
New_Eccentric_True_Anomaly = fzero(fun, Current_Eccentricity_True_Anomaly);
if eccentricity == 0 || New_Eccentric_True_Anomaly == pi%  Skip secondary iterative solution if eccentricity is already a circle
    New_True_Anomaly = New_Eccentric_True_Anomaly;
else
    fun2 = @(variable2) 2*atan((sqrt(((1-eccentricity)/(1+eccentricity)))*tan(variable2/2)))-New_Eccentric_True_Anomaly; 
    New_True_Anomaly = fzero(fun2, Current_True_Anomaly)
end
New_Argument_of_Latitude = New_True_Anomaly + Argument_of_Perigee
if New_Argument_of_Latitude > 2*pi
    New_Argument_of_Latitude = New_Argument_of_Latitude - 2*pi
end
%   Calculate the transformation matrix for ECI to ECEF using IAU-76/FK5 as
%   reduction methodology

%   ECI2ECEF_Transformation_Matrix = dcmeci2ecef('IAU-76/FK5',[Year Month Day Hour Minutes Seconds]);

%   Calculate ECI coordinates


