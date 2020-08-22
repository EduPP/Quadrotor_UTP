#include "Kalman.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include "math.h"

#define pi 3.14159265358979
#define T 0.007 // Periodo de muestreo
#define init_P 1E-3 // valor inicial de la diagonal de P
int i = 0, j = 0; // variables funciones ekf

//variables de lectura en bruto de la IMU
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
int valor_ini = 0;
float P[7][7] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}}; // Matriz de covarianza
#define init_P 1E-3 // valor inicial de la diagonal de P
float x[7][1] = {{0},{0},{0},{0},{0},{0},{0}}; // vector de estados
float x1, x2, x3, x4, x5, x6, x7; // términos del vector de estados
float wx,wy,wz; // velocidades angulares
float W_x,W_y,W_z;//velocidades angulares mejoradas
float q_abs; // módulo cuaternión
float F[7][7] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}};  // jacobiano F
float F_P[7][7] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}};  // F*P
int v=0,w=0,k=0; // variables funciones
float Ftrans[7][7] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}};  // F'
float F_P_Ftrans[7][7] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}};  // F*P*F'
float Q[7][7] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,2E-7,0,0},{0,0,0,0,0,2E-7,0},{0,0,0,0,0,0,2E-7}};  // Matriz de covarianza del ruido del sistema
float P_predict[7][7] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}}; // P predicho
float z[3][1] = {{0},{0},{0}};// datos del acelerómetro y magnetómetro
float acel_abs,mag_abs; // módulo cuaternión
float h[3][1] = {{0},{0},{0}}; // modelo de medición
float H[3][7] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}};  // jacobiano H
float R[3][3] = {{0.1432,0},{0,0.1765,0},{0,0,0.221}}; // Ruido en la medición
float Hf[1][7] = {{0,0,0,0,0,0,0}}; // filas de H
float Hftrans[7][1] = {{0},{0},{0},{0},{0},{0},{0}}; // filas de H transpuesta
float f[7][1] = {{0},{0},{0},{0},{0},{0},{0}};
float Hf_f[1][1] = {{0}};
float alpha,y_h;
float K[7][1] = {{0},{0},{0},{0},{0},{0},{0}}; // Ganancia Kalman
float K_y_h[7][1] = {{0},{0},{0},{0},{0},{0},{0}};
float ftrans[1][7] = {{0,0,0,0,0,0,0}}; // f transpuesta
float K_ftrans[7][7] = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}};  // K*f'
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

