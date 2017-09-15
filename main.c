#include "stdio.h"
#include "uart.h"
#include "regsiomuxc.h"
#include "aux.h"
#define TOTAL_CORES 4

#define AIPS1_ARB_BASE_ADDR     0x02000000
#define AIPS1_ARB_END_ADDR      0x020FFFFF
#define AIPS2_ARB_BASE_ADDR     0x02100000
#define AIPS2_ARB_END_ADDR      0x021FFFFF

#define AIPS_TZ1_BASE_ADDR		AIPS1_ARB_BASE_ADDR
#define AIPS_TZ2_BASE_ADDR		AIPS2_ARB_BASE_ADDR

#define AIPS1_ON_BASE_ADDR		(AIPS_TZ1_BASE_ADDR+0x7C000)
#define AIPS1_OFF_BASE_ADDR		(AIPS_TZ1_BASE_ADDR+0x80000)
#define GPIO1_BASE_ADDR			(AIPS1_OFF_BASE_ADDR+0x1C000)
#define IOMUXC_BASE_ADDR		(AIPS1_OFF_BASE_ADDR+0x60000)
#define IOMUXC_BASE     		(AIPS1_OFF_BASE_ADDR+0x60000)
#define CCM_BASE_ADDR			(AIPS1_OFF_BASE_ADDR+0x44000)

#define reg_32_CSU_SA (*(volatile U32*)(0x021C0218))
#define NSA_CP15 1

#define	AIPS1_OFF_BASE_ADDR	(AIPS_TZ1_BASE_ADDR+0x80000) 
#define	SRC_BASE_ADDR  		(AIPS1_OFF_BASE_ADDR+0x58000)
#define SRC_GPR1_OFFSET		0x020
#define	SRC_GPR2_OFFSET	0x024
#define	SRC_SCR_OFFSET 0x0


#define R32   (volatile unsigned long *)
#define R16   (volatile unsigned short *)
#define R8    (volatile unsigned char *)

typedef unsigned long  U32;
typedef unsigned short U16;
typedef unsigned char  U8;


#define BIT13 0x02000


#define reg32_UART1_USR1 (*(volatile U32*)(0x02020094))  
#define reg32_UART1_UTXD (*(volatile U32*)(0x02020040))


#define WAIT_P 0x500000

extern void  Reset_Handler() ;

void pause (int period)
{

  while (period--) ;
}

void outbyte (char c)
{
    while ( !(reg32_UART1_USR1 & BIT13)  );
    reg32_UART1_UTXD = c ;
}


void UART1_init(void)
{
	int tmp;

	//*********** UART1 IOMUX
//	* R32 (IOMUXC_BASE_ADDR+0x280) = 0x00000003; 		// ALT3 CSI0_DAT10     TxD
//	* R32 (IOMUXC_BASE_ADDR+0x284) = 0x00000003; 		// ALT3 CSI0_DAT11    RxD
//	* R32 (IOMUXC_BASE_ADDR+0x920) = 0x00000001; 		//UART1_UART_RX_DATA_SELECT_INPUT
 
    HW_IOMUXC_SW_MUX_CTL_PAD_CSI0_DATA11_SET(0x03UL); 
    HW_IOMUXC_SW_MUX_CTL_PAD_CSI0_DATA11_CLR(0x04UL); 
    HW_IOMUXC_UART1_UART_RX_DATA_SELECT_INPUT_WR(0x01UL); 
    HW_IOMUXC_SW_MUX_CTL_PAD_CSI0_DATA10_SET(0x03UL); 
    HW_IOMUXC_SW_MUX_CTL_PAD_CSI0_DATA10_CLR(0x04UL); 
	
	
	tmp=(* R32 (CCM_BASE_ADDR+0x24)) & 0x0000003F ; 	//CSCDR1  uart_podf div by 1
	* R32 (CCM_BASE_ADDR+0x24) = tmp;               			// UART refclk = 80MHz

	// Enable UART1
	//   printf("enable uart1, ignore RTS, wordsize 8bits, 1 stop bit, no parity\n");
	// enable uart1, ignore RTS, wordsize 8bits, 1 stop bit, no parity
	*(unsigned int*)(UART1_UCR2_1) = 0x01;             // reset UART state machines 
	*(unsigned int*)(UART1_UCR2_1) = 0x2006;			// UCR2 = CTSC,TXEN,RXEN=1,reset
	*(unsigned int*)(UART1_UCR1_1) = 0x0001; 			// UARTEN = 1,enable the clock
	*(unsigned int*)(UART1_UCR2_1) |= IGNORE_RTS<<14;	// configure IRTS bit
	*(unsigned int*)(UART1_UCR2_1) |= WORD8<<5;
	*(unsigned int*)(UART1_UCR2_1) |= STOP1<<6;
	*(unsigned int*)(UART1_UCR3_1) |= 0x00000004;		// set RXD_MUX_SEL bit
	*(unsigned int*)(UART1_UCR1_1) |= 0x0201;          // recieve ready interput enable 
	
		// disable parity
	*(unsigned int*)(UART1_UCR2_1) &= ~(0x00000100);			
	
	// BAUDRATE_115_2Kbps_UART1 // 115.2 Kbps @ 66 MHz

    //SetRFDIV_to_div_by_1_UART1();	
	tmp = *(unsigned int*)(UART1_UFCR_1);	// save UFCR to default value
	*(unsigned int*)(UART1_UFCR_1) = 5<<7;   // set RFDIV to div-by-1 or b101 
	*(unsigned int*)(UART1_UFCR_1) |= tmp;	// set other UFCR bits back to default			

	*(unsigned int*)(UART1_UBIR_1) = 0x4;
	*(unsigned int*)(UART1_UBMR_1) = 0xD8;
/*	
	// enable uart1 interrupts
	*(unsigned int*)(AVIC_INTENNUM) = 45;
	
	vect_IRQ[45] = UART1_ISR;	
*/	
	
	//vect_IRQ[UART1_NUM] = UART1_ISR;
	//*(p_uint32_t)(TZIC_BASE_ADDR + TZIC_INTSEC0_OFFSET)=0x80000000;
}

