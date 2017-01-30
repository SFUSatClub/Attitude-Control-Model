function [ output_args ] = Orbital_Model( Time, altitude, eccentricity, inclination, semimajor_axis, True-Anomaly)
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





end

