/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu' in SOPC Builder design 'NiosII'
 * SOPC Builder design path: ../../NiosII.sopcinfo
 *
 * Generated: Tue Aug 30 13:31:36 COT 2016
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x4001020
#define ALT_CPU_CPU_FREQ 100000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x0
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1b
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 4096
#define ALT_CPU_EXCEPTION_ADDR 0x2000020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 100000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 8192
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x1b
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0x4001800


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x4001020
#define NIOS2_CPU_FREQ 100000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x0
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1b
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 4096
#define NIOS2_EXCEPTION_ADDR 0x2000020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 8192
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x1b
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0x4001800


/*
 * Custom instruction macros
 *
 */

#define ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST(n,A,B) __builtin_custom_inii(ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N+(n&ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N_MASK),(A),(B))
#define ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N 0xfc
#define ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N_MASK ((1<<2)-1)


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_EPCS_FLASH_CONTROLLER
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID
#define __ALTERA_AVALON_TIMER
#define __ALTERA_AVALON_UART
#define __ALTERA_NIOS2
#define __ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT
#define __ALTPLL


/*
 * PWM_1 configuration
 *
 */

#define ALT_MODULE_CLASS_PWM_1 altera_avalon_pio
#define PWM_1_BASE 0x4002150
#define PWM_1_BIT_CLEARING_EDGE_REGISTER 0
#define PWM_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PWM_1_CAPTURE 0
#define PWM_1_DATA_WIDTH 14
#define PWM_1_DO_TEST_BENCH_WIRING 0
#define PWM_1_DRIVEN_SIM_VALUE 0x0
#define PWM_1_EDGE_TYPE "NONE"
#define PWM_1_FREQ 100000000u
#define PWM_1_HAS_IN 0
#define PWM_1_HAS_OUT 1
#define PWM_1_HAS_TRI 0
#define PWM_1_IRQ -1
#define PWM_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PWM_1_IRQ_TYPE "NONE"
#define PWM_1_NAME "/dev/PWM_1"
#define PWM_1_RESET_VALUE 0x0
#define PWM_1_SPAN 16
#define PWM_1_TYPE "altera_avalon_pio"


/*
 * PWM_2 configuration
 *
 */

#define ALT_MODULE_CLASS_PWM_2 altera_avalon_pio
#define PWM_2_BASE 0x4002160
#define PWM_2_BIT_CLEARING_EDGE_REGISTER 0
#define PWM_2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PWM_2_CAPTURE 0
#define PWM_2_DATA_WIDTH 14
#define PWM_2_DO_TEST_BENCH_WIRING 0
#define PWM_2_DRIVEN_SIM_VALUE 0x0
#define PWM_2_EDGE_TYPE "NONE"
#define PWM_2_FREQ 100000000u
#define PWM_2_HAS_IN 0
#define PWM_2_HAS_OUT 1
#define PWM_2_HAS_TRI 0
#define PWM_2_IRQ -1
#define PWM_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PWM_2_IRQ_TYPE "NONE"
#define PWM_2_NAME "/dev/PWM_2"
#define PWM_2_RESET_VALUE 0x0
#define PWM_2_SPAN 16
#define PWM_2_TYPE "altera_avalon_pio"


/*
 * PWM_3 configuration
 *
 */

#define ALT_MODULE_CLASS_PWM_3 altera_avalon_pio
#define PWM_3_BASE 0x4002170
#define PWM_3_BIT_CLEARING_EDGE_REGISTER 0
#define PWM_3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PWM_3_CAPTURE 0
#define PWM_3_DATA_WIDTH 14
#define PWM_3_DO_TEST_BENCH_WIRING 0
#define PWM_3_DRIVEN_SIM_VALUE 0x0
#define PWM_3_EDGE_TYPE "NONE"
#define PWM_3_FREQ 100000000u
#define PWM_3_HAS_IN 0
#define PWM_3_HAS_OUT 1
#define PWM_3_HAS_TRI 0
#define PWM_3_IRQ -1
#define PWM_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PWM_3_IRQ_TYPE "NONE"
#define PWM_3_NAME "/dev/PWM_3"
#define PWM_3_RESET_VALUE 0x0
#define PWM_3_SPAN 16
#define PWM_3_TYPE "altera_avalon_pio"


