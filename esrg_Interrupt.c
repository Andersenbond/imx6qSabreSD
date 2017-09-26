#include "esrg_Interrupt.h"
#include "MP_GIC.h"


esrg_IRQ_Handler_Ptr esrg_ISR_Vector[NUM_INTERRUPT_IMX6Q];
volatile uint32_t g_vectNum[NUM_CORE_IMX6Q];


// Timer Interrupt Handler
//__attribute__ ((interrupt("IRQ")))
	void esrg_Interrupt_Handler(void) {
    // send ack and get ID source 
    uint32_t Temp = readIntAck();
    
    // Check that INT_ID isn't 1023 or 1022 (spurious interrupt) 
    if (Temp & 0x0200)
        writeEOI(Temp);  // send end of irq 
    else{
        // copy the local value to the global image of CPUID
        unsigned cpu_ID = (Temp >> 10) & 0x7;
        unsigned irq_ID = Temp & 0x1FF;
        
        // Store the current interrupt number.
        g_vectNum[cpu_ID] = irq_ID;
        
        // Call the service routine stored in the handlers array. If there isn't
        // one for this IRQ, then call the default handler.
        esrg_IRQ_Handler_Ptr Temp_isr = esrg_ISR_Vector[irq_ID];
        if (Temp_isr)
            Temp_isr();
        else
            esrg_Default_ISR();
		
        // Clear current interrupt number.
        g_vectNum[cpu_ID] = 0;
        
        // Signal the end of the irq.
        writeEOI(Temp);
    }
}




void esrg_Disable_Interrupt(uint32_t ID, uint32_t CPU_ID){
    disableIntID(ID);
}

void esrg_Enable_Interrupt(uint32_t ID, uint32_t CPU_ID, uint32_t Priority){
    setIntPriority(ID, Priority);
    makeIntNonSecure(ID); 
    setIntTarget(ID, CPU_ID);
    enableIntID(ID);
}

 void esrg_Register_IRS(uint32_t ID, esrg_IRQ_Handler_Ptr Temp_isr){
    esrg_ISR_Vector[ID] = Temp_isr;
}

void esrg_Default_ISR(void){
    // find a way to address an IRQ handled by another CPU. Assumes
    // here that CPU_0 is used.
    //printf("Interrupt %d has been asserted\n", g_vectNum[0]);
}

