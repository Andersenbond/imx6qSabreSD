/*
** Copyright (C) ARM Limited, 2011-2015. All rights reserved.
*/

/* Simple polled UART driver for Cortex-A9 VE FVP model */

// Ensure uart_init() is called before any other functions in this file.

#define UART0_BASE 0x1C090000
#define UART0_IO  (volatile unsigned char *)(UART0_BASE)
#define UART0_LSR (volatile unsigned char *)(UART0_BASE + 0x3)
#define UART0_FR  (volatile unsigned int *) (UART0_BASE + 0x18)
#define UART0_CR  (volatile unsigned int *) (UART0_BASE + 0x30)


void uart_init(void)
{
	*UART0_CR = *UART0_CR | 0x301;	// Enable UART and enable TX/RX
}

void uart_putc_polled(char c){
	while (*UART0_FR & 0x08);	// Wait for UART TX to become free. Note that FIFOs are not being used here
	*UART0_IO = c;
}

char uart_getchar_polled(void){
	while (*UART0_FR & 0x08);	// Retrieve characters from UART0
	return *UART0_IO;
}


void esrg_UartPrint(char* string){
	while(*string != '#')
		uart_putc_polled(*string);
}

void esrg_UartPrintln(char* string){
	while(*string != '#'){
		uart_putc_polled(*string);
		string++;
	}
	uart_putc_polled('\n');
}