void start_secondary_cpu(int cpu_num, unsigned int *ptr)
{
	U32 tmp ;
	
	/* prepare pointers for ROM code */	
	(*(volatile U32*)(SRC_BASE_ADDR + (SRC_GPR1_OFFSET + cpu_num*8))) = (U32)&(Reset_Handler) ;
	(*(volatile U32*)(SRC_BASE_ADDR + (SRC_GPR2_OFFSET + cpu_num*8))) = (U32)ptr ;
	/* start core */
	if (cpu_num > 0)
	{
	  tmp = (*(volatile U32*)(SRC_BASE_ADDR + SRC_SCR_OFFSET)) | (1 << (21 + cpu_num)) ;
 	  (*(volatile U32*)(SRC_BASE_ADDR + SRC_SCR_OFFSET)) = tmp ;
	}
}

int getCPUnum(void)
{
  register rd asm("r0"); 
 
   asm (
        "mrc     p15,0,r0,c0,c0,5 \n\t"  /* read multiprocessor affinity register */
        "and     r0, r0, #3 \n\t"        /* mask off, leaving CPU ID field */
/*        "mov     r0, r2 \n\t"	  */
       ) ;
	return (rd) ;
}


int main()
{
 int cpu_id ;
	
  cpu_id = getCPUnum();

   if (cpu_id == 0)
   {  
     UART1_init() ;
     outbyte('F');
	 //IOMUXC control for KEY_ROW_6 (ALT5): GPIO1_2

     //*R32(IOMUXC_BASE_ADDR + 0x234) = 0x00000005;

    HW_IOMUXC_SW_MUX_CTL_PAD_GPIO02_SET(0x05UL); 
    HW_IOMUXC_SW_MUX_CTL_PAD_GPIO02_CLR(0x02UL); 
	
	//Write to DIR register [DIR]

	*R32(GPIO1_BASE_ADDR+4) = 0x00000004;  		// 1 : GPIO 1_2  - output
   }
   
   if (( cpu_id > (TOTAL_CORES-1)) || ( cpu_id < 0 )) 
    // printf("\n\r Error - no CPU %d\n\r", cpu_id);
	mxc_serial_putc('!');
    else
    //printf("\n\r Hello from CPU %d\n\r", cpu_id);
	mxc_serial_putc(49+cpu_id);
   if (cpu_id < (TOTAL_CORES-1))
   {  				//start the next core
		start_secondary_cpu(cpu_id+1, (unsigned int *)&(main));
   }
	
   if (cpu_id != 0) { while (1) ; }

	
	while (1)  
	 { 
	    outbyte('*') ;
		pause (WAIT_P) ; 

		*R32 (GPIO1_BASE_ADDR) = 0x00000004;  // 1 --> GPIO 1_2 
    

		outbyte('-') ;
		pause (WAIT_P) ; 
    	*R32 ( GPIO1_BASE_ADDR) = 0  ;  // 0 --> GPIO 1_2
	
		
	};
	
	return (0) ;
}

