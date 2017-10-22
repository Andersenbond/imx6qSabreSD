CROSS_PREFIX=arm-none-eabi-
#export PATH=$PATH:/home/andersenbond/Desktop/IMX6QSD/Toolchain/bin/
AS = $(CROSS_PREFIX)as
CC = $(CROSS_PREFIX)gcc
LD = $(CROSS_PREFIX)ld
OBJCOPY = $(CROSS_PREFIX)objcopy
OBJDUMP = $(CROSS_PREFIX)objdump
MKIMAGE = /home/andersenbond/Desktop/IMX6QSD/u-boot-fslc-2017.07-fslc/tools/mkimage
#MKIMAGE = mkimage

#CFLAGS = -Wall -O0 -nostdlib -nostartfiles -ffreestanding -mfpu=neon -march=armv7-a
CFLAGS = -mcpu=cortex-a9 -mfloat-abi=hard -mfpu=neon -g -mthumb -O1 -DSTANDALONE

ASFLAGS = -Wall -mfpu=neon -march=armv7-a 
LDFLAGS = -L . -lgcc -Map=linkmap.txt
#LDFLAGS = 

OBJS = \
	startup.o \
	v7.o \
	MP_GIC.o \
	MP_SCU.o \
	MP_Mutexes.o \
	timer_interrupts.o \
	main.o \
	uart.o \
    mxc_serial.o \
	esrg_Interrupt.o 
	

all : kernel.img

startup.o : startup.S
	$(AS) startup.S -o startup.o

v7.o : v7.S
	$(AS) v7.S -o v7.o

MP_GIC.o : MP_GIC.S
	$(AS) MP_GIC.S -o MP_GIC.o
	
MP_SCU.o : MP_SCU.S
	$(AS) MP_SCU.S -o MP_SCU.o

MP_Mutexes.o : MP_Mutexes.S
	$(AS) MP_Mutexes.S -o MP_Mutexes.o


esrg_Interrupt.o : esrg_Interrupt.c 
	$(CC) $(CFLAGS) -c esrg_Interrupt.c -o esrg_Interrupt.o

timer_interrupts.o : timer_interrupts.c 
	$(CC) $(CFLAGS) -c timer_interrupts.c -o timer_interrupts.o

mxc_serial.o : mxc_serial.c
	$(CC) $(CFLAGS) -c mxc_serial.c -o mxc_serial.o

uart.o : uart.c 
	$(CC) $(CFLAGS) -c uart.c -o uart.o

main.o : main.c 
	$(CC) $(CFLAGS) -c main.c -o main.o

kernel.img : gcc.ld $(OBJS)
	$(LD) $(OBJS) -T gcc.ld -o kernel.elf $(LDFLAGS)
	$(LD) $(OBJS) -T gcc.ld -o kernel.axf $(LDFLAGS)
	$(OBJDUMP) -D kernel.elf > kernel.asm
	$(OBJCOPY) kernel.elf -O binary kernel.img
	$(MKIMAGE) -n imximage.cfg -T imximage -e 0x17800000 -d kernel.img kernel.imx

#kernel.axf : gcc.ld $(OBJS) 
#    $(CC) $(ax) $(LDFLAGS) -o kernel.axf $(OBJS)
	
	
clean :
	rm -f *.o *.elf *.asm *.img *.imx 

#Sent_Image_SD:
#sudo dd if=kernel.imx of=/dev/mmcblk0 bs=512 seek=2