/*
 * PWM_4 configuration
 *
 */

#define ALT_MODULE_CLASS_PWM_4 altera_avalon_pio
#define PWM_4_BASE 0x4002180
#define PWM_4_BIT_CLEARING_EDGE_REGISTER 0
#define PWM_4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PWM_4_CAPTURE 0
#define PWM_4_DATA_WIDTH 14
#define PWM_4_DO_TEST_BENCH_WIRING 0
#define PWM_4_DRIVEN_SIM_VALUE 0x0
#define PWM_4_EDGE_TYPE "NONE"
#define PWM_4_FREQ 100000000u
#define PWM_4_HAS_IN 0
#define PWM_4_HAS_OUT 1
#define PWM_4_HAS_TRI 0
#define PWM_4_IRQ -1
#define PWM_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PWM_4_IRQ_TYPE "NONE"
#define PWM_4_NAME "/dev/PWM_4"
#define PWM_4_RESET_VALUE 0x0
#define PWM_4_SPAN 16
#define PWM_4_TYPE "altera_avalon_pio"


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "CYCLONEIVE"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x40021e0
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x40021e0
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x40021e0
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "NiosII"


/*
 * data_tx configuration
 *
 */

#define ALT_MODULE_CLASS_data_tx altera_avalon_pio
#define DATA_TX_BASE 0x40021d0
#define DATA_TX_BIT_CLEARING_EDGE_REGISTER 0
#define DATA_TX_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATA_TX_CAPTURE 0
#define DATA_TX_DATA_WIDTH 9
#define DATA_TX_DO_TEST_BENCH_WIRING 0
#define DATA_TX_DRIVEN_SIM_VALUE 0x0
#define DATA_TX_EDGE_TYPE "NONE"
#define DATA_TX_FREQ 100000000u
#define DATA_TX_HAS_IN 0
#define DATA_TX_HAS_OUT 1
#define DATA_TX_HAS_TRI 0
#define DATA_TX_IRQ -1
#define DATA_TX_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DATA_TX_IRQ_TYPE "NONE"
#define DATA_TX_NAME "/dev/data_tx"
#define DATA_TX_RESET_VALUE 0x0
#define DATA_TX_SPAN 16
#define DATA_TX_TYPE "altera_avalon_pio"


/*
 * duty_1 configuration
 *
 */

#define ALT_MODULE_CLASS_duty_1 altera_avalon_pio
#define DUTY_1_BASE 0x4002190
#define DUTY_1_BIT_CLEARING_EDGE_REGISTER 0
#define DUTY_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DUTY_1_CAPTURE 0
#define DUTY_1_DATA_WIDTH 12
#define DUTY_1_DO_TEST_BENCH_WIRING 0
#define DUTY_1_DRIVEN_SIM_VALUE 0x0
#define DUTY_1_EDGE_TYPE "NONE"
#define DUTY_1_FREQ 100000000u
#define DUTY_1_HAS_IN 1
#define DUTY_1_HAS_OUT 0
#define DUTY_1_HAS_TRI 0
#define DUTY_1_IRQ -1
#define DUTY_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DUTY_1_IRQ_TYPE "NONE"
#define DUTY_1_NAME "/dev/duty_1"
#define DUTY_1_RESET_VALUE 0x0
#define DUTY_1_SPAN 16
#define DUTY_1_TYPE "altera_avalon_pio"


/*
 * duty_2 configuration
 *
 */

