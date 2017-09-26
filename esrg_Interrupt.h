#ifndef __esrg_INTERRUPT_H__
#define __esrg_INTERRUPT_H__

#define NUM_INTERRUPT_IMX6Q 128
#define NUM_CORE_IMX6Q 4
#include "stdint.h"
//extern esrg_IRQ_Handler_Ptr esrg_ISR_Vector[NUM_INTERRUPT_IMX6Q];
//extern volatile uint32_t g_vectNum[NUM_CORE_IMX6Q];

// Interrupt service routine.
typedef void (*esrg_IRQ_Handler_Ptr) (void);

void esrg_Enable_Interrupt(uint32_t ID, uint32_t CPUID, uint32_t Priority);
void esrg_Disable_Interrupt(uint32_t irq_id, uint32_t cpu_id);
void esrg_Register_IRS(uint32_t ID, esrg_IRQ_Handler_Ptr ISR_Function);
void esrg_Default_ISR(void);
void esrg_Interrupt_Handler(void);
#endif
// EOF

