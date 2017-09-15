*/
*		Linker script for the board IMX6 Quad Sabre SD
*/

/*////////////////////////////////////////////////////////////////////////////////
// Company: UMINHO - ESRG
// Engineer: Ailton Lopes
// 
// Create Date: 15.09.2017 06:41:00
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


/* The ENTRY command especify the first instruction to execute in a program */
ENTRY(_start)


/* describes the location and size of blocks of memory in the target */
MEMORY {
	 IRAM (rwx) : ORIGIN = 0x00920000, LENGTH = 96K
   	 IRAM_MMU (rwx): ORIGIN = 0x00938000, LENGTH = 24K
/*‘R’ Read-only section,‘W’Read/write section,‘X’ Executable section*/
}



/* SECTIONS is used to describe the memory layout of the output file 
* . -> Location Counter
*/
SECTION {
	. = 0x00000000;
	.text : { *(.text) }

	. = ALIGN(4);
	.data : { *(.data) }

	. = ALIGN(4);
	__bss_start__ = .;
	.bss : { *(.bss*) }
	__bss_end__ = .;

	.stack :
	{
		STACK_ADDR = . ;
	}
}
