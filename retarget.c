/*
** Copyright (C) ARM Limited, 2006-2016. All rights reserved.
*/

/*
** This file contains re-implementations of functions whose
** C library implementations rely on semihosting.
**
** Define USE_SERIAL_PORT to retarget the I/O only to the serial port.
** Otherwise, I/O is targeted to the debugger console using semihosting.
**
** Define STANDALONE to eliminate all use of semihosting-using functions too.
*/


/*
** Build with STANDALONE to include this symbol.
*/

#ifdef STANDALONE
#define USE_SERIAL_PORT
#endif


/*
** Retargeted I/O
** ==============
** The following C library functions make use of semihosting
** to read or write characters to the debugger console: fputc(),
** fgetc(), and _ttywrch().  They must be retargeted to write to
** the model's UART.
*/

#ifdef USE_SERIAL_PORT

extern void uart_putc_polled(char c);
extern char uart_getchar_polled(void);


int _write (int fd, char *ptr, int len)
{
  /* Write "len" of char from "ptr" to file id "fd"
   * Return number of char written.
   * Need implementing with UART here. */
    unsigned int loop;
    unsigned char ch;
    for (loop=len; loop>0; loop--)
    {
        ch = *ptr++;
        if (ch == '\n') uart_putc_polled('\r');
        uart_putc_polled(ch);
    }
    return len;
}


#endif  // USE_SERIAL_PORT
