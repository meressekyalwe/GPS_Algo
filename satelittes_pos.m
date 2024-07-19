clear;
clc;

global spx1 spy1 spz1 spx2 spy2 spz2 spx3 spy3 spz3 spx4 spy4 spz4 rho1 rho2 rho3 rho4;

sheetName = 'eph';
opts = detectImportOptions('database.xlsx', 'Sheet', sheetName, 'VariableNamingRule', 'preserve');
data = readtable('database.xlsx', opts);

deg_to_rad = pi / 180;

for row = 1:4
M0 = data.('M0(deg)')(row) * deg_to_rad;
Delta_n = data.('deltan(deg)')(row) * deg_to_rad;
ecc = data.('e')(row);
A = data.('A(m)')(row);
Omega0 = data.('OMEGA0(deg)')(row) * deg_to_rad;
i0 = data.('io(deg)')(row) * deg_to_rad;
omega = data.('omega(deg)')(row) * deg_to_rad;
Omega = data.('OMEGADOT(deg)')(row) * deg_to_rad;
IDOT = data.('IDOT(deg)')(row) * deg_to_rad;
Cuc = data.('Cuc(rad)')(row);
Cus = data.('Cus(rad)')(row);
Crc = data.('Crc(m)')(row);
Crs = data.('Crs(m)')(row);
Cic = data.('Cic(rad)')(row);
Cis = data.('Cis(rad)')(row);
te = data.("toe")(row);  
t = 131809;  


% Algorithm for computing Satellite Position
mu = 3.986005e14;
Omega_e = 7.29211151467e-5;

a = A;
n0 = abs(sqrt(mu / a^3));
tk = t - te;
if tk > 302400
    tk = tk - 604800;
elseif tk < -302400
    tk = tk + 604800;
end

n = n0 + Delta_n;
Mk = M0 + n * tk;

f = @(E) E - ecc * sin(E) - Mk;
E0 = Mk; 
Ek = fzero(f, E0);

% True Anomaly (fk) and Argument of Latitude (phi_k)
fk = atan2(sqrt(1 - ecc^2) * sin(Ek), cos(Ek) - ecc);
phi_k = fk + omega;

% Corrections
delta_uk = Cuc * cos(2 * phi_k) + Cus * sin(2 * phi_k);
delta_rk = Crc * cos(2 * phi_k) + Crs * sin(2 * phi_k);
delta_ik = Cic * cos(2 * phi_k) + Cis * sin(2 * phi_k);

% Corrected argument of latitude, radius and inclination
uk = phi_k + delta_uk;
rk = a * (1 - ecc * cos(Ek)) + delta_rk;
ik = i0 + delta_ik + IDOT * tk;

% Positions in the orbital plane
xk = rk * cos(uk);
yk = rk * sin(uk);

% Corrected longitude of ascending node
Omega_k = Omega0 + (Omega - Omega_e) * tk - Omega_e * te;

% Earth-fixed coordinates
xecef = xk * cos(Omega_k) - yk * cos(ik) * sin(Omega_k);
yecef = xk * sin(Omega_k) + yk * cos(ik) * cos(Omega_k);
zecef = yk * sin(ik);

% Output positions
fprintf('xecef: %f\n', xecef);
fprintf('yecef: %f\n', yecef);
fprintf('zecef: %f\n', zecef);
fprintf('\n');

    switch row
        case 1
            spx1=xecef; spy1=yecef; spz1=zecef;
            rho1=data.('rho(m)')(row);
        case 2
            spx2=xecef; spy2=yecef; spz2=zecef;
            rho2=data.('rho(m)')(row);
        case 3
            spx3=xecef; spy3=yecef; spz3=zecef;
            rho3=data.('rho(m)')(row);
        case 4
            spx4=xecef; spy4=yecef; spz4=zecef;
            rho4=data.('rho(m)')(row);
    end
end

gps_coordinates;