void FiltroKalmanExtendido()
{
	  // LECTURA DE LOS SENSORES
	  ejex_ac = IORD_ALTERA_AVALON_PIO_DATA(ENTRADA_AC_EJE_X_BASE);
	  ejey_ac = IORD_ALTERA_AVALON_PIO_DATA(ENTRADA_AC_EJE_Y_BASE);
	  ejez_ac = IORD_ALTERA_AVALON_PIO_DATA(ENTRADA_AC_EJE_Z_BASE);

	  ejex_gi = IORD_ALTERA_AVALON_PIO_DATA(ENTRADA_GY_EJE_X_BASE);
	  ejey_gi = IORD_ALTERA_AVALON_PIO_DATA(ENTRADA_GY_EJE_Y_BASE);
	  ejez_gi = IORD_ALTERA_AVALON_PIO_DATA(ENTRADA_GY_EJE_Z_BASE);

	  ejex_ma = IORD_ALTERA_AVALON_PIO_DATA(ENTRADA_MA_EJE_X_BASE);
	  ejey_ma = IORD_ALTERA_AVALON_PIO_DATA(ENTRADA_MA_EJE_Y_BASE);
	  ejez_ma = IORD_ALTERA_AVALON_PIO_DATA(ENTRADA_MA_EJE_Z_BASE);

	//SALIDAS MULTIPLICADAS POR SUS GANANCIAS
	acel_x = (1 / 256.00) * ejex_ac; // g
	acel_y = (1 / 256.00) * ejey_ac;
	acel_z = (1 / 256.00) * ejez_ac;

	giro_x = (1 / 14.375) * ejex_gi; // (°/s)
	giro_y = (1 / 14.375) * ejey_gi;
	giro_z = (1 / 14.375) * ejez_gi;

	magn_x = (1 / 1090.00) * ejex_ma; // gauss
	magn_y = (1 / 1090.00) * ejey_ma;
	magn_z = (1 / 1090.00) * ejez_ma;

	//*************************************************
	//	|Ax1|	|AC11 AC12 AC13||Ax|   |AC10|
	//	|Ay1| =	|AC21 AC22 AC23||Ay| + |AC20|
	//	|Az1|	|AC31 AC32 AC33||Az|   |AC30|
	//************ Métodos Mínimos Cuadrados************
	//															Resultado de un eje Roll
	//								|AC11 AC21 AC31|		| 0.9859    -0.0143    0.0112|
	//	|Ax1 Ay1 Az1| = |Ax Ay Az 1||AC12 AC22 AC32|		|-0.0166    -0.9608   -0.0049|
	//								|AC13 AC23 AC33|		|-0.0023     0.0115    1.0066|
	//								|AC10 AC20 AC30|		|-0.0197    -0.0038    0.1304|

	//ACELERÓMETRO
	AC11 = 0.9859;
	AC21 = -0.0143;
	AC31 = 0.0112;
	AC12 = -0.0166;
	AC22 = -0.9608;
	AC32 = -0.0049;
	AC13 = -0.0023;
	AC23 = 0.0115;
	AC33 = 1.0066;
	AC10 = -0.0197;
	AC20 = -0.0038;
	AC30 = 0.1304;

	C_acel_x = AC11 * acel_x + AC12 * acel_y + AC13 * acel_z + AC10;
	C_acel_y = AC21 * acel_x + AC22 * acel_y + AC23 * acel_z + AC20;
	C_acel_z = AC31 * acel_x + AC32 * acel_y + AC33 * acel_z + AC30;

	//GIROSCOPIO
	offset_x = -22;//-41.2078; // offset
	offset_y = -36;//-16.0679;
	offset_z = -66;//-46.2248;

	giro_x = giro_x - offset_x * (1 / 14.375);
	giro_y = giro_y - offset_y * (1 / 14.375);
	giro_z = giro_z - offset_z * (1 / 14.375);

	GY11 = -1.0240;
	GY21 = 0.0551;
	GY31 = -0.0182;
	GY12 = 0.0227;
	GY22 = 1.0114;
	GY32 = -0.0059;
	GY13 = -0.0233;
	GY23 = 0.0319;
	GY33 = -1.0104;
	GY10 = -0.3138;
	GY20 = -0.1090;
	GY30 = 0.3443;

	C_gy_x = GY11 * giro_x + GY12 * giro_y + GY13 * giro_z + GY10;
	C_gy_y = GY21 * giro_x + GY22 * giro_y + GY23 * giro_z + GY20;
	C_gy_z = GY31 * giro_x + GY32 * giro_y + GY33 * giro_z + GY30;

	//MAGNETÓMETRO
	magn_x = -magn_x; // cambio de coordenadas a Body
	magn_z = -magn_z;
	magn_x = magn_x / 0.25; // normalización (0.25 -> campo magn. en Perú)
	magn_y = magn_y / 0.25;
	magn_z = magn_z / 0.25;
	err_center_x = 0.0719749;
	err_center_y = -0.412054;
	err_center_z = -0.103984;
	M_x = (magn_x - err_center_x);
	M_y = (magn_y - err_center_y);
	M_z = (magn_z - err_center_z);
	MA11 = 0.912879;
	MA12 = 0.00733372;
	MA13 = 0.0206488;
	MA21 = 0.00733372;
	MA22 = 0.921211;
	MA23 = 0.00647972;
	MA31 = 0.0206488;
	MA32 = 0.00647972;
	MA33 = 0.994242;
	C_mag_x = MA11 * M_x + MA12 * M_y + MA13 * M_z;
	C_mag_y = MA21 * M_x + MA22 * M_y + MA23 * M_z;
	C_mag_z = MA31 * M_x + MA32 * M_y + MA33 * M_z;


	// valor inicial de la covarianza y del vector de estado
	if (valor_ini == 0) {
		P[0][0] = init_P;
		P[1][1] = init_P;
		P[2][2] = init_P;
		P[3][3] = init_P;
		P[4][4] = init_P;
		P[5][5] = init_P;
		P[6][6] = init_P;
		x[0][0] = 1;
		valor_ini = 1;
	}

	// vector de estados
	x1 = x[0][0]; // q0
	x2 = x[1][0]; // q1
	x3 = x[2][0]; // q2
	x4 = x[3][0]; // q3
	x5 = x[4][0]; // wxbias
	x6 = x[5][0]; // wybias
	x7 = x[6][0]; // wzbias


	//************ ECUACIONES DE PREDICCIÓN ***********************

	// lectura del giroscopio
	wx = C_gy_x * (pi / 180); //(rad/s)
	wy = C_gy_y * (pi / 180);
	wz = C_gy_z * (pi / 180);

	// Modelo del proceso
	// estado del sistema x(k) = f(x(k-1),u(k))
	x[0][0] = x1 + (T / 2)
			* (-x2 * (wx - x5) - x3 * (wy - x6) - x4 * (wz - x7));
	x[1][0] = x2 + (T / 2) * (x1 * (wx - x5) + x3 * (wz - x7) - x4 * (wy - x6));
	x[2][0] = x3 + (T / 2) * (x1 * (wy - x6) - x2 * (wz - x7) + x4 * (wx - x5));
	x[3][0] = x4 + (T / 2) * (x1 * (wz - x7) + x2 * (wy - x6) - x3 * (wx - x5));
	x[4][0] = x5;
	x[5][0] = x6;
	x[6][0] = x7;

	// normalizado del cuaternión
	q_abs = sqrt(x[0][0] * x[0][0] + x[1][0] * x[1][0] + x[2][0] * x[2][0]
			+ x[3][0] * x[3][0]);
	x[0][0] = x[0][0] / q_abs;
	x[1][0] = x[1][0] / q_abs;
	x[2][0] = x[2][0] / q_abs;
	x[3][0] = x[3][0] / q_abs;

	x1 = x[0][0];
	x2 = x[1][0];
	x3 = x[2][0];
	x4 = x[3][0];

	// Jacobiano de la función "f", F = (df/dx)

	F[0][0] = 1;
	F[0][1] = -(T / 2) * (wx - x5);
	F[0][2] = -(T / 2) * (wy - x6);
	F[0][3] = -(T / 2) * (wz - x7);
	F[0][4] = (T / 2) * x2;
	F[0][5] = (T / 2) * x3;
	F[0][6] = (T / 2) * x4;

	F[1][0] = (T / 2) * (wx - x5);
	F[1][1] = 1;
	F[1][2] = (T / 2) * (wz - x7);
	F[1][3] = -(T / 2) * (wy - x6);
	F[1][4] = -(T / 2) * x1;
	F[1][5] = (T / 2) * x4;
	F[1][6] = -(T / 2) * x3;

	F[2][0] = (T / 2) * (wy - x6);
	F[2][1] = -(T / 2) * (wz - x7);
	F[2][2] = 1;
	F[2][3] = (T / 2) * (wx - x5);
	F[2][4] = -(T / 2) * x4;
	F[2][5] = -(T / 2) * x1;
	F[2][6] = (T / 2) * x2;

	F[3][0] = (T / 2) * (wz - x7);
	F[3][1] = (T / 2) * (wy - x6);
	F[3][2] = -(T / 2) * (wx - x5);
	F[3][3] = 1;
	F[3][4] = (T / 2) * x3;
	F[3][5] = -(T / 2) * x2;
	F[3][6] = -(T / 2) * x1;

	F[4][0] = 0;
	F[4][1] = 0;
	F[4][2] = 0;
	F[4][3] = 0;
	F[4][4] = 1;
	F[4][5] = 0;
	F[4][6] = 0;

	F[5][0] = 0;
	F[5][1] = 0;
	F[5][2] = 0;
	F[5][3] = 0;
	F[5][4] = 0;
	F[5][5] = 1;
	F[5][6] = 0;

	F[6][0] = 0;
	F[6][1] = 0;
	F[6][2] = 0;
	F[6][3] = 0;
	F[6][4] = 0;
	F[6][5] = 0;
	F[6][6] = 1;

	// predicción de la matriz de Covarianza del error de estimación
	M_7x7_7x7(F, P, F_P); // F*P
	transp_7x7(F, Ftrans); // F'
	M_7x7_7x7(F_P, Ftrans, F_P_Ftrans); // F*P*F'
	S_7x7(F_P_Ftrans, Q, P_predict); // P_predict = F*P*F' + Q

	////************ ECUACIONES DE CORRECCIÓN ***********************

	// lectura del acelerómetro

	z[0][0] = C_acel_x;
	z[1][0] = C_acel_y;
	z[2][0] = C_acel_z;

	// normalizado de las lecturas
	acel_abs = sqrt(z[0][0] * z[0][0] + z[1][0] * z[1][0] + z[2][0] * z[2][0]);
	z[0][0] = z[0][0] / acel_abs;
	z[1][0] = z[1][0] / acel_abs;
	z[2][0] = z[2][0] / acel_abs;

	// Modelo de medición h(x(k))
	h[0][0] = 2 * (x2 * x4 - x1 * x3);
	h[1][0] = 2 * (x3 * x4 + x1 * x2);
	h[2][0] = 1 - 2 * (x2 * x2 + x3 * x3);

	// Jacobiano de la función "h", H = (dh/dx)

	H[0][0] = -2 * x3;
	H[0][1] = 2 * x4;
	H[0][2] = -2 * x1;
	H[0][3] = 2 * x2;
	H[0][4] = 0;
	H[0][5] = 0;
	H[0][6] = 0;

	H[1][0] = 2 * x2;
	H[1][1] = 2 * x1;
	H[1][2] = 2 * x4;
	H[1][3] = 2 * x3;
	H[1][4] = 0;
	H[1][5] = 0;
	H[1][6] = 0;

	H[2][0] = 0;
	H[2][1] = -4 * x2;
	H[2][2] = -4 * x3;
	H[2][3] = 0;
	H[2][4] = 0;
	H[2][5] = 0;
	H[2][6] = 0;

	// Ecuaciones para la etapa de corrección (sin matriz inversa)

	// P = P_predict
	for (v = 0; v < 7; v++) // filas
	{
		for (w = 0; w < 7; w++) // columnas
		{
			P[v][w] = P_predict[v][w];
		}
	}

	// ecuaciones de corrección
	for (k = 0; k < 3; k++) {
		// Hf (filas de H)
		Hf[0][0] = H[k][0];
		Hf[0][1] = H[k][1];
		Hf[0][2] = H[k][2];
		Hf[0][3] = H[k][3];
		Hf[0][4] = H[k][4];
		Hf[0][5] = H[k][5];
		Hf[0][6] = H[k][6];

		// variable f
		transp_1x7(Hf, Hftrans);
		M_7x7_7x1(P, Hftrans, f); // f = P * Htrans

		// residuo de covarianza (alpha)
		M_1x7_7x1(Hf, f, Hf_f);
		alpha = Hf_f[0][0] + R[k][k]; // alpha = H * f + R

		// Ganancia de Kalman
		D_7x1_scale(f, alpha, K); // K = f/alpha

		// corrección del estado estimado
		y_h = z[k][0] - h[k][0];
		M_7x1_scale(K, y_h, K_y_h);
		S_7x1(x, K_y_h, x); // x = x + K[z - h]

		// actualización de la matriz del error de covarianza
		transp_7x1(f, ftrans);
		M_7x1_1x7(K, ftrans, K_ftrans);
		R_7x7(P, K_ftrans, P); // P = P - K * ftans
	}

	// normalizado del cuaternión
	q_abs = sqrt(x[0][0] * x[0][0] + x[1][0] * x[1][0] + x[2][0] * x[2][0]
			+ x[3][0] * x[3][0]);
	x[0][0] = x[0][0] / q_abs;
	x[1][0] = x[1][0] / q_abs;
	x[2][0] = x[2][0] / q_abs;
	x[3][0] = x[3][0] / q_abs;

	x1 = x[0][0];
	x2 = x[1][0];
	x3 = x[2][0];
	x4 = x[3][0];

	// conversión de: Cuaterniones -> Ángulos de Euler
	// ángulos en radianes (rad)
	roll_rad = atan2(2 * (x1 * x2 + x3 * x4), 1 - 2 * (x2 * x2 + x3 * x3));
	pitch_rad = (-1)*asin(2 * x2 * x4 - 2 * x1 * x3);
	yaw_rad = atan2(2 * (x2 * x3 + x1 * x4), 1 - 2 * (x3 * x3 + x4 * x4));

	// ángulos en sexagecimales (°)
	roll = roll_rad * (180 / pi); // grados sexagesimales (°)
	pitch = pitch_rad * (180 / pi);
	yaw = yaw_rad * (180 / pi);

	//**************************FIN DEL FILTRO*****************************

	// ESTIMACIÓN DEL YAW CON DCM
	// YAW
	cos_roll = cos(roll_rad);
	sin_roll = sin(roll_rad);
	cos_pitch = cos(pitch_rad);
	sin_pitch = sin(pitch_rad);
	mag_x = C_mag_x * cos_pitch + C_mag_y * sin_roll * sin_pitch + C_mag_z
			* cos_roll * sin_pitch;
	mag_y = C_mag_y * cos_roll - C_mag_z * sin_roll;
	YAW_rad = atan2(-mag_y, mag_x);
	YAW = YAW_rad * (180 / pi);
	//********************************************************************

	wz = -wz;
}