#define ALT_MODULE_CLASS_duty_2 altera_avalon_pio
#define DUTY_2_BASE 0x40021a0
#define DUTY_2_BIT_CLEARING_EDGE_REGISTER 0
#define DUTY_2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DUTY_2_CAPTURE 0
#define DUTY_2_DATA_WIDTH 12
#define DUTY_2_DO_TEST_BENCH_WIRING 0
#define DUTY_2_DRIVEN_SIM_VALUE 0x0
#define DUTY_2_EDGE_TYPE "NONE"
#define DUTY_2_FREQ 100000000u
#define DUTY_2_HAS_IN 1
#define DUTY_2_HAS_OUT 0
#define DUTY_2_HAS_TRI 0
#define DUTY_2_IRQ -1
#define DUTY_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DUTY_2_IRQ_TYPE "NONE"
#define DUTY_2_NAME "/dev/duty_2"
#define DUTY_2_RESET_VALUE 0x0
#define DUTY_2_SPAN 16
#define DUTY_2_TYPE "altera_avalon_pio"


/*
 * duty_3 configuration
 *
 */

#define ALT_MODULE_CLASS_duty_3 altera_avalon_pio
#define DUTY_3_BASE 0x40021b0
#define DUTY_3_BIT_CLEARING_EDGE_REGISTER 0
#define DUTY_3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DUTY_3_CAPTURE 0
#define DUTY_3_DATA_WIDTH 12
#define DUTY_3_DO_TEST_BENCH_WIRING 0
#define DUTY_3_DRIVEN_SIM_VALUE 0x0
#define DUTY_3_EDGE_TYPE "NONE"
#define DUTY_3_FREQ 100000000u
#define DUTY_3_HAS_IN 1
#define DUTY_3_HAS_OUT 0
#define DUTY_3_HAS_TRI 0
#define DUTY_3_IRQ -1
#define DUTY_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DUTY_3_IRQ_TYPE "NONE"
#define DUTY_3_NAME "/dev/duty_3"
#define DUTY_3_RESET_VALUE 0x0
#define DUTY_3_SPAN 16
#define DUTY_3_TYPE "altera_avalon_pio"


/*
 * duty_4 configuration
 *
 */

#define ALT_MODULE_CLASS_duty_4 altera_avalon_pio
#define DUTY_4_BASE 0x40021c0
#define DUTY_4_BIT_CLEARING_EDGE_REGISTER 0
#define DUTY_4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DUTY_4_CAPTURE 0
#define DUTY_4_DATA_WIDTH 12
#define DUTY_4_DO_TEST_BENCH_WIRING 0
#define DUTY_4_DRIVEN_SIM_VALUE 0x0
#define DUTY_4_EDGE_TYPE "NONE"
#define DUTY_4_FREQ 100000000u
#define DUTY_4_HAS_IN 1
#define DUTY_4_HAS_OUT 0
#define DUTY_4_HAS_TRI 0
#define DUTY_4_IRQ -1
#define DUTY_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DUTY_4_IRQ_TYPE "NONE"
#define DUTY_4_NAME "/dev/duty_4"
#define DUTY_4_RESET_VALUE 0x0
#define DUTY_4_SPAN 16
#define DUTY_4_TYPE "altera_avalon_pio"


