# stm32f3_example_proj

## Description
An example (template) project for STM32F303VC. <br>
It contains the main program, the startup file, the linker script, some lib archives, self-contained library headers and a Makefile to build the project, flash and debug. <br>
You don't need any IDE, just install ARM gcc toolchain on your system. <br> <br>
The example setups an interrupt on the user button to toggle all LEDs. <br>
When compiling, is ```<stdint.h>``` is missing, try (in Fedora):

```sudo dnf install arm-none-eabi-newlib```
 
