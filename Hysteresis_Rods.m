% Hysteresis rod design: BY CAMERON JINKS

% Definitions

% m_hyst = magnetic moment of the hysteresis rod aligned with its long axis
% B_hyst = the magnetic flux induced in the rod
% V_hyst = the volume of the rod
% mu_o = the permiability of free space
% H = the magnetic field strength
% mu_prime_hyst(H) = the apparent relative permiability of the rod
% N = demagnetizing factor
% mu_hyst(H) = true relative permiability of the rod (which varies with H)
% Bs_prime = apparent saturation induction
% Hs = magnetic field strength at saturation (aka H when B = Bs)
% L/D = ratio of length to diameter
% Hs = Material saturation field strength of HyMu-80

% Assume material is HyMu-80

L = 95;           % in mm
D = 1;            % in mm
Hc = 0.96;        % A/m
Br = 0.35;        % Tesla
Bs = 0.74;        % Tesla
Hc_prime = 12;    % A/m
Br_prime = 0.004; % Tesla
Bs_prime = 0.025; % Tesla

% 
% Equations

% m_hyst = ([B_hyst]*[V_hyst])/[mu_o];

% H = the magnetic field strength of earth
% mu_prime_hyst is the apparent relative permiability of the rod (which changes depending on the stregth of the magnetic field of earth)

% Bhyst = [mu_o]*[mu_prime_hyst]*[H];

% N = demagnetizing factor

% We need the hysteresis curve of the rods in order to calculate the
% following. Max/min values for the magnetic field strength of earth should
% be roughly +or- 30 A*m^2 

% 

N = [(L/D)*(4/sqrt(PI)+2)]^-1;
mu_prime_hyst = [mu_hyst]/(1+N*[mu_hyst]);
Bs_prime = [mu_o]*(mu_hyst/mu_prime_hyst)*Hs;