/*
 * entrada_ac_eje_X configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_ac_eje_X altera_avalon_pio
#define ENTRADA_AC_EJE_X_BASE 0x40020b0
#define ENTRADA_AC_EJE_X_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_AC_EJE_X_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_AC_EJE_X_CAPTURE 0
#define ENTRADA_AC_EJE_X_DATA_WIDTH 16
#define ENTRADA_AC_EJE_X_DO_TEST_BENCH_WIRING 0
#define ENTRADA_AC_EJE_X_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_AC_EJE_X_EDGE_TYPE "NONE"
#define ENTRADA_AC_EJE_X_FREQ 100000000u
#define ENTRADA_AC_EJE_X_HAS_IN 1
#define ENTRADA_AC_EJE_X_HAS_OUT 0
#define ENTRADA_AC_EJE_X_HAS_TRI 0
#define ENTRADA_AC_EJE_X_IRQ -1
#define ENTRADA_AC_EJE_X_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_AC_EJE_X_IRQ_TYPE "NONE"
#define ENTRADA_AC_EJE_X_NAME "/dev/entrada_ac_eje_X"
#define ENTRADA_AC_EJE_X_RESET_VALUE 0x0
#define ENTRADA_AC_EJE_X_SPAN 16
#define ENTRADA_AC_EJE_X_TYPE "altera_avalon_pio"


/*
 * entrada_ac_eje_Y configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_ac_eje_Y altera_avalon_pio
#define ENTRADA_AC_EJE_Y_BASE 0x40020c0
#define ENTRADA_AC_EJE_Y_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_AC_EJE_Y_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_AC_EJE_Y_CAPTURE 0
#define ENTRADA_AC_EJE_Y_DATA_WIDTH 16
#define ENTRADA_AC_EJE_Y_DO_TEST_BENCH_WIRING 0
#define ENTRADA_AC_EJE_Y_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_AC_EJE_Y_EDGE_TYPE "NONE"
#define ENTRADA_AC_EJE_Y_FREQ 100000000u
#define ENTRADA_AC_EJE_Y_HAS_IN 1
#define ENTRADA_AC_EJE_Y_HAS_OUT 0
#define ENTRADA_AC_EJE_Y_HAS_TRI 0
#define ENTRADA_AC_EJE_Y_IRQ -1
#define ENTRADA_AC_EJE_Y_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_AC_EJE_Y_IRQ_TYPE "NONE"
#define ENTRADA_AC_EJE_Y_NAME "/dev/entrada_ac_eje_Y"
#define ENTRADA_AC_EJE_Y_RESET_VALUE 0x0
#define ENTRADA_AC_EJE_Y_SPAN 16
#define ENTRADA_AC_EJE_Y_TYPE "altera_avalon_pio"


/*
 * entrada_ac_eje_Z configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_ac_eje_Z altera_avalon_pio
#define ENTRADA_AC_EJE_Z_BASE 0x40020d0
#define ENTRADA_AC_EJE_Z_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_AC_EJE_Z_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_AC_EJE_Z_CAPTURE 0
#define ENTRADA_AC_EJE_Z_DATA_WIDTH 16
#define ENTRADA_AC_EJE_Z_DO_TEST_BENCH_WIRING 0
#define ENTRADA_AC_EJE_Z_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_AC_EJE_Z_EDGE_TYPE "NONE"
#define ENTRADA_AC_EJE_Z_FREQ 100000000u
#define ENTRADA_AC_EJE_Z_HAS_IN 1
#define ENTRADA_AC_EJE_Z_HAS_OUT 0
#define ENTRADA_AC_EJE_Z_HAS_TRI 0
#define ENTRADA_AC_EJE_Z_IRQ -1
#define ENTRADA_AC_EJE_Z_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_AC_EJE_Z_IRQ_TYPE "NONE"
#define ENTRADA_AC_EJE_Z_NAME "/dev/entrada_ac_eje_Z"
#define ENTRADA_AC_EJE_Z_RESET_VALUE 0x0
#define ENTRADA_AC_EJE_Z_SPAN 16
#define ENTRADA_AC_EJE_Z_TYPE "altera_avalon_pio"


/*
 * entrada_gy_eje_X configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_gy_eje_X altera_avalon_pio
#define ENTRADA_GY_EJE_X_BASE 0x4002110
#define ENTRADA_GY_EJE_X_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_GY_EJE_X_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_GY_EJE_X_CAPTURE 0
#define ENTRADA_GY_EJE_X_DATA_WIDTH 16
#define ENTRADA_GY_EJE_X_DO_TEST_BENCH_WIRING 0
#define ENTRADA_GY_EJE_X_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_GY_EJE_X_EDGE_TYPE "NONE"
#define ENTRADA_GY_EJE_X_FREQ 100000000u
#define ENTRADA_GY_EJE_X_HAS_IN 1
#define ENTRADA_GY_EJE_X_HAS_OUT 0
#define ENTRADA_GY_EJE_X_HAS_TRI 0
#define ENTRADA_GY_EJE_X_IRQ -1
#define ENTRADA_GY_EJE_X_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_GY_EJE_X_IRQ_TYPE "NONE"
#define ENTRADA_GY_EJE_X_NAME "/dev/entrada_gy_eje_X"
#define ENTRADA_GY_EJE_X_RESET_VALUE 0x0
#define ENTRADA_GY_EJE_X_SPAN 16
#define ENTRADA_GY_EJE_X_TYPE "altera_avalon_pio"


/*
 * entrada_gy_eje_Y configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_gy_eje_Y altera_avalon_pio
#define ENTRADA_GY_EJE_Y_BASE 0x4002120
#define ENTRADA_GY_EJE_Y_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_GY_EJE_Y_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_GY_EJE_Y_CAPTURE 0
#define ENTRADA_GY_EJE_Y_DATA_WIDTH 16
#define ENTRADA_GY_EJE_Y_DO_TEST_BENCH_WIRING 0
#define ENTRADA_GY_EJE_Y_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_GY_EJE_Y_EDGE_TYPE "NONE"
#define ENTRADA_GY_EJE_Y_FREQ 100000000u
#define ENTRADA_GY_EJE_Y_HAS_IN 1
#define ENTRADA_GY_EJE_Y_HAS_OUT 0
#define ENTRADA_GY_EJE_Y_HAS_TRI 0
#define ENTRADA_GY_EJE_Y_IRQ -1
#define ENTRADA_GY_EJE_Y_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_GY_EJE_Y_IRQ_TYPE "NONE"
#define ENTRADA_GY_EJE_Y_NAME "/dev/entrada_gy_eje_Y"
#define ENTRADA_GY_EJE_Y_RESET_VALUE 0x0
#define ENTRADA_GY_EJE_Y_SPAN 16
#define ENTRADA_GY_EJE_Y_TYPE "altera_avalon_pio"


/*
 * entrada_gy_eje_Z configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_gy_eje_Z altera_avalon_pio
#define ENTRADA_GY_EJE_Z_BASE 0x4002130
#define ENTRADA_GY_EJE_Z_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_GY_EJE_Z_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_GY_EJE_Z_CAPTURE 0
#define ENTRADA_GY_EJE_Z_DATA_WIDTH 16
#define ENTRADA_GY_EJE_Z_DO_TEST_BENCH_WIRING 0
#define ENTRADA_GY_EJE_Z_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_GY_EJE_Z_EDGE_TYPE "NONE"
#define ENTRADA_GY_EJE_Z_FREQ 100000000u
#define ENTRADA_GY_EJE_Z_HAS_IN 1
#define ENTRADA_GY_EJE_Z_HAS_OUT 0
#define ENTRADA_GY_EJE_Z_HAS_TRI 0
#define ENTRADA_GY_EJE_Z_IRQ -1
#define ENTRADA_GY_EJE_Z_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_GY_EJE_Z_IRQ_TYPE "NONE"
#define ENTRADA_GY_EJE_Z_NAME "/dev/entrada_gy_eje_Z"
#define ENTRADA_GY_EJE_Z_RESET_VALUE 0x0
#define ENTRADA_GY_EJE_Z_SPAN 16
#define ENTRADA_GY_EJE_Z_TYPE "altera_avalon_pio"


/*
 * entrada_ma_eje_X configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_ma_eje_X altera_avalon_pio
#define ENTRADA_MA_EJE_X_BASE 0x40020e0
#define ENTRADA_MA_EJE_X_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_MA_EJE_X_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_MA_EJE_X_CAPTURE 0
#define ENTRADA_MA_EJE_X_DATA_WIDTH 16
#define ENTRADA_MA_EJE_X_DO_TEST_BENCH_WIRING 0
#define ENTRADA_MA_EJE_X_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_MA_EJE_X_EDGE_TYPE "NONE"
#define ENTRADA_MA_EJE_X_FREQ 100000000u
#define ENTRADA_MA_EJE_X_HAS_IN 1
#define ENTRADA_MA_EJE_X_HAS_OUT 0
#define ENTRADA_MA_EJE_X_HAS_TRI 0
#define ENTRADA_MA_EJE_X_IRQ -1
#define ENTRADA_MA_EJE_X_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_MA_EJE_X_IRQ_TYPE "NONE"
#define ENTRADA_MA_EJE_X_NAME "/dev/entrada_ma_eje_X"
#define ENTRADA_MA_EJE_X_RESET_VALUE 0x0
#define ENTRADA_MA_EJE_X_SPAN 16
#define ENTRADA_MA_EJE_X_TYPE "altera_avalon_pio"


/*
 * entrada_ma_eje_Y configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_ma_eje_Y altera_avalon_pio
#define ENTRADA_MA_EJE_Y_BASE 0x40020f0
#define ENTRADA_MA_EJE_Y_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_MA_EJE_Y_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_MA_EJE_Y_CAPTURE 0
#define ENTRADA_MA_EJE_Y_DATA_WIDTH 16
#define ENTRADA_MA_EJE_Y_DO_TEST_BENCH_WIRING 0
#define ENTRADA_MA_EJE_Y_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_MA_EJE_Y_EDGE_TYPE "NONE"
#define ENTRADA_MA_EJE_Y_FREQ 100000000u
#define ENTRADA_MA_EJE_Y_HAS_IN 1
#define ENTRADA_MA_EJE_Y_HAS_OUT 0
#define ENTRADA_MA_EJE_Y_HAS_TRI 0
#define ENTRADA_MA_EJE_Y_IRQ -1
#define ENTRADA_MA_EJE_Y_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_MA_EJE_Y_IRQ_TYPE "NONE"
#define ENTRADA_MA_EJE_Y_NAME "/dev/entrada_ma_eje_Y"
#define ENTRADA_MA_EJE_Y_RESET_VALUE 0x0
#define ENTRADA_MA_EJE_Y_SPAN 16
#define ENTRADA_MA_EJE_Y_TYPE "altera_avalon_pio"


/*
 * entrada_ma_eje_Z configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_ma_eje_Z altera_avalon_pio
#define ENTRADA_MA_EJE_Z_BASE 0x4002100
#define ENTRADA_MA_EJE_Z_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_MA_EJE_Z_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_MA_EJE_Z_CAPTURE 0
#define ENTRADA_MA_EJE_Z_DATA_WIDTH 16
#define ENTRADA_MA_EJE_Z_DO_TEST_BENCH_WIRING 0
#define ENTRADA_MA_EJE_Z_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_MA_EJE_Z_EDGE_TYPE "NONE"
#define ENTRADA_MA_EJE_Z_FREQ 100000000u
#define ENTRADA_MA_EJE_Z_HAS_IN 1
#define ENTRADA_MA_EJE_Z_HAS_OUT 0
#define ENTRADA_MA_EJE_Z_HAS_TRI 0
#define ENTRADA_MA_EJE_Z_IRQ -1
#define ENTRADA_MA_EJE_Z_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_MA_EJE_Z_IRQ_TYPE "NONE"
#define ENTRADA_MA_EJE_Z_NAME "/dev/entrada_ma_eje_Z"
#define ENTRADA_MA_EJE_Z_RESET_VALUE 0x0
#define ENTRADA_MA_EJE_Z_SPAN 16
#define ENTRADA_MA_EJE_Z_TYPE "altera_avalon_pio"


/*
 * entrada_temp configuration
 *
 */

