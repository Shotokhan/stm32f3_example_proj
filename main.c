#include "lib/stm32f30x.h"

void EXTI0_IRQHandler();

int stato = 0;

int main()
{
  RCC->AHBENR |= RCC_AHBENR_GPIOAEN;
  RCC->AHBENR |= RCC_AHBENR_GPIOEEN;
  
  GPIOA->MODER &= 0xFFFFFFFC;
  GPIOE->MODER |= 0x55550000;
  
  EXTI->IMR |= 0x00000001;
  EXTI->FTSR |= 0x00000001;
  
  NVIC->ISER[0] |= (1 << 6);
  
  while(1){}

}

void EXTI0_IRQHandler(){
 EXTI->PR |= 0x00000001;
 switch(stato){
 case 0:
   GPIOE->ODR |= 0x0000FF00;
   stato = 1;
   break;
 case 1:
   GPIOE->ODR &= 0xFFFF00FF;
   stato = 0;
   break;
 }
}

