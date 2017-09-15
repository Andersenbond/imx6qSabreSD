/*
 * Copyright (C) 2012, Freescale Semiconductor, Inc. All Rights Reserved
 * THIS SOURCE CODE IS CONFIDENTIAL AND PROPRIETARY AND MAY NOT
 * BE USED OR DISTRIBUTED WITHOUT THE WRITTEN PERMISSION OF
 * Freescale Semiconductor, Inc.
*/

/*********************************************************
/** WARNING: This code comes with no guarantees or warranties
/**
/** This is an internal Freescale test tool under debug and 
/** development 
/**
/** It was tested on internal Freescale development boards but may 
/** not  work on other customer or third party boards
/**
/** This code comes as is with no support.
/**
/** USE AT YOUR OWN RISK! 
/**
/** Freescale is absolved or any legal or support obligations for those 
/** who ignore this warning
/*********************************************************


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

/*   */

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

/* --- VFP uses coproc 10 for single-precision instructions*/
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
    
/*
  * MX6DQ OCRAM (aka IRAM): 0x00900000 to 0x00940000 (256KB)
  * Start page table at 0x0094000000 - 0x4000 (16KB) = 0x0093C000
  * MX6DL and MX6SL OCRAM (aka IRAM): 0x00900000 to 0x00920000 (128KB)
  * Start page table at 0x0094000000 - 0x4000 (16KB) = 0x0091C000
*/


/*    __mmu_page_table_base__ defined in target linker file (.ld) */
/*    0x0091C000 @ MX6DL, MX6SL   								  */ 	
/*    .equ    PAGE_TABLE_ADDR,    0x0093C000 @ MX6DQ              */
    .equ    PAGE_TABLE_ADDR, __mmu_page_table_base__

    .section .vectors, "ax"

    .global Reset_Handler
	.fpu neon
    .text
    .code 32

    b Reset_Handler
    .org 0x400
	
ivt_header :            .long   0x402000D1
app_code_jump_vector :  .long   Reset_Handler
                        .long   0
dcd_ptr :               .long   0
boot_data_ptr :         .long   boot_data
self_ptr :              .long   ivt_header
                        .long   0
                        .long   0
boot_data :             .long   0x00920000 /* for DQ */
image_len :             .long   0x18000    /* 96 KB  app size */
plugin    :             .long   0


Reset_Handler:
    /* save r0 for cores 1-3, r0 arg field passed by ROM
     r0 is a function pointer for secondary cpus */
    mov 	r4, r0

    /* clear some registers */
    mov     r11,#0
    mov     r12,#0
    mov     lr,#0
    
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

    bl Disable_MMU_L1cache   
    bl Flush_cache   
    bl Page_Table_setup  
    bl Enable_MMU_L1cache       /* comment to keep L1 disabled, uncomment to enable */
    bl Enable_L2_cache          /* enable L2 */

/*    bl Disable_L2_cache  /*  comment this out only when you don't want to enable L2 cache, which is enabled at reset */
/*    bl Disable_D_cache  /*   comment this out only when you want to disable D cache */


/* Enable NEON  */

/* --- enable NEON VFP */
    ldr     r0, =ARM_CACR_CONFIG                /* ; r0 = CACR configuration */
    mcr     p15, 0, r0, c1, c0, 2               /* ; update CACR */ 
    isb       

/* --- Enable VFP */
    fmrx     r0, fpexc
    orr      r0, r0, #VFP_NEON_ENABLE
    fmxr     fpexc, r0

