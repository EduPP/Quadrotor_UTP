#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting SOF File: D:\Proyectos\Proyectos_FPGA\AlteraProjects\Quad_100Mhz\Quad.sof to: "..\flash/Quad_epcs_flash_controller.flash"
#
$SOPC_KIT_NIOS2/bin/sof2flash --input="D:/Proyectos/Proyectos_FPGA/AlteraProjects/Quad_100Mhz/Quad.sof" --output="../flash/Quad_epcs_flash_controller.flash" --epcs --verbose 

#
# Programming File: "..\flash/Quad_epcs_flash_controller.flash" To Device: epcs_flash_controller
#
$SOPC_KIT_NIOS2/bin/nios2-flash-programmer "../flash/Quad_epcs_flash_controller.flash" --base=0x4001800 --epcs --sidp=0x40021E8 --id=0x0 --accept-bad-sysid --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program --verbose 

#
# Converting ELF File: D:\Proyectos\Proyectos_FPGA\AlteraProjects\Quad_100Mhz\software\Cont\Cont.elf to: "..\flash/Cont_epcs_flash_controller.flash"
#
$SOPC_KIT_NIOS2/bin/elf2flash --input="D:/Proyectos/Proyectos_FPGA/AlteraProjects/Quad_100Mhz/software/Cont/Cont.elf" --output="../flash/Cont_epcs_flash_controller.flash" --epcs --after="../flash/Quad_epcs_flash_controller.flash" --verbose 

#
# Programming File: "..\flash/Cont_epcs_flash_controller.flash" To Device: epcs_flash_controller
#
$SOPC_KIT_NIOS2/bin/nios2-flash-programmer "../flash/Cont_epcs_flash_controller.flash" --base=0x4001800 --epcs --sidp=0x40021E8 --id=0x0 --accept-bad-sysid --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program --verbose 

