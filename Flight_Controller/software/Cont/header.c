#include "stdio.h"
#include "header.h"
#include "altera_avalon_uart_regs.h"
#include "system.h"
#include <math.h>

void qPID_Init(qPID * q){
	q->ctx.Ui_old = 0.0;
	q->ctx.Ud_old = 0.0;
	q->ctx.PV_old = 0.0;
	q->ctx.SP_old = 0.0;
}

float qPID_Process_(qPID * q, float Input, float PV, float terms[]){


	// =====================================
	//   MANUAL
	// =====================================
	// Input = manual input -> CO

	// =====================================
	//   AUTOMATIC
	// =====================================
	// Input = Setpoint

	// For local use
	float ControllerOutput;
	float Up, Ui, Ud;
	float Kp, Ki, Kd_a, Kd_b,Kd_c;


	if (fabs(q->Ti)<EPSILON){
		q->Ti = EPSILON;
	}
	Kp = q->K;
	Ki = ((q->K) * (q->Ts) )/ (q->Ti);
	Kd_a = q->Td/(q->Td + q->Nd*q->Ts) ;
	Kd_b = (q->K*q->Td*q->Nd)/(q->Td + q->Nd*q->Ts);
	Kd_c = (q->c*q->K*q->Td*q->Nd)/(q->Td + q->Nd*q->Ts);


	// Proportional gain
	Up = Kp*( ( (q->b)*(Input) ) - PV);

	// Deriative gain with filter
	Ud = Kd_a * (q->ctx.Ud_old) - Kd_b*(PV-q->ctx.PV_old) + Kd_c*(Input-q->ctx.SP_old);

	// Get last integral
	Ui =  q->ctx.Ui_old;

	// Calculate controler output for Automatic or manual mode
	float out;
	switch (q->Mode){
		case MANUAL:
			ControllerOutput = Input;

			if (q->Bumpless == ENABLED){
				q->ctx.Ui_old = PV;
			}

			break;

		case AUTOMATIC:
			ControllerOutput =  Up + Ui + Ud;
			out = ControllerOutput;
			if (ControllerOutput > q->OutputMax){
				ControllerOutput = q->OutputMax;
			}else if (ControllerOutput < q->OutputMin){
				ControllerOutput = q->OutputMin;
			}
			break;

		case RELAY:
			if ((Input-PV)>=0){
				ControllerOutput = q->OutputMax;
			}else{
				ControllerOutput = q->OutputMin;
			}
			break;
		default:
			// ERROR
			ControllerOutput = NAN;
			break;
	}

	// Output parameters for debug
	if (terms!=NULL){
		terms[0] = Up;
		terms[1] = Ui;
		terms[2] = Ud;
	}

	// Calc de integral for the next step
	Ui = q->ctx.Ui_old + Ki*((Input)-PV);

	// Anti Windup Back Calculation!
	float Antwinup=0;
	if ( (q->AntiWindup == ENABLED) && (q->Mode==AUTOMATIC) ){
		if (out>q->OutputMax){
			Antwinup = (q->Ts)*(1/q->Tt)*(q->OutputMax-out);
			Ui = Ui + Antwinup;
		}else if (out<q->OutputMin){
			Antwinup = (q->Ts)*(1/q->Tt)*(q->OutputMin-out);
			Ui = Ui + Antwinup;
		}
	}

	if(q->Integrador == DISABLED)
		Ui = 0;

	// Save context for next step.
	q->ctx.Ui_old = Ui;
	q->ctx.Ud_old = Ud;
	q->ctx.PV_old = PV;
	q->ctx.SP_old = Input;

	return ControllerOutput;
}

// Send a character out to the serial interface.
void  UART_SendChar(char Ch)
 { // wait for empty buffer
	IOWR(DATA_TX_BASE, 0, 0xFF00|Ch);
    IOWR(DATA_TX_BASE, 0, 0x0000);

 }

// Send a string out to the serial interface.
void UART_SendString (char *str)
 { char * p;
   p = str;
   while (*p)// loop until *p == ‘\0’, end of string
      UART_SendChar(*p++);
 }

void UART_SendInt(int n)
{
int cant=0,r,i;
char s[10];
   do{
	r=n-(n/10)*10;//residuo
	n=n/10;
	r=r+48;
	s[cant]=(char)(r);
	cant++;
	}
	while(n!=0);

	i=cant-1;
  while(s[i]) // loop until *s == ‘\0’, end of string
  UART_SendChar(s[i--]); // send the character and point to the next one

}

void a_2decimales(int n){
int u,d,c;

u=n/100;
d=(n%100)/10;
c=n%10;
UART_SendInt(u);UART_SendChar(',');UART_SendInt(d);UART_SendInt(c);
}

void SendTrama(float *txtrama,int numdatos)
{	int i,j;

	for(j=0;j<numdatos;j++){
		sendtrama.txtrama[j]=txtrama[j];
	}

	UART_SendChar(88);
	for(i=0;i<=(sizeof(float)*numdatos-1);i++){
		IOWR(DATA_TX_BASE, 0, 0xFF00|sendtrama.bytes_txtrama[i]);
	    IOWR(DATA_TX_BASE, 0, 0x0000);
	}
	UART_SendChar(90);
}