#define ALT_MODULE_CLASS_entrada_temp altera_avalon_pio
#define ENTRADA_TEMP_BASE 0x4002140
#define ENTRADA_TEMP_BIT_CLEARING_EDGE_REGISTER 0
#define ENTRADA_TEMP_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ENTRADA_TEMP_CAPTURE 0
#define ENTRADA_TEMP_DATA_WIDTH 16
#define ENTRADA_TEMP_DO_TEST_BENCH_WIRING 0
#define ENTRADA_TEMP_DRIVEN_SIM_VALUE 0x0
#define ENTRADA_TEMP_EDGE_TYPE "NONE"
#define ENTRADA_TEMP_FREQ 100000000u
#define ENTRADA_TEMP_HAS_IN 1
#define ENTRADA_TEMP_HAS_OUT 0
#define ENTRADA_TEMP_HAS_TRI 0
#define ENTRADA_TEMP_IRQ -1
#define ENTRADA_TEMP_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ENTRADA_TEMP_IRQ_TYPE "NONE"
#define ENTRADA_TEMP_NAME "/dev/entrada_temp"
#define ENTRADA_TEMP_RESET_VALUE 0x0
#define ENTRADA_TEMP_SPAN 16
#define ENTRADA_TEMP_TYPE "altera_avalon_pio"


