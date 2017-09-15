/*
 * Copyright (C) 2011, Freescale Semiconductor, Inc. All Rights Reserved
 * THIS SOURCE CODE IS CONFIDENTIAL AND PROPRIETARY AND MAY NOT
 * BE USED OR DISTRIBUTED WITHOUT THE WRITTEN PERMISSION OF
 * Freescale Semiconductor, Inc.
*/

/*********************************************************
** WARNING: This code comes with no guarantees or warranties
**
** This is an internal Freescale test tool under debug and 
** development 
**
** It was tested on internal Freescale development boards but may 
** not  work on other customer or third party boards
**
** This code comes as is with no support.
**
** USE AT YOUR OWN RISK! 
**
** Freescale is absolved or any legal or support obligations for those 
** who ignore this warning
*********************************************************/


/*OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
OUTPUT_ARCH(arm)*/
ENTRY(Reset_Handler)
/* SEARCH_DIR(.) */
/*GROUP(-lgcc -lc -lcs3 -lcs3arm)*/

MEMORY {
    IRAM (rwx) : ORIGIN = 0x00920000, LENGTH = 96K
    IRAM_MMU (rwx): ORIGIN = 0x00938000, LENGTH = 24K
}

PROVIDE(__cs3_heap_start = heap_start);


SECTIONS {
    .reset : {
        *(.vectors)        /* startup code */
        . = ALIGN (4);
    } >IRAM

    .text : {
        *(.text)
 
        . = ALIGN (4);
    } >IRAM
    
    .data : { *(.data) } >IRAM

    .bss : {
        . = ALIGN (4);
        __bss_start__ = .;
        *(.shbss)
        *(.bss .bss.* .gnu.linkonce.b.*)
        *(COMMON)
        __bss_end__ = .;
    } >IRAM

	. = ALIGN (4);
    . += 8;
	PROVIDE(heap_start = .) ;
	
       . += 48K; 
       
    STACK_ADDR = .;
    . = ALIGN (4);
    . += 8;
    free_memory_start = .;

    .mmu_page_table : {
	__mmu_page_table_base__ = .;
	. = ALIGN (16K);
	. += 16K;
    } >IRAM_MMU 

    _end = .;
    __end = _end;
    PROVIDE(end = .);
}

