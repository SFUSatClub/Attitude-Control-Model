% Permanent magnet design
% Variable Initializations
A=0;                % Aerodynamic drag torque (Nm)
G=0;                % Gravity gradient torque (Nm)
R=0;                % Radiometric torque (Nm)
T_rms=0;             % Root mean squared sum of the external perturbation torques (Nm)
m_mag=0;            % Bar magnetic flux density (A*m^2)
beta_max=0;         % Desired pointing accuracy (degrees)
B_min=0;             % Minimum flux density at 600km (Tesla or Webber/m^2 OR Nm/A)
eta=0;              % Related to resonance frequencies we want to avoid
eta_prl=0;          % Related to resonance frequencies we want to avoid
m_res_old=0;        % Parametric resonance flux density (A*m^2)
m_res_new=0;        % Parametric resonance flux density (A*m^2)
m_res_prl_old=0;    % Parametric resonance flux density (A*m^2)
m_res_prl_new=0;    % Parametric resonance flux density (A*m^2)
no=0;               % Orbit mean motion (angular speed required to stay in orbit)
B_eq=0;              % Magnetic flux density at the equator (Tesla or Webber/m^2 OR Nm/A)
Ixx=0;              % Major axis moment of inertia (kg*m^2)
Iyy=0;              % Major axis moment of inertia (kg*m^2)
Izz=0;              % Minor axis moment of inertia (kg*m^2)

% STEP 1 - Calculate the appropriate flux density for the magnet 

A = 8*(10^-8);
G = 6*(10^-8);
R = 1*(10^-8);
T_rms = sqrt((A^2)+(G^2)+(R^2));
B_min = 2.0*10^-5;
beta_max = 15;

m_mag=(10*T_rms)/(B_min*sin(beta_max));

% STEP 2 - Re-adjust the magnets flux density to account for the 
%          parametric resonances you want to avoid for polar orbits

B_eq = 2.3*10^-5;

for k=1:50
    eta = (2.63*(k^2))-0.49+(0.51*(Izz/Iyy));
    eta_prl = (2.63*(k^2))-0.49+0.51*(Izz/Ixx);
    m_res_new = (Iyy*(no^2)*eta)/B_eq;
    m_res_prl_new = (Iyy*(no^2)*eta_prl)/B_eq;
    if(m_mag < m_res_new)
        m_mag = (m_res_new+m_res_old)/2;
        break;
    end
    if(m_mag < m_res_prl_new)
        m_mag = (m_res_prl_new+m_res_prl_old)/2;
        break;
    end
    m_res_new = m_res_old;
    m_res_prl_new = m_res_prl_old;
end

% output m_mag
