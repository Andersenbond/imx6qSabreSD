CROSS_PREFIX=arm-none-eabi-
#export PATH=$PATH:/home/andersenbond/Desktop/IMX6QSD/Toolchain/bin/
AS = $(CROSS_PREFIX)as
CC = $(CROSS_PREFIX)gcc
LD = $(CROSS_PREFIX)ld
OBJCOPY = $(CROSS_PREFIX)objcopy
OBJDUMP = $(CROSS_PREFIX)objdump
MKIMAGE = /home/andersenbond/Desktop/IMX6QSD/u-boot-fslc-2017.07-fslc/tools/mkimage
#MKIMAGE = mkimage

CFLAGS = -Wall -O0 -nostdlib -nostartfiles -ffreestanding -mfpu=neon -march=armv7-a
ASFLAGS = -Wall -mfpu=neon -march=armv7-a
#LDFLAGS = -L . -lgcc
LDFLAGS = 

OBJS = \
	main.o \

all : kernel.img

entry.o : init_MMU.S
	$(AS) init_MMU.S -o entry.o

main.o : main.c 
	$(CC) $(CFLAGS) -c main.c -o main.o

#mxc_serial.o : mxc_serial.c
#	$(CC) $(CFLAGS) -c mxc_serial.c -o mxc_serial.o
#MyLinkerScript
kernel.img : mx6dq.ld entry.o $(OBJS)
	$(LD) entry.o $(OBJS) -T mx6dq.ld -o kernel.elf $(LDFLAGS)
	$(OBJDUMP) -D kernel.elf > kernel.asm
	$(OBJCOPY) kernel.elf -O binary kernel.img
	$(OBJCOPY) kernel.elf -O binary kernel2.imx
	$(MKIMAGE) -n imximage.cfg -T imximage -e 0x17800000 -d kernel.img kernel.imx

clean :
	rm -f *.o *.elf *.asm *.img *.imx 

#Sent_Image_SD:
#sudo dd if=kernel.imx of=/dev/mmcblk0 bs=512 seek=2

