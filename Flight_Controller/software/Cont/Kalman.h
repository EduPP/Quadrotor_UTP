#ifndef KALMAN_H_
#define KALMAN_H_

#define pi 3.14159265358979
#define init_P 1E-3 // valor inicial de la diagonal de P

short ejex_ac, ejey_ac, ejez_ac, ejex_gi, ejey_gi, ejez_gi, ejex_ma, ejey_ma,ejez_ma;
// VARIABLES DE GANANCIAS DE SENSORES
float acel_x;
float acel_y;
float acel_z;
float giro_x;
float giro_y;
float giro_z;
float magn_x;
float magn_y;
float magn_z;

// VARIABLES DE CALIBRACIÓN
float AC11,AC12,AC13,AC10,AC21,AC22,AC23,AC20,AC31,AC32,AC33,AC30;
float C_acel_x,C_acel_y,C_acel_z;

float GY11,GY12,GY13,GY10,GY21,GY22,GY23,GY20,GY31,GY32,GY33,GY30;
float C_gy_x,C_gy_y,C_gy_z;
float offset_x,offset_y,offset_z;

float err_center_x, err_center_y, err_center_z;
float M_x,M_y,M_z;
float MA11,MA12,MA13,MA21,MA22,MA23,MA31,MA32,MA33;
float C_mag_x,C_mag_y,C_mag_z;

// VARIABLES FILTRO DE KALMAN EXTENDIDO
int valor_ini;
float P[7][7]; // Matriz de covarianza

float x[7][1]; // vector de estados
float x1, x2, x3, x4, x5, x6, x7; // términos del vector de estados
float wx,wy,wz; // velocidades angulares
float W_x,W_y,W_z;//velocidades angulares mejoradas

float q_abs; // módulo cuaternión
float F[7][7];// jacobiano F
float F_P[7][7]; // F*P
int v,w,k; // variables funciones
float Ftrans[7][7] ;
float F_P_Ftrans[7][7];
float Q[7][7];  // Matriz de covarianza del ruido del sistema
float P_predict[7][7]; // P predicho
float z[3][1];// datos del acelerómetro y magnetómetro
float acel_abs,mag_abs; // módulo cuaternión
float h[3][1]; // modelo de medición
float H[3][7];  // jacobiano H
float R[3][3]; // Ruido en la medición
float Hf[1][7]; // filas de H
float Hftrans[7][1]; // filas de H transpuesta
float f[7][1];
float Hf_f[1][1];
float alpha,y_h;
float K[7][1]; // Ganancia Kalman
float K_y_h[7][1];
float ftrans[1][7]; // f transpuesta
float K_ftrans[7][7];  // K*f'
float roll_rad, pitch_rad, yaw_rad; // angulos de euler (rad)
float roll, pitch, yaw; // angulos de euler (°)
float YAW,YAW_rad; // yaw con DMC y roll, pitch del EKF

// VARIABLES angulos estimados y YAW con Matriz de rotación
float Roll_rad;
float Pitch_rad;
float Yaw_rad;
float Roll_sex;
float Pitch_sex;
float Yaw_sex;
float mag_x;
float mag_y;
float cos_roll;
float sin_roll;
float cos_pitch;
float sin_pitch;
unsigned short distancia;

/** Filtro de Kalman para el EJE ROLL **/
void FiltroKalmanExtendido();

/***********FUNCIONES PARA LAS MULTIPLICACIONES**************/
void M_7x7_7x7(const float a[7][7], const float b[7][7], float out[7][7]);
void transp_7x7(const float a[7][7], float out[7][7]);
void S_7x7( const float a[7][7], const float b[7][7], float out[7][7]);
void M_7x7_7x1(const float a[7][7], const float b[7][1], float out[7][1]);
void transp_1x7(const float a[1][7], float out[7][1]);
void M_1x7_7x1(const float a[1][7], const float b[7][1], float out[1][1]);
void D_7x1_scale(const float a[7][1],  float scale, float out[7][1]);
void M_7x1_scale(const float a[7][1],  float scale, float out[7][1]);
void S_7x1( const float a[7][1], const float b[7][1], float out[7][1]);
void transp_7x1(const float a[7][1], float out[1][7]);
void M_7x1_1x7(const float a[7][1], const float b[1][7], float out[7][7]);
void R_7x7( const float a[7][7], const float b[7][7], float out[7][7]);

#endif /* KALMAN_H_ */
