% CIDI
g = 9.81;      % [m/s^2]
m = 1.3;     %aprox [kg]
Ixx = 0.01088577; % [kg.m^2]
Iyy = 0.01088577;%para constante empuje de 6.62
Izz = 0.021;% [kg.m^2] para constante drag 0.15
I = diag([Ixx, Iyy, Izz]);
l = 0.235; % [m]
pi = 3.1415926;
%constante matriz de conversion PWM
KKt = 0.8;
Kphi = 0.4;
Ktheta = 0.4;
Kpsi = 0.3;

%constantes actuadores
Km = 0.15075; %constante de arrastre actuador
Kt = 6.62025; %constante de empuje actuador
tau = 0.06035; %motor transitorio
Kyaw = 4*Kpsi*Km/Izz;
Kpitch = 2*l*Ktheta*Kt/Iyy;
ty = 0.0002251891410;%tau para yaw

%Parametros PID
K_roll = 0.1861;
Ki_roll = 3.69;
Kd_roll = 0.0957;

K_pitch = 0.1861;
Ki_pitch = 3.69;
Kd_pitch = 0.0957;

K_yaw = 2.48;
Ki_yaw = 3.77;
Kd_yaw = 0;

Tt = 1;%antiwindup roll y pitch
Ttyaw = 3.5;%antiwindup yaw
N = 18;%para roll y pitch
Nyaw = 10;

%% 3D
initDisplay;
%% data BLDC
load data_bldc.mat
%% Valores iniciales
omega0 = [0;0;0]; %Wb_ib
attitude0 = [0;0;0]*pi/180; 
vel0 = [0;0;0];  %V_b
pos0 = [0;0;0];  %r_i
Ts = 0.01;
U1_0 = m*g/4;
%% Sensores
var_acc  = [9.81*0.3784 9.81*0.4202 9.81*0.4701].^2;
var_mag  = [0.0109 0.013  0.01].^2; %gauss
var_gyro = [0.3624*pi/180 0.1267*pi/180 0.1755*pi/180].^2;
%% Controlador PD
% Kp_r = 0.8; Kd_r = 0.4;
% Kp_p = 0.8; Kd_p = 0.4;
% Kp_y = 0.8; Kd_y = 0.5;
% Kp_r = 0.8; Kd_r = 0.4; Ki_r = 0.81;
% Kp_p = 0.8; Kd_p = 0.4; Ki_p = 0.81;
% Kp_y = 0.9; Kd_y = 0.6; Ki_y = 0.81;
Kp_r = 0.8; Kd_r = 0.4; Ki_r = 0;
Kp_p = 0.8; Kd_p = 0.4; Ki_p = 0;
Kp_y = 0.9; Kd_y = 0.6; Ki_y = 0;
%% Otros
% Wm_op = [570.5 570.7 570.5 569.3]';
% Wm_op0 = 570.5*[1 1 1 1]';