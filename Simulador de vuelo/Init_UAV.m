%% Inicialización
masa = 0.65;         % masa OS4(Kg).
Ixx  = 7.5e-3;       % inercia X OS4 (Kg*m^2)
Iyy  = 7.5e-3;       % inercia Y OS4 (Kg*m^2)
Izz  = 1.3e-2;       % inercia Z OS4 (Kg*m^2)
Inercia  = [Ixx 0 0; 0 Iyy 0; 0 0 Izz];
v0_b     = [0; 0; 0];   % Velocidad lineal inicial medida en el body (m/s).
w0b_ib   = [0; 0; 0];   % Velocidad angular inicial medida en el body (rad/s).
r0_i     = [0; 0; 0];   % Posición inicial medida en el sistema inercial (m).
eul_0    = [0; 0; 0];   % Angulos de euler iniciales (rad).
g=9.81;
m=0.65;

%% Control
U1=1.2;
U2=1;
U3=1;
U4=1;
% Fuerzas y Momentos de los motores
b = 3.13e-5; % factor de empuje (N*seg^2) OS4
d = 7.5e-7;  % Drag o arrastre aerodinámico (N*m*s^2) OS4
l = 0.235;   % distancia del centro de masa al eje del motor. OS4
% U = [U1; U2; U3; U4];
%% Aerodinamica
sigma = 1;  % relación de solidez (buscar)
a = 1;      % elevacion de pendiente
mu = 1;     % relación de avance del rotor.
lambda = 1; % relación de afluencia.
va = 1;     % velocidad inducida
rho = 1;    % densidad del aire
% Datos quadrotor OS4
Rrad = 0.15; % radio de la helice (m).
c = 0.04;    % propeller chord (m)
theta_0 = 0.26; % pitch de incidencia (rad)
theta_tw = 0.045; % twist pitch
Ir = 6e-5;  % inercia del rotor (Kg*m^2)

%%
sim('sim_Uav_model');