// Multiplicación de 2 matrices: (7x7)(7x7)->(7x7)
void M_7x7_7x7(const float a[7][7], const float b[7][7], float out[7][7]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 7; j++) // columnas
		{
			out[i][j] = a[i][0] * b[0][j] + a[i][1] * b[1][j] + a[i][2]
					* b[2][j] + a[i][3] * b[3][j] + a[i][4] * b[4][j] + a[i][5]
					* b[5][j] + a[i][6] * b[6][j];
		}
	}
}

// transpuesta (7x7)
void transp_7x7(const float a[7][7], float out[7][7]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 7; j++) // columnas
		{
			out[j][i] = a[i][j];
		}
	}
}

// Sumar dos matrices(7x7)
void S_7x7(const float a[7][7], const float b[7][7], float out[7][7]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 7; j++) // columnas
		{
			out[i][j] = a[i][j] + b[i][j];
		}
	}
}

// Multiplicación de 2 matrices: (7x7)(7x1)->(7x1)
void M_7x7_7x1(const float a[7][7], const float b[7][1], float out[7][1]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 1; j++) // columnas
		{
			out[i][j] = a[i][0] * b[0][j] + a[i][1] * b[1][j] + a[i][2]
					* b[2][j] + a[i][3] * b[3][j] + a[i][4] * b[4][j] + a[i][5]
					* b[5][j] + a[i][6] * b[6][j];
		}
	}
}