/* --- Set VFP to runfast mode */
    fmrx     r0, fpscr
    orr      r0, r0, #VFP_RUN_FAST
    fmxr     fpscr, r0

	ldr r0, =0x0207C000  /* AIPS1_ON_BASE_ADDR (0x02000000) */
	ldr r1, =0x77777777 
	str r1, [r0, #0x0] 
	str r1, [r0, #0x4]
	ldr r1, =0x0
	str r1, [r0, #0x40]
	str r1, [r0, #0x44]
	str r1, [r0, #0x48]
	str r1, [r0, #0x4C]
	str r1, [r0, #0x50] 
	
	ldr r0, =0x0217C000  /* AIPS2_ON_BASE_ADDR (0x02100000) */
	ldr r1, =0x77777777
	str r1, [r0, #0x0]
	str r1, [r0, #0x4]
	ldr r1, =0x0
	str r1, [r0, #0x40]
	str r1, [r0, #0x44]
	str r1, [r0, #0x48]
	str r1, [r0, #0x4C]
	str r1, [r0, #0x50] 
	
/* Restore the default values in the Gate registers */

	ldr r0, =0x020C4068  /* CCGR0 */
	ldr r1, =0xFFFFFFFF
	str r1, [r0, #0]
	ldr r0, =0x020C406C  /* CCGR1 */
	str r1, [r0, #0]
	ldr r0, =0x020C4070  /*  CCGR2 */
	str r1, [r0, #0]
	ldr r0, =0x020C4074  /* CCGR3 */
	str r1, [r0, #0]
	ldr r0, =0x020C4078  /* CCGR4 */
	str r1, [r0, #0]
	ldr r0, =0x020C407C  /* CCGR5 */
	str r1, [r0, #0]
	ldr r0, =0x020C4080  /* CCGR6 */
	str r1, [r0, #0]


/* Branch to C Library entry point */

    LDR     r12,=main               /* save this in register for possible long jump */

    BX      r12                         /* branch to __main */



Page_Table_setup:
/*  Cortex-A9 supports two translation tables */
/*  Configure translation table base (TTB) control register cp15,c2 */
/*  to a value of all zeros, indicates we are using TTB register 0. */

/* From ARM examples */
/*        ; Specify v6 format pagetables with no subpages */
/*        ; set bit 23 [XP] in CP15 control register. */

    MRC     p15,0,r0,c1,c0,0
    MOV     r1, #0x800000
    ORR     r0,r0,r1
    MCR     p15,0,r0,c1,c0,0

/*        ; Cortex-A9 supports two translation tables */
/*        ; Configure translation table base (TTB) control register cp15,c2 */
/*        ; to a value of all zeros, indicates we are using TTB register 0. */

    MOV     r0,#0x0
    MCR     p15, 0, r0, c2, c0, 2

/*PAGE_TABLE_PROGRAMMING */
    mov    r0,#0
    mcr     p15,0,r0,c8,c7,0   /*  CORTEX-A9 TLB invalidate Inst TLB & Data TLB*/

/*===================================================================================*/
/*      STORE PAGE TABLE AT RAM.                                                                                                                                           */
/*===================================================================================*/
    ldr     r7, =PAGE_TABLE_ADDR    /*  load Translation Table Base Reg 0 with address of TTB table */
/*    orr     r7, r7, #(0x18)             /* Set TTBR0 RGN bits to Normal memory, Outer Write-Back no Write-Allocate Cacheable.  */
/*    orr     r7, r7, #(0x41)              /* Set TTBR0 IRGN bits to Normal memory, Inner Write-Back no Write-Allocate Cacheable */
    orr     r7, r7, #(0x08)             /* Set TTBR0 RGN bits to Normal memory, Outer Write-Back no Write-Allocate Cacheable.  */
    orr     r7, r7, #(0x40)              /* Set TTBR0 IRGN bits to Normal memory, Inner Write-Back no Write-Allocate Cacheable */
    
    mcr     p15,0,r7,c2,c0,0

    ldr     r0,=0x55555555          /*  Load Domain Access Control Reg, setup all domains as client 0x01 */
    mcr     p15,0x0,r0,c3,c0,0x0

    ldr     r7, =PAGE_TABLE_ADDR     /* initialize r7 with translation table base address as other control may have been set above */
/*===================================================================================*/
    /* *Peripheral region 1 (ROM, misc peripherals) 0x00000000 to 0x00900000*/
    ldr r1, =0x0000    /* start of desired memory location */
    ldr r3, =0x0024    /* end of desired memory region */
    ldr r2, =0x00002c02    /* Peripheral 1 region  */
countloop1:
    add r8,r7,r1            /* Add r7 + Delta */
    str r2, [r8]
    add r1, r1, #4
    add r2, r2, #0x100000
    cmp r1, r3
    bne countloop1
/*===================================================================================*/
    /* OCRAM 0x00900000 to 0x00940000, but can only tag 1MB minimum, so end addr: 0x00A00000 */
    ldr r1, =0x0024
    add r8,r7,r1            /* Add r7 + Delta */
    ldr r2, =0x0090040E     /* OCRAM 0x00900000 */
/*    ldr r2, =0x0090040A     /* OCRAM 0x00900000 */
/*    ldr r2, =0x00902c02    /* OCRAM 0x00900000 */
    str r2, [r8]
/*===================================================================================*/
    /* Peripheral region 2 (ARM peripherals, other peripherals) 0x00A00000 to 0x10000000 */
    ldr r1, =0x0028    /* start of desired memory location */
    ldr r3, =0x0400    /* end of desired memory region */
    ldr r2, =0x00A02c02    /* Peripheral 2 region  */
countloop2:
    add r8,r7,r1            /* Add r7 + Delta */
    str r2, [r8]
    add r1, r1, #4
    add r2, r2, #0x100000
    cmp r1, r3
    bne countloop2
/*===================================================================================*/
    /*MMDC 0x10000000 to 0xFFFFFFFF */
    /*CLEAR MMDC region of the MMU page table; this will be configured at run time depending on the board DRAM density */ 
    
    ldr r1, =0x400    /* start of desired memory region */
    ldr r3, =0x4000    /* end of desired memory region, also end of memory map for 32-bit address */

    ldr r2, = 0x0

countloop3:
    add r8, r7, r1
    str r2, [r8]
    add r1, r1, #4
    cmp r1, r3
    bne countloop3

    /* previous version of code, which set up page table */
    /* keep for legacy reference  */
    /* Enable this for outer and inner write-back, no write allocate [DEFAULT] */
/*    ldr r2, =0x1000040E    / MMDC           / 1000_0000 - FFFF_FFFF */
/* other page table options */
    /* NCNB non-cacheable, non-bufferable */
/*    ldr r2, =0x10002c02    / MMDC           / 1000_0000 - FFFF_FFFF */
    /* Enable this for outer and inner write-back, write allocate */
/*    ldr r2, =0x1000140E    / MMDC           / 1000_0000 - FFFF_FFFF */
/*    ldr r2, =0x10001C0E    /* MMDC           / 1000_0000 - FFFF_FFFF */
    /* Enable this for outer and inner write-THROUGH, no write allocate */
/*    ldr r2, =0x1000040A    / MMDC           / 1000_0000 - FFFF_FFFF */
    /* Enable this for L2 cachable, L1 cachable - should be the same as 0x40E */
/*    ldr r2, =0x1000740E    / MMDC           / 1000_0000 - FFFF_FFFF */
    /* Enable this for L2 noncacheable, L1 cachable */
/*    ldr r2, =0x1000440E    / MMDC           / 1000_0000 - FFFF_FFFF */
    /* Enable this for L2 cachable, L1 noncachable */
/*    ldr r2, =0x10007402    / MMDC           / 1000_0000 - FFFF_FFFF */

/*countloop3:
@    add r8, r7, r1
@    str r2, [r8]
@    add r1, r1, #4
@    add r2, r2, #0x100000 
@    cmp r1, r3
@    bne countloop3
/*===================================================================================*/

    mov r0, #0
    mcr p15, 0, r0, c8, c7, 0  /* ; invalidate icache and data TLBs */
  
    bx lr

Enable_MMU_L1cache: 
    mrc     p15, 0, r0, c1, c0, 0    /* read CP15 register 1 into r0 */
    orr     r0, r0, #(0x1  <<12)   /* enable I Cache */
    orr     r0, r0, #(0x1  <<11)   /*   turn on BP */
    orr     r0, r0, #(0x1  <<2)     /*  enable D Cache */
    orr     r0, r0, #(0x1  <<0)     /*  enable MMU */
    mcr     p15, 0, r0, c1, c0, 0    /* write CP15 register 1 */
    bx lr

Disable_MMU_L1cache:
    mrc     p15, 0, r0, c1, c0, 0    /* read CP15 register 1 into r0 */
    bic     r0, r0, #(0x1  <<12)     /* disable I Cache */
    bic     r0, r0, #(0x1  <<2)      /* disable D Cache */
    bic     r0, r0, #(0x1  <<0)      /* disable MMU */
    mcr     p15, 0, r0, c1, c0, 0    /* write CP15 register 1 */

    /* disable L2 cache */
    ldr r0, =L2CC_REG1_CTRL   /* L2 control register */
    ldr r1, =0x00000000    /* disable */
    str r1, [r0] 
/*    nop */
/*    nop */
/*    nop */
    
    bx lr

Disable_D_cache:
    mrc     p15, 0, r0, c1, c0, 0    /* read CP15 register 1 into r0 */
    bic     r0, r0, #(0x1  <<2)      /* disable D Cache */
    mcr     p15, 0, r0, c1, c0, 0    /* write CP15 register 1 */
    bx lr

Enable_L2_cache:
    /*; set latency: 4x cycles read, 2x cycles write, (3x cycles setup) */
    ldr     r1,= L2CC_TAG_R_CTRL
    ldr     r0,=0x0132  
    str     r0,[r1]
    ldr     r1, =L2CC_DAT_R_CTRL
    ldr     r0,=0x0132 
    str     r0,[r1]

    /* ; invalidate by way l2cc */
    ldr     r1, =L2CC_INV_REG
    ldr     r0, =0xffff
    str     r0,[r1]
    /* ; poll cache maintenance register until invalidate operation is complete */
l2_inv_loop:
    ldr     r2,[r1]
    mov     r0,#0x0
    cmp     r2,r0
    bne     l2_inv_loop

/*    ldr     r1, =L2CC_REG1_CTRL */
/*    ldr     r0, [r1, #4]*/
/*    orr     r0, r0, #(0x1  <<20)   */
/*    str     r0, [r1, #4] */

    /* ;enable double line fill */
    ldr     r1, =L2CC_PREFETCH_CTRL
    ldr     r0, =0x40800000
    str     r0, [r1]

    /* ; turn on l2 */
    ldr     r1, =L2CC_REG1_CTRL
    mov     r0,#1
    str     r0,[r1]

    /*; Configure ACTLR */
    
    mrc     p15, 0, r1, c1, c0, 1               /*; r1 = ACTLR */
    orr     r1, r1, #(1 << 0)                   /*; Enable cache/TLB broadcast */
    bic     r1, r1, #(1 << 1)                   /*; Disable L2 prefetch */
    bic     r1, r1, #(1 << 2)                   /*; Disable L1 prefetch */
    mcr     p15, 0, r1, c1, c0, 1               /*; Update ACTLR */
    
    bx lr


Disable_L2_cache:
    /* ;;;;  Turn off L2 Cache  ;;;; */
    ldr r0, =L2CC_REG1_CTRL  /* L2 control register */
    ldr r1, =0x00000000  /* disable */
    str r1, [r0]
    bx lr

Flush_cache:  /* cache flush routine from ARM Architecture Reference Manual */
/*    Save non-volatile registers
/*    stmfd   sp!, {r4-r11}  // comment out since stack pointer not set up yet */

    mov r0, #0
    mcr p15, 0, r0, c7, c5, 0  /* ; invalidate inst cache      */
    mcr p15, 0, r0, c8, c7, 0  /* ; invalidate icache and data TLBs */

    mrc p15, 1, r0, c0, c0, 1             /*@ read clidr*/
    ands r3, r0, #0x7000000            /*@ extract loc from clidr */
    mov r3, r3, lsr #23                    /*@ left align loc bit field*/
    beq finished                              /* finished; */  /*@ if loc is 0, then no need to clean*/
    mov r10, #0                             /*@ start clean at cache level 0*/
loop1: /*loop1: */
    add r2, r10, r10, lsr #1              /*@ work out 3x current cache level*/
    mov r1, r0, lsr r2                      /*@ extract cache type bits from clidr*/
    and r1, r1, #7                          /*@ mask of the bits for current cache only*/
    cmp r1, #2                              /*@ see what cache we have at this level*/
    blt skip                                    /* skip; */   /*@ skip if no cache, or just i-cache*/
    mcr p15, 2, r10, c0, c0, 0         /*@ select current cache level in cssr*/
    mov     r1, #0  /* Wi */    
    isb
    mrc p15, 1, r1, c0, c0, 0          /*@ read the new csidr*/
    and r2, r1, #7                        /*@ extract the length of the cache lines*/
    add r2, r2, #4                        /*@ add 4 (line length offset) */
    ldr r4, =0x3ff
    ands r4, r4, r1, lsr #3             /*@ find maximum number on the way size*/
    clz r5, r4                               /* from the ARM7 architecture manual */
    ldr r7, =0x7fff
    ands r7, r7, r1, lsr #13           /*@ extract max number of the index size*/
loop2: /* loop2: */
    mov r9, r4                             /*@ create working copy of max way size*/
loop3: /* loop3: */
    orr r11, r10, r9, lsl r5             /*@ factor way and cache number into r11*/
    orr r11, r11, r7, lsl r2             /*@ factor index number into r11*/
    mcr p15, 0, r11, c7, c6, 2     /*@ invalidate by set/way */
    subs r9, r9, #1                      /*@ decrement the way */
    bge loop3                             /* loop3; */
    subs r7, r7, #1                     /*@ decrement the index */
    bge loop2                            /* loop2; */
skip: /* skip: */
    add r10, r10, #2                  /*@ increment cache number */
    cmp r3, r10
    bgt loop1                            /*loop1; */
finished: /* finished: */
    dsb

    bx lr
 
/* from BD */
    mov	r0, #0
    mcr	p15, 0, r0, c8, c7, 0	@ invalidate I  D TLBs
    mcr	p15, 0, r0, c2, c0, 2	@ TTB control register

    mov     r0, #0
    mcr     p15, 2, r0, c0, c0, 0
    mrc     p15, 1, r0, c0, c0, 0

    ldr     r1, =0x7fff
    and     r2, r1, r0, lsr #13

    ldr     r1, =0x3ff

    and     r3, r1, r0, lsr #3  @ NumWays - 1
    add     r2, r2, #1          @ NumSets

    and     r0, r0, #0x7
    add     r0, r0, #4          @ SetShift

    clz     r1, r3              @ WayShift
    add     r4, r3, #1          @ NumWays
1:      sub     r2, r2, #1          @ NumSets--
    mov     r3, r4              @ Temp = NumWays
2:      subs    r3, r3, #1          @ Temp--
    mov     r5, r3, lsl r1
    mov     r6, r2, lsl r0
    orr     r5, r5, r6          @ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
    mcr     p15, 0, r5, c7, c6, 2
    bgt     2b
    cmp     r2, #0
    bgt     1b
    dsb
    isb


/*    bx lr */


    .end                       /* mark the end of this file */
	