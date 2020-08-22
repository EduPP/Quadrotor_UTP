
#ifndef HEADER_H_
#define HEADER_H_

union Send_trama{
  float txtrama[10];			//13*4 = 52 bytes
  char bytes_txtrama[80];
}sendtrama;

union Recv_trama{
  float imu[4];			//1 opcion y 3 : P I D	 -> 16 bytes
  char bytes_imu[32];
}recvtrama;

//================================================================
//*********    qPID    **************************
//================================================================

typedef enum{
	DISABLED=0,
	ENABLED
} qPID_Feature;

typedef enum{
	MANUAL=0,
	AUTOMATIC,
	RELAY
} qPID_Mode;

typedef struct{
	float PV_old;
	float Ui_old;
	float Ud_old;
	float SP_old;
} qPID_Context;

typedef struct{

	// Parameters:
	float K, Ti, Td, Tt;	// For use in NON-INT or INT modes

	float OutputMax;	// For windup
	float OutputMin;	// For windup

	float Nd;			// For derivator
	float b, c;			// For setpoint Weighting

	float Ts;			// General propoerty
	
	// Features:
	qPID_Mode			Mode;
	qPID_Feature 		AntiWindup;
	qPID_Feature 		Bumpless;
	qPID_Feature	    Integrador;
	qPID_Context		ctx;

}qPID;

//================================================================
// Defines
//================================================================
#define	EPSILON	0.0000001

//================================================================
// Prototypes
//================================================================
void qPID_Init(qPID * q);
float qPID_Process_(qPID * q, float Input, float ProcessVariable, float terms[]);
#define qPID_Procees(pPID,input,pv) qPID_Process_(pPID,input,pv,NULL);

void UART_SendChar(char);
void UART_SendString (char *);
void UART_SendInt(int);
void a_2decimales(int);
void SendTrama(float *,int);

#endif /* HEADER_H_ */