// transpuesta (1x7) -> (7x1)
void transp_1x7(const float a[1][7], float out[7][1]) {
	for (i = 0; i < 1; i++) // filas
	{
		for (j = 0; j < 7; j++) // columnas
		{
			out[j][i] = a[i][j];
		}
	}
}

// Multiplicación de 2 matrices: (1x7)(7x1)->(1x1)
void M_1x7_7x1(const float a[1][7], const float b[7][1], float out[1][1]) {
	for (i = 0; i < 1; i++) // filas
	{
		for (j = 0; j < 1; j++) // columnas
		{
			out[i][j] = a[i][0] * b[0][j] + a[i][1] * b[1][j] + a[i][2]
					* b[2][j] + a[i][3] * b[3][j] + a[i][4] * b[4][j] + a[i][5]
					* b[5][j] + a[i][6] * b[6][j];
		}
	}
}

// División de una matriz entre un escalar: (7x1)/scale->(7x1)
void D_7x1_scale(const float a[7][1], float scale, float out[7][1]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 1; j++) // columnas
		{
			out[i][j] = a[i][0] / scale;
		}
	}
}

// Multiplicación de una matriz por un escalar: (7x1)*scale->(7x1)
void M_7x1_scale(const float a[7][1], float scale, float out[7][1]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 1; j++) // columnas
		{
			out[i][j] = a[i][0] * scale;
		}
	}
}

// Sumar dos matrices(7x1)
void S_7x1(const float a[7][1], const float b[7][1], float out[7][1]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 1; j++) // columnas
		{
			out[i][j] = a[i][j] + b[i][j];
		}
	}
}

// transpuesta (7x1) -> (1x7)
void transp_7x1(const float a[7][1], float out[1][7]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 1; j++) // columnas
		{
			out[j][i] = a[i][j];
		}
	}
}

// Multiplicación de 2 matrices: (7x1)(1x7)->(7x7)
void M_7x1_1x7(const float a[7][1], const float b[1][7], float out[7][7]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 7; j++) // columnas
		{
			out[i][j] = a[i][0] * b[0][j];
		}
	}
}

// Restar dos matrices(7x7)
void R_7x7(const float a[7][7], const float b[7][7], float out[7][7]) {
	for (i = 0; i < 7; i++) // filas
	{
		for (j = 0; j < 7; j++) // columnas
		{
			out[i][j] = a[i][j] - b[i][j];
		}
	}
}
