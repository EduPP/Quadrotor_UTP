# Quadrotor UTP
Código fuente del computador de vuelo o autopiloto de un UAV tipo Quadrotor creado en el año 2015 basado en una FPGA D0 nano. El codigo contiene la arquitectura hardware del computador de vuelo en VHDL y el software que implementa 3 PID en cascada para controlar la orientación el Quadrotor.

## Arqutitectura de hardware:
* Un procesador NIOS II
* Periferico UART (protocolo de comunicación serial) de conexión con un modulo XBEE para comunicación con la estación terrena incluyendo un FIFO para almacenar los bytes de envio.
* Controlador de memoria SDRAM
* Controlador de memoria FLASH
* Periferico I2C para comunicación con los sensores inerciales.
* Módulos PWM para el control de los motores Brushless
* Decodificador de las señales del Mando a control remoto

![image](https://user-images.githubusercontent.com/44615546/135304864-9fab8cd6-0e42-455a-a468-4fa874411b1e.png)

## Controladores PID
Para el control de la actitud se implementaron PID en cascada de forma independiente por cada grado de libertad. La estructura de control por cada grado de libertad consistió en un PID para el lazo interno controlando la velocidad angular y un PI para el lazo externo controlando la orientación. Además a los controladores se les agregó mejoras como el AntiWindup y Filtro en la acción derivativa.

![image](https://user-images.githubusercontent.com/44615546/135306441-f563877b-04ef-4c76-b24c-7166ae337b4e.png)