/*
 * epcs_flash_controller configuration
 *
 */

#define ALT_MODULE_CLASS_epcs_flash_controller altera_avalon_epcs_flash_controller
#define EPCS_FLASH_CONTROLLER_BASE 0x4001800
#define EPCS_FLASH_CONTROLLER_IRQ 2
#define EPCS_FLASH_CONTROLLER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define EPCS_FLASH_CONTROLLER_NAME "/dev/epcs_flash_controller"
#define EPCS_FLASH_CONTROLLER_REGISTER_OFFSET 1024
#define EPCS_FLASH_CONTROLLER_SPAN 2048
#define EPCS_FLASH_CONTROLLER_TYPE "altera_avalon_epcs_flash_controller"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK SAMPLE_TIME
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x40021e0
#define JTAG_UART_IRQ 0
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * out_test configuration
 *
 */

#define ALT_MODULE_CLASS_out_test altera_avalon_pio
#define OUT_TEST_BASE 0x4002020
#define OUT_TEST_BIT_CLEARING_EDGE_REGISTER 0
#define OUT_TEST_BIT_MODIFYING_OUTPUT_REGISTER 1
#define OUT_TEST_CAPTURE 0
#define OUT_TEST_DATA_WIDTH 4
#define OUT_TEST_DO_TEST_BENCH_WIRING 0
#define OUT_TEST_DRIVEN_SIM_VALUE 0x0
#define OUT_TEST_EDGE_TYPE "NONE"
#define OUT_TEST_FREQ 100000000u
#define OUT_TEST_HAS_IN 0
#define OUT_TEST_HAS_OUT 1
#define OUT_TEST_HAS_TRI 0
#define OUT_TEST_IRQ -1
#define OUT_TEST_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OUT_TEST_IRQ_TYPE "NONE"
#define OUT_TEST_NAME "/dev/out_test"
#define OUT_TEST_RESET_VALUE 0x0
#define OUT_TEST_SPAN 32
#define OUT_TEST_TYPE "altera_avalon_pio"


