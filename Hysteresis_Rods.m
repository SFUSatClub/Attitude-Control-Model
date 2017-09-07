% Definitions

% m_hyst = magnetic moment of the hysteresis rod aligned with its long axis
% B_hyst = the magnetic flux induced in the rod
% V_hyst = the volume of the rod
% mu_o = the permiability of free space
% H = the magnetic field strength
% mu_prime_hyst = the apparent relative permiability of the rod
% N = demagnetizing factor
% mu_hyst(H) = true relative permiability of the rod (which varies with H)
% Bs_prime = apparent saturation induction
% Hs = magnetic field strength at saturation (aka H when B = Bs)
% L/D = ration of length to diameter

% Equations

m_hyst = ([B_hyst]*[V_hyst])/[mu_o];
Bhyst = [mu_o]*[mu_prime_hyst]*[H];
mu_prime_hyst = [mu_hyst]/(1+N*[mu_hyst]);
N = [(L/D)*(4/sqrt(PI)+2)]^-1;
Bs_prime = [mu_o]*(mu_hyst/mu_prime_hyst)*Hs;