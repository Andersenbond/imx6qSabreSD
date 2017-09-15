 
/*		Entry File for the board IMX6 Quad Sabre SD   */


/*////////////////////////////////////////////////////////////////////////////////
// Company: UMINHO - ESRG
// Engineer: Ailton Lopes
// 
// Create Date: 15.09.2017 07:12:00
// Project Name: MyLinkerScript
// Target Devices: i.MX6 Quad Sabre SD
// Description: Multicore Hello World project, using all 4 cores to 
//              print the hello World message on the terminal. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
/////////////////////////////////////////////////////////////////////////////////*/




/* --- Standard definitions of mode bits and interrupt (I & F) flags in PSRs */

    .equ    Mode_USR,     0x10
    .equ    Mode_FIQ,     0x11
    .equ    Mode_IRQ,     0x12
    .equ    Mode_SVC,     0x13
    .equ    Mode_ABT,     0x17
    .equ    Mode_UND,     0x1B

/* available on ARM Arch 4 and later */
    .equ    Mode_SYS,     0x1F 
	.equ 	Mode_MON,     0x16 

/* when I bit is set, IRQ is disabled */	
    .equ    I_BIT,      0x80 
/* when F bit is set, FIQ is disabled */	
    .equ    F_BIT,      0x40 
    .equ 	IF_bits,	0xC0 

	.equ    Mode_USR_NOINTR,     (0x10 | I_BIT | F_BIT)
    .equ    Mode_UND_NOINTR,     (0x1B | I_BIT | F_BIT)	
	.equ    Mode_ABT_NOINTR,     (0x17 | I_BIT | F_BIT)	
	

	.equ 	EXCEPTION_STACK_SIZE, 1024	

	.equ AIPS_TZ1_BASE_ADDR,	0x02000000
	.equ AIPS1_OFF_BASE_ADDR,	(AIPS_TZ1_BASE_ADDR+0x80000) 
	.equ SRC_BASE_ADDR,  		(AIPS1_OFF_BASE_ADDR+0x58000)
	.equ SRC_GPR1_OFFSET,	0x020
	.equ SRC_GPR2_OFFSET,	0x024
	.equ SRC_SCR_OFFSET, 0x0
	
/* L2 Cache controller defines*/    
    .equ    L2CC_REG1_CTRL, 0x00A02100
    .equ    L2CC_INV_REG,   0x00A0277c
    .equ    L2CC_TAG_R_CTRL,    0x00A02108
    .equ    L2CC_DAT_R_CTRL,    0x00A0210C
    .equ    L2CC_PREFETCH_CTRL, 0x00A02F60

    .equ    VFP_NEON_ENABLE, (1 << 30)
    .equ    VFP_DN_ENABLE, (1 << 24)
    .equ    VFP_FZ_ENABLE, (1 << 25)
    .equ    VFP_RUN_FAST, (VFP_DN_ENABLE | VFP_FZ_ENABLE)

    .equ    ARM_CACR_FULL, 0x3

/* --- VFP uses coproc 10 for single-precision instructions */
    .equ    ARM_VFP_SP_COP, 10
    .equ    ARM_VFP_SP_ACCESS, (ARM_CACR_FULL << (ARM_VFP_SP_COP*2))

/* --- VFP uses coproc 11 for double-precision instructions */
    .equ    ARM_VFP_DP_COP, 11
    .equ    ARM_VFP_DP_ACCESS, (ARM_CACR_FULL << (ARM_VFP_DP_COP*2))

/* --- Configure coprocessor access control */
    .equ    ARM_CACR_CONFIG, (ARM_VFP_SP_ACCESS | ARM_VFP_DP_ACCESS)    

/* --- defines for FIL validation code */
    .equ    strongly_ordered,	 0x00010c02      /* strongly ordered (NCNB) */
    .equ    outer_inner_WB_WA,	0x00001c0e       /* Outer and inner write-back with write allocate */
    .equ    outer_inner_WT,	0x00000c0a      /* Outer and inner write-through, no write allocate */
    .equ    outer_inner_WT_S, 	0x00010c0a      /* Outer and inner write-through, no write allocate, shared */
    .equ    device_shared,	0x00010c06      /* Shared Device */
    .equ    device_nshared,	0x00002c02      /* Non-shared Device */
    .equ    noncacheable, 	0x00001c02      /* Outer and inner non-cacheable */
    
	
	
	
	
/*/////////////////////////////////////////////////////////////////*/
/*/////////////////////////////////////////////////////////////////*/

.global _start
_start:
	b Reset_Handler
	/*.org 0x400*/
	b .
	b .
	b .
	b .
	b .
	b .

/*/////////////////////////////////////////////////////////////////*/
/*/////////////////////////////////////////////////////////////////*/
.global Reset_Handler	
Reset_Handler:
    /* save r0 for cores 1-3, r0 arg field passed by ROM
     r0 is a function pointer for secondary cpus */
    mov 	r4, r0

    /* clear some registers */
    mov     r11,#0
    mov     r12,#0
    mov     lr, #0
    
    ldr		r0, =STACK_ADDR          /* symbol defined in linker file */
    mov		r1, #EXCEPTION_STACK_SIZE

    /* get cpu id, and subtract the offset from the stacks base address */
    mrc     p15,0,r2,c0,c0,5  			/* read multiprocessor affinity register */
    and     r2, r2, #3        			/* mask off, leaving CPU ID field */
    mov     r5, r2		      			/* save cpu id for later */
    
    mul     r3, r2, r1
    sub     r0, r0, r3
  
    mov     r1, r1, lsl #2
           
    /* set stacks for all other modes */
    msr     CPSR_c, #Mode_FIQ | IF_bits
    mov     sp, r0
    sub     r0, r0, r1 
    
    msr     CPSR_c, #Mode_IRQ | I_BIT | F_BIT
    mov     sp, r0
    sub     r0, r0, r1 
    
    msr     CPSR_c, #Mode_ABT_NOINTR 
    mov     sp, r0
    sub     r0, r0, r1 
    
    msr     CPSR_c, #Mode_UND_NOINTR
    mov     sp, r0
    sub     r0, r0, r1 
    
    msr     CPSR_c, #Mode_SYS | I_BIT | F_BIT
    mov     sp, r0
    sub     r0, r0, r1 
    
    /* Set SVC mode stack with interrupts disabled  */
    msr     CPSR_c, #Mode_SVC | I_BIT | F_BIT
    mov     sp, r0
    sub     r0, r0, r1 
 
   	/* init .bss */
    /* clear the .bss section (zero init) */
    ldr     r1,=__bss_start__
    ldr     r2,=__bss_end__
    mov     r3,#0
1:  cmp     r1,r2
    stmltia r1!,{r3}
    blt     1b

   /* check cpu id - cpu0 is primary cpu */
    cmp     r5, #0
    beq     primary_cpu_init

    bx      r4     		/* for secondary cpus, jump to argument function pointer passed in by ROM */
    
    /* control should not return from the secondary cpu entry point */
    b       startup_exit	

    /* if either main() or the secondary cpu entry point return, which they should not, */
    /* then call _sys_exit() */
startup_exit:
        b       startup_exit

primary_cpu_init:	
    
	/*bl Disable_MMU_L1cache   
      bl Flush_cache   
      bl Page_Table_setup  
      bl Enable_MMU_L1cache */      /* comment to keep L1 disabled, uncomment to enable */
    /*bl Enable_L2_cache */         /* enable L2 */

/*    bl Disable_L2_cache  /*  comment this out only when you don't want to enable L2 cache, which is enabled at reset */
/*    bl Disable_D_cache  /*   comment this out only when you want to disable D cache */



.END