/*
 * pll configuration
 *
 */

#define ALT_MODULE_CLASS_pll altpll
#define PLL_BASE 0x40020a0
#define PLL_IRQ -1
#define PLL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PLL_NAME "/dev/pll"
#define PLL_SPAN 16
#define PLL_TYPE "altpll"


/*
 * sample_time configuration
 *
 */

#define ALT_MODULE_CLASS_sample_time altera_avalon_timer
#define SAMPLE_TIME_ALWAYS_RUN 1
#define SAMPLE_TIME_BASE 0x4002000
#define SAMPLE_TIME_COUNTER_SIZE 32
#define SAMPLE_TIME_FIXED_PERIOD 1
#define SAMPLE_TIME_FREQ 100000000u
#define SAMPLE_TIME_IRQ 1
#define SAMPLE_TIME_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SAMPLE_TIME_LOAD_VALUE 699999ull
#define SAMPLE_TIME_MULT 0.0010
#define SAMPLE_TIME_NAME "/dev/sample_time"
#define SAMPLE_TIME_PERIOD 7
#define SAMPLE_TIME_PERIOD_UNITS "ms"
#define SAMPLE_TIME_RESET_OUTPUT 0
#define SAMPLE_TIME_SNAPSHOT 0
#define SAMPLE_TIME_SPAN 32
#define SAMPLE_TIME_TICKS_PER_SEC 143u
#define SAMPLE_TIME_TIMEOUT_PULSE_OUTPUT 0
#define SAMPLE_TIME_TYPE "altera_avalon_timer"


