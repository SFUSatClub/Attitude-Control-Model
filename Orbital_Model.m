function [ output_args ] = Orbital_Model( Year, Month, Day, Hour, Minutes, Seconds, eccentricity, inclination, semimajor_axis, True_Anomaly, Interval)
% Orbital Model Summary
%   The orbit of the satellite is defined in Earth-Centered Inertial
%   Reference Frame and requires converting into ECEF to provide
%   positioning information.
%   All orbits are assumed to start at the ascending node for prograde
%   orbits and at the descending node for retrograde orbits
%   The IC of the orbit is assumed to be at the intercept of the Equinox
%   and the equator
%   An eccentricity of 0 has the true anomaly referenced from the
%   ascending node.
%   For all other eccentricities, it is referenced to the perigee
%   The model currently does not account for inclinations of 0 or 180
%   degrees. Nor does it consider any perturbations such as
%   radiation pressure
%   aerodynamic drag
%   Orbital precession

%   Constants
GM = 3.986005*10^14;

semiminor_axis = sqrt((semimajor_axis^2)-(eccentricity*semimajor_axis)^2);
Total_Area = pi*semiminor_axis*semimajor_axis;
Orbital_Period=sqrt((4*(pi^2)*(semimajor_axis)^3)/(GM));

Area_per_second_travelled = Total_Area/Orbital_Period;

%   Find Area of the orbit so far from current true anamoaly
Current_Eccentric_Anomaly = 2*atan(sqrt((1-eccentricity)/(1+eccentricity))*tan(True_anaomaly/2));
True_Anamoly_Area = 0.5*semimajor_axis*semiminor_axis*(Current_Eccentricity_Anamoaly-eccentricity*sin(Current_Eccentricity_Anamoly));

%   Find new area and subsequently new true anamoaly
New_Area = True_Anamoaly_Area + Area_per_second*interval;
    if New_Area > Total_Area
       New_Area = New_Area - Total_Area;
    end

%   Find the new true_anomaly that correlates with the New Area covered by the
%   orbit
fun = x*(1-eccentricity*sin(x))-(2*New_Area/(semimajor_axis*semiminor_axis));
New_Eccentric_Anomaly = fzero(fun, Current_Eccentric_Anomaly);
fun2 = 2*atan((sqrt((1-eccentricity)/(1+eccentricity))*tan(x/2)))-New_Eccentric_Anomaly;
New_True_Anomaly = fzero(fun2, True_Anomaly);

%   Calculate the transformation matrix for ECI to ECEF using IAU-76/FK5 as
%   reduction methodology

ECI2ECEF_Transformation_Matrix = dcmeci2ecef('IAU-76/FK5',[Year Month Day Hour Minutes Seconds]);

%   Calculate ECI coordinates
end

