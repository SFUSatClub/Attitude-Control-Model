function [ In_Shadow_Bool ] = Shadow_Detection( Sun_ECI_x, Sun_ECI_y, Sun_ECI_z, Sat_ECI_x, Sat_ECI_y, Sat_ECI_z )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%   Earths radius is 6371.2km

%   Default value is the satellite has direct line of sight with the sun
In_Shadow_Bool = 0;

%   Determine the vector for the sun to earth, sat to earth and sun to sat
Sun_to_Earth_Vector = [Sun_ECI_x; Sun_ECI_y; Sun_ECI_z];
Sat_to_Earth_Vector = [Sat_ECI_x; Sat_ECI_y; Sat_ECI_z];
Sun_to_Sat_Vector = Sun_to_Earth_Vector + Sat_to_Earth_Vector;

Sun_to_Earth_Edge_Angle = atan(6371200/norm(Sun_to_Earth_Vector));
Sun_to_Sat_Angle = acos(norm(Sun_to_Sat_Vector)/norm(Sun_to_Earth_Vector));

if Sun_to_Sat_Angle < Sun_to_Earth_Edge_Angle
    if norm(Sun_to_Sat_Vector) > norm(Sun_to_Earth_Vector)
        In_Shadow_Bool = 1;
    end
end