/*
 * sdram configuration
 *
 */

#define ALT_MODULE_CLASS_sdram altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x2000000
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO ""
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/sdram"
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_REFRESH_PERIOD 15.625
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x18
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 9
#define SDRAM_SDRAM_DATA_WIDTH 16
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 33554432
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.5
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_WR 14.0


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid
#define SYSID_BASE 0x40021e8
#define SYSID_ID 0u
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1472580455u
#define SYSID_TYPE "altera_avalon_sysid"


/*
 * timer_ONOF configuration
 *
 */

#define ALT_MODULE_CLASS_timer_ONOF altera_avalon_timer
#define TIMER_ONOF_ALWAYS_RUN 1
#define TIMER_ONOF_BASE 0x4002080
#define TIMER_ONOF_COUNTER_SIZE 32
#define TIMER_ONOF_FIXED_PERIOD 1
#define TIMER_ONOF_FREQ 100000000u
#define TIMER_ONOF_IRQ 5
#define TIMER_ONOF_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_ONOF_LOAD_VALUE 9999999ull
#define TIMER_ONOF_MULT 0.0010
#define TIMER_ONOF_NAME "/dev/timer_ONOF"
#define TIMER_ONOF_PERIOD 100
#define TIMER_ONOF_PERIOD_UNITS "ms"
#define TIMER_ONOF_RESET_OUTPUT 0
#define TIMER_ONOF_SNAPSHOT 0
#define TIMER_ONOF_SPAN 32
#define TIMER_ONOF_TICKS_PER_SEC 10u
#define TIMER_ONOF_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_ONOF_TYPE "altera_avalon_timer"


/*
 * uart_gps configuration
 *
 */

#define ALT_MODULE_CLASS_uart_gps altera_avalon_uart
#define UART_GPS_BASE 0x4002040
#define UART_GPS_BAUD 115200
#define UART_GPS_DATA_BITS 8
#define UART_GPS_FIXED_BAUD 1
#define UART_GPS_FREQ 100000000u
#define UART_GPS_IRQ 3
#define UART_GPS_IRQ_INTERRUPT_CONTROLLER_ID 0
#define UART_GPS_NAME "/dev/uart_gps"
#define UART_GPS_PARITY 'N'
#define UART_GPS_SIM_CHAR_STREAM ""
#define UART_GPS_SIM_TRUE_BAUD 0
#define UART_GPS_SPAN 32
#define UART_GPS_STOP_BITS 1
#define UART_GPS_SYNC_REG_DEPTH 2
#define UART_GPS_TYPE "altera_avalon_uart"
#define UART_GPS_USE_CTS_RTS 0
#define UART_GPS_USE_EOP_REGISTER 0


/*
 * uart_xbee configuration
 *
 */

#define ALT_MODULE_CLASS_uart_xbee altera_avalon_uart
#define UART_XBEE_BASE 0x4002060
#define UART_XBEE_BAUD 115200
#define UART_XBEE_DATA_BITS 8
#define UART_XBEE_FIXED_BAUD 1
#define UART_XBEE_FREQ 100000000u
#define UART_XBEE_IRQ 4
#define UART_XBEE_IRQ_INTERRUPT_CONTROLLER_ID 0
#define UART_XBEE_NAME "/dev/uart_xbee"
#define UART_XBEE_PARITY 'N'
#define UART_XBEE_SIM_CHAR_STREAM ""
#define UART_XBEE_SIM_TRUE_BAUD 0
#define UART_XBEE_SPAN 32
#define UART_XBEE_STOP_BITS 1
#define UART_XBEE_SYNC_REG_DEPTH 2
#define UART_XBEE_TYPE "altera_avalon_uart"
#define UART_XBEE_USE_CTS_RTS 0
#define UART_XBEE_USE_EOP_REGISTER 0

#endif /* __SYSTEM_H_ */
