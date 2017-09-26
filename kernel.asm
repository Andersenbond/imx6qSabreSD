
kernel.elf:     file format elf32-littlearm


Disassembly of section .vectors:

80000000 <Vectors>:
80000000:	ea00001c 	b	80000078 <Reset_Handler>
80000004:	ea000005 	b	80000020 <Undefined_Handler>
80000008:	ea000005 	b	80000024 <SVC_Handler>
8000000c:	ea000005 	b	80000028 <Prefetch_Handler>
80000010:	ea000005 	b	8000002c <Abort_Handler>
80000014:	eafffffe 	b	80000014 <Vectors+0x14>
80000018:	ea000005 	b	80000034 <IRQ_Handler>
8000001c:	ea000003 	b	80000030 <FIQ_Handler>

80000020 <Undefined_Handler>:
80000020:	eafffffe 	b	80000020 <Undefined_Handler>

80000024 <SVC_Handler>:
80000024:	eafffffe 	b	80000024 <SVC_Handler>

80000028 <Prefetch_Handler>:
80000028:	eafffffe 	b	80000028 <Prefetch_Handler>

8000002c <Abort_Handler>:
8000002c:	eafffffe 	b	8000002c <Abort_Handler>

80000030 <FIQ_Handler>:
80000030:	eafffffe 	b	80000030 <FIQ_Handler>

80000034 <IRQ_Handler>:
80000034:	e24ee004 	sub	lr, lr, #4
80000038:	f96d0512 	srsdb	sp!, #18
8000003c:	e92d101f 	push	{r0, r1, r2, r3, r4, ip}
80000040:	eb0001b6 	bl	80000720 <readIntAck>
80000044:	e1a04000 	mov	r4, r0
80000048:	e3540000 	cmp	r4, #0
8000004c:	0a000004 	beq	80000064 <holding>
80000050:	fa00035a 	blx	80000dc0 <esrg_Interrupt_Handler>
80000054:	e1a00004 	mov	r0, r4
80000058:	eb0001b3 	bl	8000072c <writeEOI>
8000005c:	e8bd101f 	pop	{r0, r1, r2, r3, r4, ip}
80000060:	f8bd0a00 	rfeia	sp!

80000064 <holding>:
80000064:	e1a00004 	mov	r0, r4
80000068:	eb0001af 	bl	8000072c <writeEOI>
8000006c:	e8bd101f 	pop	{r0, r1, r2, r3, r4, ip}
80000070:	e3a0a001 	mov	sl, #1
80000074:	f8bd0a00 	rfeia	sp!

80000078 <Reset_Handler>:
80000078:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
8000007c:	e3c00a01 	bic	r0, r0, #4096	; 0x1000
80000080:	e3c00b02 	bic	r0, r0, #2048	; 0x800
80000084:	e3c00004 	bic	r0, r0, #4
80000088:	e3c00002 	bic	r0, r0, #2
8000008c:	e3c00001 	bic	r0, r0, #1
80000090:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
80000094:	ee100fb0 	mrc	15, 0, r0, cr0, cr0, {5}
80000098:	e2100003 	ands	r0, r0, #3
8000009c:	e321f0d2 	msr	CPSR_c, #210	; 0xd2
800000a0:	e59f119c 	ldr	r1, [pc, #412]	; 80000244 <holding_pen+0x24>
800000a4:	e0411400 	sub	r1, r1, r0, lsl #8
800000a8:	e1a0d001 	mov	sp, r1
800000ac:	e321f0df 	msr	CPSR_c, #223	; 0xdf
800000b0:	e59f1190 	ldr	r1, [pc, #400]	; 80000248 <holding_pen+0x28>
800000b4:	e0411600 	sub	r1, r1, r0, lsl #12
800000b8:	e1a0d001 	mov	sp, r1
800000bc:	e59f0188 	ldr	r0, [pc, #392]	; 8000024c <holding_pen+0x2c>
800000c0:	ee0c0f10 	mcr	15, 0, r0, cr12, cr0, {0}
800000c4:	eb00011f 	bl	80000548 <disableHighVecs>
800000c8:	eb0000be 	bl	800003c8 <invalidateCaches>
800000cc:	e3a00000 	mov	r0, #0
800000d0:	ee070fd5 	mcr	15, 0, r0, cr7, cr5, {6}
800000d4:	e3a00000 	mov	r0, #0
800000d8:	ee080f17 	mcr	15, 0, r0, cr8, cr7, {0}
800000dc:	ee130f10 	mrc	15, 0, r0, cr3, cr0, {0}
800000e0:	e59f0168 	ldr	r0, [pc, #360]	; 80000250 <holding_pen+0x30>
800000e4:	ee030f10 	mcr	15, 0, r0, cr3, cr0, {0}
800000e8:	e59f0164 	ldr	r0, [pc, #356]	; 80000254 <holding_pen+0x34>
800000ec:	ee020f10 	mcr	15, 0, r0, cr2, cr0, {0}
800000f0:	ee100fb0 	mrc	15, 0, r0, cr0, cr0, {5}
800000f4:	e2100003 	ands	r0, r0, #3
800000f8:	0a000000 	beq	80000100 <primaryCPUInit>
800000fc:	1a000037 	bne	800001e0 <secondaryCPUsInit>

80000100 <primaryCPUInit>:
80000100:	e59f014c 	ldr	r0, [pc, #332]	; 80000254 <holding_pen+0x34>
80000104:	e3a02b01 	mov	r2, #1024	; 0x400
80000108:	e1a01000 	mov	r1, r0
8000010c:	e3a03000 	mov	r3, #0
80000110:	e3a04000 	mov	r4, #0
80000114:	e3a05000 	mov	r5, #0
80000118:	e3a06000 	mov	r6, #0

8000011c <ttb_zero_loop>:
8000011c:	e8a10078 	stmia	r1!, {r3, r4, r5, r6}
80000120:	e2522001 	subs	r2, r2, #1
80000124:	1afffffc 	bne	8000011c <ttb_zero_loop>
80000128:	e59f1128 	ldr	r1, [pc, #296]	; 80000258 <holding_pen+0x38>
8000012c:	e1a01a21 	lsr	r1, r1, #20
80000130:	e59f3124 	ldr	r3, [pc, #292]	; 8000025c <holding_pen+0x3c>
80000134:	e1833a01 	orr	r3, r3, r1, lsl #20
80000138:	e7803101 	str	r3, [r0, r1, lsl #2]
8000013c:	ee9f1f10 	mrc	15, 4, r1, cr15, cr0, {0}
80000140:	e1a01a21 	lsr	r1, r1, #20
80000144:	e1a02101 	lsl	r2, r1, #2
80000148:	e1a01a01 	lsl	r1, r1, #20
8000014c:	e59f310c 	ldr	r3, [pc, #268]	; 80000260 <holding_pen+0x40>
80000150:	e1811003 	orr	r1, r1, r3
80000154:	e7801002 	str	r1, [r0, r2]
80000158:	e3a01307 	mov	r1, #469762048	; 0x1c000000
8000015c:	e1a01a21 	lsr	r1, r1, #20
80000160:	e1a02101 	lsl	r2, r1, #2
80000164:	e1a01a01 	lsl	r1, r1, #20
80000168:	e59f30f0 	ldr	r3, [pc, #240]	; 80000260 <holding_pen+0x40>
8000016c:	e1811003 	orr	r1, r1, r3
80000170:	e7801002 	str	r1, [r0, r2]
80000174:	e59f10e8 	ldr	r1, [pc, #232]	; 80000264 <holding_pen+0x44>
80000178:	e1a01a21 	lsr	r1, r1, #20
8000017c:	e1a02101 	lsl	r2, r1, #2
80000180:	e1a01a01 	lsl	r1, r1, #20
80000184:	e59f30d4 	ldr	r3, [pc, #212]	; 80000260 <holding_pen+0x40>
80000188:	e1811003 	orr	r1, r1, r3
8000018c:	e7801002 	str	r1, [r0, r2]
80000190:	e59f10d0 	ldr	r1, [pc, #208]	; 80000268 <holding_pen+0x48>
80000194:	e1a01a21 	lsr	r1, r1, #20
80000198:	e1a02101 	lsl	r2, r1, #2
8000019c:	e1a01a01 	lsl	r1, r1, #20
800001a0:	e59f30b8 	ldr	r3, [pc, #184]	; 80000260 <holding_pen+0x40>
800001a4:	e1811003 	orr	r1, r1, r3
800001a8:	e7801002 	str	r1, [r0, r2]
800001ac:	f57ff04f 	dsb	sy
800001b0:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
800001b4:	e3800001 	orr	r0, r0, #1
800001b8:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
800001bc:	eb00018e 	bl	800007fc <enableSCU>
800001c0:	e3a00000 	mov	r0, #0
800001c4:	e3a0100f 	mov	r1, #15
800001c8:	eb00019f 	bl	8000084c <secureSCUInvalidate>
800001cc:	eb0000f2 	bl	8000059c <joinSMP>
800001d0:	eb000193 	bl	80000824 <enableMaintenanceBroadcast>
800001d4:	eb0000fc 	bl	800005cc <enableGIC>
800001d8:	eb00013f 	bl	800006dc <enableGICProcessorInterface>
800001dc:	ea000023 	b	80000270 <__main_from_arm>

800001e0 <secondaryCPUsInit>:
800001e0:	eb00013d 	bl	800006dc <enableGICProcessorInterface>
800001e4:	e3a0001f 	mov	r0, #31
800001e8:	eb000146 	bl	80000708 <setPriorityMask>
800001ec:	e3a00000 	mov	r0, #0
800001f0:	eb000101 	bl	800005fc <enableIntID>
800001f4:	e3a00000 	mov	r0, #0
800001f8:	e3a01000 	mov	r1, #0
800001fc:	eb000114 	bl	80000654 <setIntPriority>
80000200:	ee100fb0 	mrc	15, 0, r0, cr0, cr0, {5}
80000204:	e2100003 	ands	r0, r0, #3
80000208:	e3a0100f 	mov	r1, #15
8000020c:	eb00018e 	bl	8000084c <secureSCUInvalidate>
80000210:	eb0000e1 	bl	8000059c <joinSMP>
80000214:	eb000182 	bl	80000824 <enableMaintenanceBroadcast>
80000218:	e3a0a000 	mov	sl, #0
8000021c:	f1080080 	cpsie	i

80000220 <holding_pen>:
80000220:	e35a0000 	cmp	sl, #0
80000224:	f57ff04f 	dsb	sy
80000228:	0320f003 	wfieq
8000022c:	0afffffb 	beq	80000220 <holding_pen>
80000230:	f10c0080 	cpsid	i
80000234:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
80000238:	e3800001 	orr	r0, r0, #1
8000023c:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
80000240:	ea00000c 	b	80000278 <__main_app_from_arm>
80000244:	800b15c0 	andhi	r1, fp, r0, asr #11
80000248:	800b11c0 	andhi	r1, fp, r0, asr #3
8000024c:	80000000 	andhi	r0, r0, r0
80000250:	55555555 	ldrbpl	r5, [r5, #-1365]	; 0xfffffaab
80000254:	80500000 	subshi	r0, r0, r0
80000258:	80000000 	andhi	r0, r0, r0
8000025c:	00014c06 	andeq	r4, r1, r6, lsl #24
80000260:	00000c16 	andeq	r0, r0, r6, lsl ip
80000264:	1c100000 	ldcne	0, cr0, [r0], {-0}
80000268:	80600000 	rsbhi	r0, r0, r0
8000026c:	00000000 	andeq	r0, r0, r0

80000270 <__main_from_arm>:
80000270:	e51ff004 	ldr	pc, [pc, #-4]	; 80000274 <__main_from_arm+0x4>
80000274:	80000a19 	andhi	r0, r0, r9, lsl sl

80000278 <__main_app_from_arm>:
80000278:	e51ff004 	ldr	pc, [pc, #-4]	; 8000027c <__main_app_from_arm+0x4>
8000027c:	800009ed 	andhi	r0, r0, sp, ror #19

Disassembly of section .text:

80000280 <enableInterrupts>:
80000280:	f1080080 	cpsie	i
80000284:	e12fff1e 	bx	lr

80000288 <disableInterrupts>:
80000288:	f10c0080 	cpsid	i
8000028c:	e12fff1e 	bx	lr

80000290 <enableCaches>:
80000290:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
80000294:	e3800004 	orr	r0, r0, #4
80000298:	e3800a01 	orr	r0, r0, #4096	; 0x1000
8000029c:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
800002a0:	e12fff1e 	bx	lr

800002a4 <disableCaches>:
800002a4:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
800002a8:	e3c00004 	bic	r0, r0, #4
800002ac:	e3c00a01 	bic	r0, r0, #4096	; 0x1000
800002b0:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
800002b4:	e12fff1e 	bx	lr

800002b8 <cleanDCache>:
800002b8:	e92d1ff0 	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip}
800002bc:	ee300f30 	mrc	15, 1, r0, cr0, cr0, {1}
800002c0:	e2103407 	ands	r3, r0, #117440512	; 0x7000000
800002c4:	e1a03ba3 	lsr	r3, r3, #23
800002c8:	0a00001a 	beq	80000338 <clean_dcache_finished>
800002cc:	e3a0a000 	mov	sl, #0

800002d0 <clean_dcache_loop1>:
800002d0:	e08a20aa 	add	r2, sl, sl, lsr #1
800002d4:	e1a01230 	lsr	r1, r0, r2
800002d8:	e2011007 	and	r1, r1, #7
800002dc:	e3510002 	cmp	r1, #2
800002e0:	ba000011 	blt	8000032c <clean_dcache_skip>
800002e4:	ee40af10 	mcr	15, 2, sl, cr0, cr0, {0}
800002e8:	f57ff06f 	isb	sy
800002ec:	ee301f10 	mrc	15, 1, r1, cr0, cr0, {0}
800002f0:	e2012007 	and	r2, r1, #7
800002f4:	e2822004 	add	r2, r2, #4
800002f8:	e59f42c4 	ldr	r4, [pc, #708]	; 800005c4 <leaveSMP+0x10>
800002fc:	e01441a1 	ands	r4, r4, r1, lsr #3
80000300:	e16f5f14 	clz	r5, r4
80000304:	e59f72bc 	ldr	r7, [pc, #700]	; 800005c8 <leaveSMP+0x14>
80000308:	e01776a1 	ands	r7, r7, r1, lsr #13

8000030c <clean_dcache_loop2>:
8000030c:	e1a09004 	mov	r9, r4

80000310 <clean_dcache_loop3>:
80000310:	e18ab519 	orr	fp, sl, r9, lsl r5
80000314:	e18bb217 	orr	fp, fp, r7, lsl r2
80000318:	ee07bf5a 	mcr	15, 0, fp, cr7, cr10, {2}
8000031c:	e2599001 	subs	r9, r9, #1
80000320:	aafffffa 	bge	80000310 <clean_dcache_loop3>
80000324:	e2577001 	subs	r7, r7, #1
80000328:	aafffff7 	bge	8000030c <clean_dcache_loop2>

8000032c <clean_dcache_skip>:
8000032c:	e28aa002 	add	sl, sl, #2
80000330:	e153000a 	cmp	r3, sl
80000334:	caffffe5 	bgt	800002d0 <clean_dcache_loop1>

80000338 <clean_dcache_finished>:
80000338:	e8bd1ff0 	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip}
8000033c:	e12fff1e 	bx	lr

80000340 <cleanInvalidateDCache>:
80000340:	e92d1ff0 	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip}
80000344:	ee300f30 	mrc	15, 1, r0, cr0, cr0, {1}
80000348:	e2103407 	ands	r3, r0, #117440512	; 0x7000000
8000034c:	e1a03ba3 	lsr	r3, r3, #23
80000350:	0a00001a 	beq	800003c0 <clean_invalidate_dcache_finished>
80000354:	e3a0a000 	mov	sl, #0

80000358 <clean_invalidate_dcache_loop1>:
80000358:	e08a20aa 	add	r2, sl, sl, lsr #1
8000035c:	e1a01230 	lsr	r1, r0, r2
80000360:	e2011007 	and	r1, r1, #7
80000364:	e3510002 	cmp	r1, #2
80000368:	ba000011 	blt	800003b4 <clean_invalidate_dcache_skip>
8000036c:	ee40af10 	mcr	15, 2, sl, cr0, cr0, {0}
80000370:	f57ff06f 	isb	sy
80000374:	ee301f10 	mrc	15, 1, r1, cr0, cr0, {0}
80000378:	e2012007 	and	r2, r1, #7
8000037c:	e2822004 	add	r2, r2, #4
80000380:	e59f423c 	ldr	r4, [pc, #572]	; 800005c4 <leaveSMP+0x10>
80000384:	e01441a1 	ands	r4, r4, r1, lsr #3
80000388:	e16f5f14 	clz	r5, r4
8000038c:	e59f7234 	ldr	r7, [pc, #564]	; 800005c8 <leaveSMP+0x14>
80000390:	e01776a1 	ands	r7, r7, r1, lsr #13

80000394 <clean_invalidate_dcache_loop2>:
80000394:	e1a09004 	mov	r9, r4

80000398 <clean_invalidate_dcache_loop3>:
80000398:	e18ab519 	orr	fp, sl, r9, lsl r5
8000039c:	e18bb217 	orr	fp, fp, r7, lsl r2
800003a0:	ee07bf5e 	mcr	15, 0, fp, cr7, cr14, {2}
800003a4:	e2599001 	subs	r9, r9, #1
800003a8:	aafffffa 	bge	80000398 <clean_invalidate_dcache_loop3>
800003ac:	e2577001 	subs	r7, r7, #1
800003b0:	aafffff7 	bge	80000394 <clean_invalidate_dcache_loop2>

800003b4 <clean_invalidate_dcache_skip>:
800003b4:	e28aa002 	add	sl, sl, #2
800003b8:	e153000a 	cmp	r3, sl
800003bc:	caffffe5 	bgt	80000358 <clean_invalidate_dcache_loop1>

800003c0 <clean_invalidate_dcache_finished>:
800003c0:	e8bd1ff0 	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip}
800003c4:	e12fff1e 	bx	lr

800003c8 <invalidateCaches>:
800003c8:	e92d1ff0 	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip}
800003cc:	e3a00000 	mov	r0, #0
800003d0:	ee070f15 	mcr	15, 0, r0, cr7, cr5, {0}
800003d4:	ee300f30 	mrc	15, 1, r0, cr0, cr0, {1}
800003d8:	e2103407 	ands	r3, r0, #117440512	; 0x7000000
800003dc:	e1a03ba3 	lsr	r3, r3, #23
800003e0:	0a00001a 	beq	80000450 <invalidate_caches_finished>
800003e4:	e3a0a000 	mov	sl, #0

800003e8 <invalidate_caches_loop1>:
800003e8:	e08a20aa 	add	r2, sl, sl, lsr #1
800003ec:	e1a01230 	lsr	r1, r0, r2
800003f0:	e2011007 	and	r1, r1, #7
800003f4:	e3510002 	cmp	r1, #2
800003f8:	ba000011 	blt	80000444 <invalidate_caches_skip>
800003fc:	ee40af10 	mcr	15, 2, sl, cr0, cr0, {0}
80000400:	f57ff06f 	isb	sy
80000404:	ee301f10 	mrc	15, 1, r1, cr0, cr0, {0}
80000408:	e2012007 	and	r2, r1, #7
8000040c:	e2822004 	add	r2, r2, #4
80000410:	e59f41ac 	ldr	r4, [pc, #428]	; 800005c4 <leaveSMP+0x10>
80000414:	e01441a1 	ands	r4, r4, r1, lsr #3
80000418:	e16f5f14 	clz	r5, r4
8000041c:	e59f71a4 	ldr	r7, [pc, #420]	; 800005c8 <leaveSMP+0x14>
80000420:	e01776a1 	ands	r7, r7, r1, lsr #13

80000424 <invalidate_caches_loop2>:
80000424:	e1a09004 	mov	r9, r4

80000428 <invalidate_caches_loop3>:
80000428:	e18ab519 	orr	fp, sl, r9, lsl r5
8000042c:	e18bb217 	orr	fp, fp, r7, lsl r2
80000430:	ee07bf56 	mcr	15, 0, fp, cr7, cr6, {2}
80000434:	e2599001 	subs	r9, r9, #1
80000438:	aafffffa 	bge	80000428 <invalidate_caches_loop3>
8000043c:	e2577001 	subs	r7, r7, #1
80000440:	aafffff7 	bge	80000424 <invalidate_caches_loop2>

80000444 <invalidate_caches_skip>:
80000444:	e28aa002 	add	sl, sl, #2
80000448:	e153000a 	cmp	r3, sl
8000044c:	caffffe5 	bgt	800003e8 <invalidate_caches_loop1>

80000450 <invalidate_caches_finished>:
80000450:	e8bd1ff0 	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip}
80000454:	e12fff1e 	bx	lr

80000458 <invalidateCaches_IS>:
80000458:	e92d1ff0 	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip}
8000045c:	e3a00000 	mov	r0, #0
80000460:	ee070f11 	mcr	15, 0, r0, cr7, cr1, {0}
80000464:	ee300f30 	mrc	15, 1, r0, cr0, cr0, {1}
80000468:	e2103407 	ands	r3, r0, #117440512	; 0x7000000
8000046c:	e1a03ba3 	lsr	r3, r3, #23
80000470:	0a00001a 	beq	800004e0 <invalidate_caches_is_finished>
80000474:	e3a0a000 	mov	sl, #0

80000478 <invalidate_caches_is_loop1>:
80000478:	e08a20aa 	add	r2, sl, sl, lsr #1
8000047c:	e1a01230 	lsr	r1, r0, r2
80000480:	e2011007 	and	r1, r1, #7
80000484:	e3510002 	cmp	r1, #2
80000488:	ba000011 	blt	800004d4 <invalidate_caches_is_skip>
8000048c:	ee40af10 	mcr	15, 2, sl, cr0, cr0, {0}
80000490:	f57ff06f 	isb	sy
80000494:	ee301f10 	mrc	15, 1, r1, cr0, cr0, {0}
80000498:	e2012007 	and	r2, r1, #7
8000049c:	e2822004 	add	r2, r2, #4
800004a0:	e59f411c 	ldr	r4, [pc, #284]	; 800005c4 <leaveSMP+0x10>
800004a4:	e01441a1 	ands	r4, r4, r1, lsr #3
800004a8:	e16f5f14 	clz	r5, r4
800004ac:	e59f7114 	ldr	r7, [pc, #276]	; 800005c8 <leaveSMP+0x14>
800004b0:	e01776a1 	ands	r7, r7, r1, lsr #13

800004b4 <invalidate_caches_is_loop2>:
800004b4:	e1a09004 	mov	r9, r4

800004b8 <invalidate_caches_is_loop3>:
800004b8:	e18ab519 	orr	fp, sl, r9, lsl r5
800004bc:	e18bb217 	orr	fp, fp, r7, lsl r2
800004c0:	ee07bf56 	mcr	15, 0, fp, cr7, cr6, {2}
800004c4:	e2599001 	subs	r9, r9, #1
800004c8:	aafffffa 	bge	800004b8 <invalidate_caches_is_loop3>
800004cc:	e2577001 	subs	r7, r7, #1
800004d0:	aafffff7 	bge	800004b4 <invalidate_caches_is_loop2>

800004d4 <invalidate_caches_is_skip>:
800004d4:	e28aa002 	add	sl, sl, #2
800004d8:	e153000a 	cmp	r3, sl
800004dc:	caffffe5 	bgt	80000478 <invalidate_caches_is_loop1>

800004e0 <invalidate_caches_is_finished>:
800004e0:	e8bd1ff0 	pop	{r4, r5, r6, r7, r8, r9, sl, fp, ip}
800004e4:	e12fff1e 	bx	lr

800004e8 <invalidateUnifiedTLB>:
800004e8:	e3a00000 	mov	r0, #0
800004ec:	ee080f17 	mcr	15, 0, r0, cr8, cr7, {0}
800004f0:	e12fff1e 	bx	lr

800004f4 <invalidateUnifiedTLB_IS>:
800004f4:	e3a00001 	mov	r0, #1
800004f8:	ee080f13 	mcr	15, 0, r0, cr8, cr3, {0}
800004fc:	e12fff1e 	bx	lr

80000500 <enableBranchPrediction>:
80000500:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
80000504:	e3800b02 	orr	r0, r0, #2048	; 0x800
80000508:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
8000050c:	e12fff1e 	bx	lr

80000510 <disableBranchPrediction>:
80000510:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
80000514:	e3c00b02 	bic	r0, r0, #2048	; 0x800
80000518:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
8000051c:	e12fff1e 	bx	lr

80000520 <flushBranchTargetCache>:
80000520:	e3a00000 	mov	r0, #0
80000524:	ee070fd5 	mcr	15, 0, r0, cr7, cr5, {6}
80000528:	e12fff1e 	bx	lr

8000052c <flushBranchTargetCache_IS>:
8000052c:	e3a00000 	mov	r0, #0
80000530:	ee070fd1 	mcr	15, 0, r0, cr7, cr1, {6}
80000534:	e12fff1e 	bx	lr

80000538 <enableHighVecs>:
80000538:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
8000053c:	e3800a02 	orr	r0, r0, #8192	; 0x2000
80000540:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
80000544:	e12fff1e 	bx	lr

80000548 <disableHighVecs>:
80000548:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
8000054c:	e3c00a02 	bic	r0, r0, #8192	; 0x2000
80000550:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
80000554:	e12fff1e 	bx	lr

80000558 <getContextID>:
80000558:	ee1d0f30 	mrc	15, 0, r0, cr13, cr0, {1}
8000055c:	e12fff1e 	bx	lr

80000560 <setContextID>:
80000560:	ee0d0f30 	mcr	15, 0, r0, cr13, cr0, {1}
80000564:	e12fff1e 	bx	lr

80000568 <getMIDR>:
80000568:	ee100f10 	mrc	15, 0, r0, cr0, cr0, {0}
8000056c:	e12fff1e 	bx	lr

80000570 <getMPIDR>:
80000570:	ee100fb0 	mrc	15, 0, r0, cr0, cr0, {5}
80000574:	e12fff1e 	bx	lr

80000578 <getBaseAddr>:
80000578:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
8000057c:	e12fff1e 	bx	lr

80000580 <getCPUID>:
80000580:	ee100fb0 	mrc	15, 0, r0, cr0, cr0, {5}
80000584:	e2000003 	and	r0, r0, #3
80000588:	e12fff1e 	bx	lr

8000058c <goToSleep>:
8000058c:	f57ff04f 	dsb	sy
80000590:	e320f003 	wfi
80000594:	eafffffc 	b	8000058c <goToSleep>
80000598:	e12fff1e 	bx	lr

8000059c <joinSMP>:
8000059c:	ee110f30 	mrc	15, 0, r0, cr1, cr0, {1}
800005a0:	e1a01000 	mov	r1, r0
800005a4:	e3800040 	orr	r0, r0, #64	; 0x40
800005a8:	e1500001 	cmp	r0, r1
800005ac:	1e010f30 	mcrne	15, 0, r0, cr1, cr0, {1}
800005b0:	e12fff1e 	bx	lr

800005b4 <leaveSMP>:
800005b4:	ee110f30 	mrc	15, 0, r0, cr1, cr0, {1}
800005b8:	e3c00040 	bic	r0, r0, #64	; 0x40
800005bc:	ee010f30 	mcr	15, 0, r0, cr1, cr0, {1}
800005c0:	e12fff1e 	bx	lr
800005c4:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
800005c8:	00007fff 	strdeq	r7, [r0], -pc	; <UNPREDICTABLE>

800005cc <enableGIC>:
800005cc:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
800005d0:	e2800a01 	add	r0, r0, #4096	; 0x1000
800005d4:	e5901000 	ldr	r1, [r0]
800005d8:	e3811001 	orr	r1, r1, #1
800005dc:	e5801000 	str	r1, [r0]
800005e0:	e12fff1e 	bx	lr

800005e4 <disableGIC>:
800005e4:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
800005e8:	e2800a01 	add	r0, r0, #4096	; 0x1000
800005ec:	e5901000 	ldr	r1, [r0]
800005f0:	e3c11001 	bic	r1, r1, #1
800005f4:	e5801000 	str	r1, [r0]
800005f8:	e12fff1e 	bx	lr

800005fc <enableIntID>:
800005fc:	e1a01000 	mov	r1, r0
80000600:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
80000604:	e1a02001 	mov	r2, r1
80000608:	e1a022a2 	lsr	r2, r2, #5
8000060c:	e1a02102 	lsl	r2, r2, #2
80000610:	e201101f 	and	r1, r1, #31
80000614:	e3a03001 	mov	r3, #1
80000618:	e1a03113 	lsl	r3, r3, r1
8000061c:	e2822c11 	add	r2, r2, #4352	; 0x1100
80000620:	e7803002 	str	r3, [r0, r2]
80000624:	e12fff1e 	bx	lr

80000628 <disableIntID>:
80000628:	e1a01000 	mov	r1, r0
8000062c:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
80000630:	e1a02001 	mov	r2, r1
80000634:	e1a022a2 	lsr	r2, r2, #5
80000638:	e1a02102 	lsl	r2, r2, #2
8000063c:	e201101f 	and	r1, r1, #31
80000640:	e3a03001 	mov	r3, #1
80000644:	e1a03113 	lsl	r3, r3, r1
80000648:	e2822d46 	add	r2, r2, #4480	; 0x1180
8000064c:	e7803002 	str	r3, [r0, r2]
80000650:	e12fff1e 	bx	lr

80000654 <setIntPriority>:
80000654:	e1a02000 	mov	r2, r0
80000658:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
8000065c:	e201101f 	and	r1, r1, #31
80000660:	e1a01181 	lsl	r1, r1, #3
80000664:	e3c23003 	bic	r3, r2, #3
80000668:	e2833b05 	add	r3, r3, #5120	; 0x1400
8000066c:	e0800003 	add	r0, r0, r3
80000670:	e2022003 	and	r2, r2, #3
80000674:	e1a02182 	lsl	r2, r2, #3
80000678:	e3a0c0ff 	mov	ip, #255	; 0xff
8000067c:	e1a0c21c 	lsl	ip, ip, r2
80000680:	e1a01211 	lsl	r1, r1, r2
80000684:	e5903000 	ldr	r3, [r0]
80000688:	e1c3300c 	bic	r3, r3, ip
8000068c:	e1833001 	orr	r3, r3, r1
80000690:	e5803000 	str	r3, [r0]
80000694:	e12fff1e 	bx	lr

80000698 <getIntPriority>:
80000698:	e12fff1e 	bx	lr

8000069c <setIntTarget>:
8000069c:	ee9f2f10 	mrc	15, 4, r2, cr15, cr0, {0}
800006a0:	e201100f 	and	r1, r1, #15
800006a4:	e3c03003 	bic	r3, r0, #3
800006a8:	e2833b06 	add	r3, r3, #6144	; 0x1800
800006ac:	e0822003 	add	r2, r2, r3
800006b0:	e2000003 	and	r0, r0, #3
800006b4:	e1a00180 	lsl	r0, r0, #3
800006b8:	e3a0c0ff 	mov	ip, #255	; 0xff
800006bc:	e1a0c01c 	lsl	ip, ip, r0
800006c0:	e1a01011 	lsl	r1, r1, r0
800006c4:	e5923000 	ldr	r3, [r2]
800006c8:	e1c3300c 	bic	r3, r3, ip
800006cc:	e1833001 	orr	r3, r3, r1
800006d0:	e5823000 	str	r3, [r2]
800006d4:	e12fff1e 	bx	lr

800006d8 <getIntTarget>:
800006d8:	e12fff1e 	bx	lr

800006dc <enableGICProcessorInterface>:
800006dc:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
800006e0:	e5901100 	ldr	r1, [r0, #256]	; 0x100
800006e4:	e3811003 	orr	r1, r1, #3
800006e8:	e3c11008 	bic	r1, r1, #8
800006ec:	e5801100 	str	r1, [r0, #256]	; 0x100
800006f0:	e12fff1e 	bx	lr

800006f4 <disableGICProcessorInterface>:
800006f4:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
800006f8:	e5901100 	ldr	r1, [r0, #256]	; 0x100
800006fc:	e3c11003 	bic	r1, r1, #3
80000700:	e5801100 	str	r1, [r0, #256]	; 0x100
80000704:	e12fff1e 	bx	lr

80000708 <setPriorityMask>:
80000708:	ee9f1f10 	mrc	15, 4, r1, cr15, cr0, {0}
8000070c:	e5810104 	str	r0, [r1, #260]	; 0x104
80000710:	e12fff1e 	bx	lr

80000714 <setBinaryPoint>:
80000714:	ee9f1f10 	mrc	15, 4, r1, cr15, cr0, {0}
80000718:	e5810108 	str	r0, [r1, #264]	; 0x108
8000071c:	e12fff1e 	bx	lr

80000720 <readIntAck>:
80000720:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
80000724:	e590010c 	ldr	r0, [r0, #268]	; 0x10c
80000728:	e12fff1e 	bx	lr

8000072c <writeEOI>:
8000072c:	ee9f1f10 	mrc	15, 4, r1, cr15, cr0, {0}
80000730:	e5810110 	str	r0, [r1, #272]	; 0x110
80000734:	e12fff1e 	bx	lr

80000738 <sendSGI>:
80000738:	e200300f 	and	r3, r0, #15
8000073c:	e201100f 	and	r1, r1, #15
80000740:	e202200f 	and	r2, r2, #15
80000744:	e1833801 	orr	r3, r3, r1, lsl #16
80000748:	e1833c02 	orr	r3, r3, r2, lsl #24
8000074c:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
80000750:	e2800c1f 	add	r0, r0, #7936	; 0x1f00
80000754:	e5803000 	str	r3, [r0]
80000758:	e12fff1e 	bx	lr

8000075c <enableSecureFIQs>:
8000075c:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
80000760:	e5901100 	ldr	r1, [r0, #256]	; 0x100
80000764:	e3811008 	orr	r1, r1, #8
80000768:	e5801100 	str	r1, [r0, #256]	; 0x100
8000076c:	e12fff1e 	bx	lr

80000770 <disableSecureFIQs>:
80000770:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
80000774:	e5901100 	ldr	r1, [r0, #256]	; 0x100
80000778:	e3c11008 	bic	r1, r1, #8
8000077c:	e5801100 	str	r1, [r0, #256]	; 0x100
80000780:	e12fff1e 	bx	lr

80000784 <makeIntSecure>:
80000784:	ee9f1f10 	mrc	15, 4, r1, cr15, cr0, {0}
80000788:	e1a02000 	mov	r2, r0
8000078c:	e1a022a2 	lsr	r2, r2, #5
80000790:	e1a02102 	lsl	r2, r2, #2
80000794:	e200001f 	and	r0, r0, #31
80000798:	e3a03001 	mov	r3, #1
8000079c:	e1a03013 	lsl	r3, r3, r0
800007a0:	e2822d42 	add	r2, r2, #4224	; 0x1080
800007a4:	e7910002 	ldr	r0, [r1, r2]
800007a8:	e1c00003 	bic	r0, r0, r3
800007ac:	e7810002 	str	r0, [r1, r2]
800007b0:	e12fff1e 	bx	lr

800007b4 <makeIntNonSecure>:
800007b4:	ee9f1f10 	mrc	15, 4, r1, cr15, cr0, {0}
800007b8:	e1a02000 	mov	r2, r0
800007bc:	e1a022a2 	lsr	r2, r2, #5
800007c0:	e1a02102 	lsl	r2, r2, #2
800007c4:	e200001f 	and	r0, r0, #31
800007c8:	e3a03001 	mov	r3, #1
800007cc:	e1a03013 	lsl	r3, r3, r0
800007d0:	e2822d42 	add	r2, r2, #4224	; 0x1080
800007d4:	e7910002 	ldr	r0, [r1, r2]
800007d8:	e1800003 	orr	r0, r0, r3
800007dc:	e7810002 	str	r0, [r1, r2]
800007e0:	e12fff1e 	bx	lr

800007e4 <getIntSecurity>:
800007e4:	e12fff1e 	bx	lr

800007e8 <getNumCPUs>:
800007e8:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
800007ec:	e5900004 	ldr	r0, [r0, #4]
800007f0:	e2000003 	and	r0, r0, #3
800007f4:	e2800001 	add	r0, r0, #1
800007f8:	e12fff1e 	bx	lr

800007fc <enableSCU>:
800007fc:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
80000800:	e5901000 	ldr	r1, [r0]
80000804:	e3811001 	orr	r1, r1, #1
80000808:	e5801000 	str	r1, [r0]
8000080c:	e12fff1e 	bx	lr

80000810 <getCPUsInSMP>:
80000810:	ee9f0f10 	mrc	15, 4, r0, cr15, cr0, {0}
80000814:	e5900004 	ldr	r0, [r0, #4]
80000818:	e1a00220 	lsr	r0, r0, #4
8000081c:	e200000f 	and	r0, r0, #15
80000820:	e12fff1e 	bx	lr

80000824 <enableMaintenanceBroadcast>:
80000824:	ee110f30 	mrc	15, 0, r0, cr1, cr0, {1}
80000828:	e1a01000 	mov	r1, r0
8000082c:	e3800001 	orr	r0, r0, #1
80000830:	e1500001 	cmp	r0, r1
80000834:	1e010f30 	mcrne	15, 0, r0, cr1, cr0, {1}
80000838:	e12fff1e 	bx	lr

8000083c <disableMaintenanceBroadcast>:
8000083c:	ee110f30 	mrc	15, 0, r0, cr1, cr0, {1}
80000840:	e3c00001 	bic	r0, r0, #1
80000844:	ee010f30 	mcr	15, 0, r0, cr1, cr0, {1}
80000848:	e12fff1e 	bx	lr

8000084c <secureSCUInvalidate>:
8000084c:	e2000003 	and	r0, r0, #3
80000850:	e1a00100 	lsl	r0, r0, #2
80000854:	e201100f 	and	r1, r1, #15
80000858:	e1a01011 	lsl	r1, r1, r0
8000085c:	ee9f2f10 	mrc	15, 4, r2, cr15, cr0, {0}
80000860:	e582100c 	str	r1, [r2, #12]
80000864:	e12fff1e 	bx	lr

80000868 <setPrivateTimersNonSecureAccess>:
80000868:	e2000001 	and	r0, r0, #1
8000086c:	e2811004 	add	r1, r1, #4
80000870:	e1a00110 	lsl	r0, r0, r1
80000874:	e3a0c001 	mov	ip, #1
80000878:	e1a0c11c 	lsl	ip, ip, r1
8000087c:	ee9f2f10 	mrc	15, 4, r2, cr15, cr0, {0}
80000880:	e5923054 	ldr	r3, [r2, #84]	; 0x54
80000884:	e1c3300c 	bic	r3, r3, ip
80000888:	e1833000 	orr	r3, r3, r0
8000088c:	e5823054 	str	r3, [r2, #84]	; 0x54
80000890:	e12fff1e 	bx	lr

80000894 <setGlobalTimerNonSecureAccess>:
80000894:	e2000001 	and	r0, r0, #1
80000898:	e2811008 	add	r1, r1, #8
8000089c:	e1a00110 	lsl	r0, r0, r1
800008a0:	e3a0c001 	mov	ip, #1
800008a4:	e1a0c11c 	lsl	ip, ip, r1
800008a8:	ee9f2f10 	mrc	15, 4, r2, cr15, cr0, {0}
800008ac:	e5923054 	ldr	r3, [r2, #84]	; 0x54
800008b0:	e1c3300c 	bic	r3, r3, ip
800008b4:	e1833000 	orr	r3, r3, r0
800008b8:	e5823054 	str	r3, [r2, #84]	; 0x54
800008bc:	e12fff1e 	bx	lr

800008c0 <initMutex>:
800008c0:	e3a010ff 	mov	r1, #255	; 0xff
800008c4:	e5801000 	str	r1, [r0]
800008c8:	e12fff1e 	bx	lr

800008cc <lockMutex>:
800008cc:	e1901f9f 	ldrex	r1, [r0]
800008d0:	e35100ff 	cmp	r1, #255	; 0xff
800008d4:	1320f002 	wfene
800008d8:	1afffffb 	bne	800008cc <lockMutex>
800008dc:	ee101fb0 	mrc	15, 0, r1, cr0, cr0, {5}
800008e0:	e2011003 	and	r1, r1, #3
800008e4:	e1802f91 	strex	r2, r1, [r0]
800008e8:	e3520000 	cmp	r2, #0
800008ec:	1afffff6 	bne	800008cc <lockMutex>
800008f0:	f57ff05f 	dmb	sy
800008f4:	e12fff1e 	bx	lr

800008f8 <unlockMutex>:
800008f8:	ee101fb0 	mrc	15, 0, r1, cr0, cr0, {5}
800008fc:	e2011003 	and	r1, r1, #3
80000900:	e5902000 	ldr	r2, [r0]
80000904:	e1510002 	cmp	r1, r2
80000908:	13a00001 	movne	r0, #1
8000090c:	112fff1e 	bxne	lr
80000910:	f57ff05f 	dmb	sy
80000914:	e3a010ff 	mov	r1, #255	; 0xff
80000918:	e5801000 	str	r1, [r0]
8000091c:	f57ff04f 	dsb	sy
80000920:	e320f004 	sev
80000924:	e3a00000 	mov	r0, #0
80000928:	e12fff1e 	bx	lr

8000092c <isMutexLocked>:
8000092c:	e5900000 	ldr	r0, [r0]
80000930:	e35000ff 	cmp	r0, #255	; 0xff
80000934:	03a00000 	moveq	r0, #0
80000938:	13a00001 	movne	r0, #1
8000093c:	e12fff1e 	bx	lr

80000940 <init_timer>:
80000940:	b084      	sub	sp, #16
80000942:	2200      	movs	r2, #0
80000944:	9203      	str	r2, [sp, #12]
80000946:	9202      	str	r2, [sp, #8]
80000948:	9201      	str	r2, [sp, #4]
8000094a:	f44f 63c1 	mov.w	r3, #1544	; 0x608
8000094e:	f6c2 4300 	movt	r3, #11264	; 0x2c00
80000952:	f24a 6106 	movw	r1, #42502	; 0xa606
80000956:	6019      	str	r1, [r3, #0]
80000958:	f44f 61c0 	mov.w	r1, #1536	; 0x600
8000095c:	f6c2 4100 	movt	r1, #11264	; 0x2c00
80000960:	f44f 5000 	mov.w	r0, #8192	; 0x2000
80000964:	6008      	str	r0, [r1, #0]
80000966:	f44f 5180 	mov.w	r1, #4096	; 0x1000
8000096a:	f6c2 4100 	movt	r1, #11264	; 0x2c00
8000096e:	600a      	str	r2, [r1, #0]
80000970:	f44f 508c 	mov.w	r0, #4480	; 0x1180
80000974:	f6c2 4000 	movt	r0, #11264	; 0x2c00
80000978:	f04f 32ff 	mov.w	r2, #4294967295	; 0xffffffff
8000097c:	6002      	str	r2, [r0, #0]
8000097e:	f241 1084 	movw	r0, #4484	; 0x1184
80000982:	f6c2 4000 	movt	r0, #11264	; 0x2c00
80000986:	6002      	str	r2, [r0, #0]
80000988:	f44f 5094 	mov.w	r0, #4736	; 0x1280
8000098c:	f6c2 4000 	movt	r0, #11264	; 0x2c00
80000990:	6002      	str	r2, [r0, #0]
80000992:	f241 2084 	movw	r0, #4740	; 0x1284
80000996:	f6c2 4000 	movt	r0, #11264	; 0x2c00
8000099a:	6002      	str	r2, [r0, #0]
8000099c:	f44f 5288 	mov.w	r2, #4352	; 0x1100
800009a0:	f6c2 4200 	movt	r2, #11264	; 0x2c00
800009a4:	6810      	ldr	r0, [r2, #0]
800009a6:	f040 5000 	orr.w	r0, r0, #536870912	; 0x20000000
800009aa:	6010      	str	r0, [r2, #0]
800009ac:	f241 421c 	movw	r2, #5148	; 0x141c
800009b0:	f6c2 4200 	movt	r2, #11264	; 0x2c00
800009b4:	6810      	ldr	r0, [r2, #0]
800009b6:	f420 407f 	bic.w	r0, r0, #65280	; 0xff00
800009ba:	6010      	str	r0, [r2, #0]
800009bc:	f44f 7282 	mov.w	r2, #260	; 0x104
800009c0:	f6c2 4200 	movt	r2, #11264	; 0x2c00
800009c4:	2008      	movs	r0, #8
800009c6:	6010      	str	r0, [r2, #0]
800009c8:	2001      	movs	r0, #1
800009ca:	6008      	str	r0, [r1, #0]
800009cc:	f240 620c 	movw	r2, #1548	; 0x60c
800009d0:	f6c2 4200 	movt	r2, #11264	; 0x2c00
800009d4:	6010      	str	r0, [r2, #0]
800009d6:	681a      	ldr	r2, [r3, #0]
800009d8:	4302      	orrs	r2, r0
800009da:	601a      	str	r2, [r3, #0]
800009dc:	b004      	add	sp, #16
800009de:	4770      	bx	lr

800009e0 <SGI_Handler>:
800009e0:	b508      	push	{r3, lr}
800009e2:	2042      	movs	r0, #66	; 0x42
800009e4:	f000 f866 	bl	80000ab4 <uart_putc_polled>
800009e8:	bd08      	pop	{r3, pc}
800009ea:	bf00      	nop

800009ec <main_app>:
800009ec:	b508      	push	{r3, lr}
800009ee:	f7ff ed88 	blx	80000500 <enableBranchPrediction>
800009f2:	f7ff ec4e 	blx	80000290 <enableCaches>
800009f6:	2043      	movs	r0, #67	; 0x43
800009f8:	f000 f85c 	bl	80000ab4 <uart_putc_polled>
800009fc:	f7ff edc0 	blx	80000580 <getCPUID>
80000a00:	4604      	mov	r4, r0
80000a02:	f7ff eef2 	blx	800007e8 <getNumCPUs>
80000a06:	2c01      	cmp	r4, #1
80000a08:	bf88      	it	hi
80000a0a:	2801      	cmphi	r0, #1
80000a0c:	d903      	bls.n	80000a16 <main_app+0x2a>
80000a0e:	f3bf 8f4f 	dsb	sy
80000a12:	bf30      	wfi
80000a14:	e7fb      	b.n	80000a0e <main_app+0x22>
80000a16:	e7fe      	b.n	80000a16 <main_app+0x2a>

80000a18 <main>:
80000a18:	b508      	push	{r3, lr}
80000a1a:	f7ff ed72 	blx	80000500 <enableBranchPrediction>
80000a1e:	f7ff ec38 	blx	80000290 <enableCaches>
80000a22:	f640 70a0 	movw	r0, #4000	; 0xfa0
80000a26:	f2c8 0000 	movt	r0, #32768	; 0x8000
80000a2a:	f7ff ef4a 	blx	800008c0 <initMutex>
80000a2e:	f000 f837 	bl	80000aa0 <uart_init>
80000a32:	2041      	movs	r0, #65	; 0x41
80000a34:	f000 f83e 	bl	80000ab4 <uart_putc_polled>
80000a38:	2005      	movs	r0, #5
80000a3a:	f7ff ede0 	blx	800005fc <enableIntID>
80000a3e:	2100      	movs	r1, #0
80000a40:	2005      	movs	r0, #5
80000a42:	f7ff ee08 	blx	80000654 <setIntPriority>
80000a46:	f640 11e1 	movw	r1, #2529	; 0x9e1
80000a4a:	f2c8 0100 	movt	r1, #32768	; 0x8000
80000a4e:	2005      	movs	r0, #5
80000a50:	f000 f9f4 	bl	80000e3c <esrg_Register_IRS>
80000a54:	f7ff edba 	blx	800005cc <enableGIC>
80000a58:	b662      	cpsie	i
80000a5a:	2200      	movs	r2, #0
80000a5c:	210f      	movs	r1, #15
80000a5e:	2005      	movs	r0, #5
80000a60:	f7ff ee6a 	blx	80000738 <sendSGI>
80000a64:	f7ff ff6c 	bl	80000940 <init_timer>
80000a68:	f7ff eebe 	blx	800007e8 <getNumCPUs>
80000a6c:	2801      	cmp	r0, #1
80000a6e:	d104      	bne.n	80000a7a <main+0x62>
80000a70:	2200      	movs	r2, #0
80000a72:	210f      	movs	r1, #15
80000a74:	4610      	mov	r0, r2
80000a76:	f7ff ee60 	blx	80000738 <sendSGI>
80000a7a:	f7ff ffb7 	bl	800009ec <main_app>
80000a7e:	bf00      	nop

80000a80 <__malloc_lock>:
80000a80:	b508      	push	{r3, lr}
80000a82:	f640 70a0 	movw	r0, #4000	; 0xfa0
80000a86:	f2c8 0000 	movt	r0, #32768	; 0x8000
80000a8a:	f7ff ef20 	blx	800008cc <lockMutex>
80000a8e:	bd08      	pop	{r3, pc}

80000a90 <__malloc_unlock>:
80000a90:	b508      	push	{r3, lr}
80000a92:	f640 70a0 	movw	r0, #4000	; 0xfa0
80000a96:	f2c8 0000 	movt	r0, #32768	; 0x8000
80000a9a:	f7ff ef2e 	blx	800008f8 <unlockMutex>
80000a9e:	bd08      	pop	{r3, pc}

80000aa0 <uart_init>:
80000aa0:	2230      	movs	r2, #48	; 0x30
80000aa2:	f6c1 4209 	movt	r2, #7177	; 0x1c09
80000aa6:	6813      	ldr	r3, [r2, #0]
80000aa8:	f443 7340 	orr.w	r3, r3, #768	; 0x300
80000aac:	f043 0301 	orr.w	r3, r3, #1
80000ab0:	6013      	str	r3, [r2, #0]
80000ab2:	4770      	bx	lr

80000ab4 <uart_putc_polled>:
80000ab4:	2218      	movs	r2, #24
80000ab6:	f6c1 4209 	movt	r2, #7177	; 0x1c09
80000aba:	6813      	ldr	r3, [r2, #0]
80000abc:	f013 0f08 	tst.w	r3, #8
80000ac0:	d1fb      	bne.n	80000aba <uart_putc_polled+0x6>
80000ac2:	2300      	movs	r3, #0
80000ac4:	f6c1 4309 	movt	r3, #7177	; 0x1c09
80000ac8:	7018      	strb	r0, [r3, #0]
80000aca:	4770      	bx	lr

80000acc <uart_getchar_polled>:
80000acc:	2218      	movs	r2, #24
80000ace:	f6c1 4209 	movt	r2, #7177	; 0x1c09
80000ad2:	6813      	ldr	r3, [r2, #0]
80000ad4:	f013 0f08 	tst.w	r3, #8
80000ad8:	d1fb      	bne.n	80000ad2 <uart_getchar_polled+0x6>
80000ada:	2300      	movs	r3, #0
80000adc:	f6c1 4309 	movt	r3, #7177	; 0x1c09
80000ae0:	7818      	ldrb	r0, [r3, #0]
80000ae2:	4770      	bx	lr

80000ae4 <esrg_UartPrint>:
80000ae4:	b510      	push	{r4, lr}
80000ae6:	4604      	mov	r4, r0
80000ae8:	7800      	ldrb	r0, [r0, #0]
80000aea:	2823      	cmp	r0, #35	; 0x23
80000aec:	d004      	beq.n	80000af8 <esrg_UartPrint+0x14>
80000aee:	f7ff ffe1 	bl	80000ab4 <uart_putc_polled>
80000af2:	7820      	ldrb	r0, [r4, #0]
80000af4:	2823      	cmp	r0, #35	; 0x23
80000af6:	d1fa      	bne.n	80000aee <esrg_UartPrint+0xa>
80000af8:	bd10      	pop	{r4, pc}
80000afa:	bf00      	nop

80000afc <esrg_UartPrintln>:
80000afc:	b510      	push	{r4, lr}
80000afe:	4604      	mov	r4, r0
80000b00:	7800      	ldrb	r0, [r0, #0]
80000b02:	2823      	cmp	r0, #35	; 0x23
80000b04:	d005      	beq.n	80000b12 <esrg_UartPrintln+0x16>
80000b06:	f7ff ffd5 	bl	80000ab4 <uart_putc_polled>
80000b0a:	f814 0f01 	ldrb.w	r0, [r4, #1]!
80000b0e:	2823      	cmp	r0, #35	; 0x23
80000b10:	d1f9      	bne.n	80000b06 <esrg_UartPrintln+0xa>
80000b12:	200a      	movs	r0, #10
80000b14:	f7ff ffce 	bl	80000ab4 <uart_putc_polled>
80000b18:	bd10      	pop	{r4, pc}
80000b1a:	bf00      	nop

80000b1c <imx_iomux_v3_setup_pad>:
80000b1c:	b430      	push	{r4, r5}
80000b1e:	f3c0 020b 	ubfx	r2, r0, #0, #12
80000b22:	0e03      	lsrs	r3, r0, #24
80000b24:	ea43 2301 	orr.w	r3, r3, r1, lsl #8
80000b28:	f3c3 030b 	ubfx	r3, r3, #0, #12
80000b2c:	f3c0 300b 	ubfx	r0, r0, #12, #12
80000b30:	0a4c      	lsrs	r4, r1, #9
80000b32:	b132      	cbz	r2, 80000b42 <imx_iomux_v3_setup_pad+0x26>
80000b34:	f102 7203 	add.w	r2, r2, #34340864	; 0x20c0000
80000b38:	f502 3200 	add.w	r2, r2, #131072	; 0x20000
80000b3c:	f3c1 1504 	ubfx	r5, r1, #4, #5
80000b40:	6015      	str	r5, [r2, #0]
80000b42:	b133      	cbz	r3, 80000b52 <imx_iomux_v3_setup_pad+0x36>
80000b44:	f103 7303 	add.w	r3, r3, #34340864	; 0x20c0000
80000b48:	f503 3300 	add.w	r3, r3, #131072	; 0x20000
80000b4c:	f3c1 61c3 	ubfx	r1, r1, #27, #4
80000b50:	6019      	str	r1, [r3, #0]
80000b52:	f484 3300 	eor.w	r3, r4, #131072	; 0x20000
80000b56:	1c02      	adds	r2, r0, #0
80000b58:	bf18      	it	ne
80000b5a:	2201      	movne	r2, #1
80000b5c:	ea12 4353 	ands.w	r3, r2, r3, lsr #17
80000b60:	bf1f      	itttt	ne
80000b62:	f100 7003 	addne.w	r0, r0, #34340864	; 0x20c0000
80000b66:	f500 3000 	addne.w	r0, r0, #131072	; 0x20000
80000b6a:	f3c4 0411 	ubfxne	r4, r4, #0, #18
80000b6e:	6004      	strne	r4, [r0, #0]
80000b70:	bc30      	pop	{r4, r5}
80000b72:	4770      	bx	lr

80000b74 <imx_iomux_init>:
80000b74:	f44f 7320 	mov.w	r3, #640	; 0x280
80000b78:	f2c0 230e 	movt	r3, #526	; 0x20e
80000b7c:	2203      	movs	r2, #3
80000b7e:	601a      	str	r2, [r3, #0]
80000b80:	f44f 63ca 	mov.w	r3, #1616	; 0x650
80000b84:	f2c0 230e 	movt	r3, #526	; 0x20e
80000b88:	f24b 01b1 	movw	r1, #45233	; 0xb0b1
80000b8c:	f2c0 0101 	movt	r1, #1
80000b90:	6019      	str	r1, [r3, #0]
80000b92:	f44f 7321 	mov.w	r3, #644	; 0x284
80000b96:	f2c0 230e 	movt	r3, #526	; 0x20e
80000b9a:	601a      	str	r2, [r3, #0]
80000b9c:	f44f 6312 	mov.w	r3, #2336	; 0x920
80000ba0:	f2c0 230e 	movt	r3, #526	; 0x20e
80000ba4:	2101      	movs	r1, #1
80000ba6:	6019      	str	r1, [r3, #0]
80000ba8:	f240 6354 	movw	r3, #1620	; 0x654
80000bac:	f2c0 230e 	movt	r3, #526	; 0x20e
80000bb0:	f24b 02b1 	movw	r2, #45233	; 0xb0b1
80000bb4:	f361 421f 	bfi	r2, r1, #16, #16
80000bb8:	601a      	str	r2, [r3, #0]
80000bba:	4770      	bx	lr

80000bbc <mxc_serial_setbrg>:
80000bbc:	2390      	movs	r3, #144	; 0x90
80000bbe:	f2c0 2302 	movt	r3, #514	; 0x202
80000bc2:	f44f 7200 	mov.w	r2, #512	; 0x200
80000bc6:	601a      	str	r2, [r3, #0]
80000bc8:	23a4      	movs	r3, #164	; 0xa4
80000bca:	f2c0 2302 	movt	r3, #514	; 0x202
80000bce:	220f      	movs	r2, #15
80000bd0:	601a      	str	r2, [r3, #0]
80000bd2:	23a8      	movs	r3, #168	; 0xa8
80000bd4:	f2c0 2302 	movt	r3, #514	; 0x202
80000bd8:	f240 125b 	movw	r2, #347	; 0x15b
80000bdc:	601a      	str	r2, [r3, #0]
80000bde:	4770      	bx	lr

80000be0 <mxc_serial_putc>:
80000be0:	b508      	push	{r3, lr}
80000be2:	2340      	movs	r3, #64	; 0x40
80000be4:	f2c0 2302 	movt	r3, #514	; 0x202
80000be8:	6018      	str	r0, [r3, #0]
80000bea:	22b4      	movs	r2, #180	; 0xb4
80000bec:	f2c0 2202 	movt	r2, #514	; 0x202
80000bf0:	6813      	ldr	r3, [r2, #0]
80000bf2:	f013 0f40 	tst.w	r3, #64	; 0x40
80000bf6:	d0fb      	beq.n	80000bf0 <mxc_serial_putc+0x10>
80000bf8:	280a      	cmp	r0, #10
80000bfa:	d102      	bne.n	80000c02 <mxc_serial_putc+0x22>
80000bfc:	200d      	movs	r0, #13
80000bfe:	f7ff ffef 	bl	80000be0 <mxc_serial_putc>
80000c02:	bd08      	pop	{r3, pc}

80000c04 <mxc_serial_init>:
80000c04:	b508      	push	{r3, lr}
80000c06:	2380      	movs	r3, #128	; 0x80
80000c08:	f2c0 2302 	movt	r3, #514	; 0x202
80000c0c:	2200      	movs	r2, #0
80000c0e:	601a      	str	r2, [r3, #0]
80000c10:	2384      	movs	r3, #132	; 0x84
80000c12:	f2c0 2302 	movt	r3, #514	; 0x202
80000c16:	601a      	str	r2, [r3, #0]
80000c18:	2284      	movs	r2, #132	; 0x84
80000c1a:	f2c0 2202 	movt	r2, #514	; 0x202
80000c1e:	6813      	ldr	r3, [r2, #0]
80000c20:	f013 0f01 	tst.w	r3, #1
80000c24:	d0fb      	beq.n	80000c1e <mxc_serial_init+0x1a>
80000c26:	2388      	movs	r3, #136	; 0x88
80000c28:	f2c0 2302 	movt	r3, #514	; 0x202
80000c2c:	f240 7284 	movw	r2, #1924	; 0x784
80000c30:	601a      	str	r2, [r3, #0]
80000c32:	238c      	movs	r3, #140	; 0x8c
80000c34:	f2c0 2302 	movt	r3, #514	; 0x202
80000c38:	f44f 4200 	mov.w	r2, #32768	; 0x8000
80000c3c:	601a      	str	r2, [r3, #0]
80000c3e:	239c      	movs	r3, #156	; 0x9c
80000c40:	f2c0 2302 	movt	r3, #514	; 0x202
80000c44:	222b      	movs	r2, #43	; 0x2b
80000c46:	601a      	str	r2, [r3, #0]
80000c48:	23a0      	movs	r3, #160	; 0xa0
80000c4a:	f2c0 2302 	movt	r3, #514	; 0x202
80000c4e:	2200      	movs	r2, #0
80000c50:	601a      	str	r2, [r3, #0]
80000c52:	23b4      	movs	r3, #180	; 0xb4
80000c54:	f2c0 2302 	movt	r3, #514	; 0x202
80000c58:	601a      	str	r2, [r3, #0]
80000c5a:	f7ff ffaf 	bl	80000bbc <mxc_serial_setbrg>
80000c5e:	2384      	movs	r3, #132	; 0x84
80000c60:	f2c0 2302 	movt	r3, #514	; 0x202
80000c64:	f244 0227 	movw	r2, #16423	; 0x4027
80000c68:	601a      	str	r2, [r3, #0]
80000c6a:	2380      	movs	r3, #128	; 0x80
80000c6c:	f2c0 2302 	movt	r3, #514	; 0x202
80000c70:	2201      	movs	r2, #1
80000c72:	601a      	str	r2, [r3, #0]
80000c74:	bd08      	pop	{r3, pc}
80000c76:	bf00      	nop

80000c78 <printint>:
80000c78:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
80000c7c:	b084      	sub	sp, #16
80000c7e:	460f      	mov	r7, r1
80000c80:	4691      	mov	r9, r2
80000c82:	b12a      	cbz	r2, 80000c90 <printint+0x18>
80000c84:	ea4f 79d0 	mov.w	r9, r0, lsr #31
80000c88:	2800      	cmp	r0, #0
80000c8a:	bfb8      	it	lt
80000c8c:	4245      	neglt	r5, r0
80000c8e:	db00      	blt.n	80000c92 <printint+0x1a>
80000c90:	4605      	mov	r5, r0
80000c92:	f10d 36ff 	add.w	r6, sp, #4294967295	; 0xffffffff
80000c96:	f04f 0800 	mov.w	r8, #0
80000c9a:	f640 7a68 	movw	sl, #3944	; 0xf68
80000c9e:	f2c8 0a00 	movt	sl, #32768	; 0x8000
80000ca2:	e000      	b.n	80000ca6 <printint+0x2e>
80000ca4:	46a0      	mov	r8, r4
80000ca6:	f108 0401 	add.w	r4, r8, #1
80000caa:	4639      	mov	r1, r7
80000cac:	4628      	mov	r0, r5
80000cae:	f000 e94a 	blx	80000f44 <__aeabi_uidivmod>
80000cb2:	f81a 3001 	ldrb.w	r3, [sl, r1]
80000cb6:	f806 3f01 	strb.w	r3, [r6, #1]!
80000cba:	4639      	mov	r1, r7
80000cbc:	4628      	mov	r0, r5
80000cbe:	f000 e8c8 	blx	80000e50 <__aeabi_uidiv>
80000cc2:	4605      	mov	r5, r0
80000cc4:	2800      	cmp	r0, #0
80000cc6:	d1ed      	bne.n	80000ca4 <printint+0x2c>
80000cc8:	f1b9 0f00 	cmp.w	r9, #0
80000ccc:	d006      	beq.n	80000cdc <printint+0x64>
80000cce:	ab04      	add	r3, sp, #16
80000cd0:	441c      	add	r4, r3
80000cd2:	232d      	movs	r3, #45	; 0x2d
80000cd4:	f804 3c10 	strb.w	r3, [r4, #-16]
80000cd8:	f108 0402 	add.w	r4, r8, #2
80000cdc:	2c01      	cmp	r4, #1
80000cde:	d407      	bmi.n	80000cf0 <printint+0x78>
80000ce0:	466d      	mov	r5, sp
80000ce2:	446c      	add	r4, sp
80000ce4:	f814 0d01 	ldrb.w	r0, [r4, #-1]!
80000ce8:	f7ff ff7a 	bl	80000be0 <mxc_serial_putc>
80000cec:	42ac      	cmp	r4, r5
80000cee:	d1f9      	bne.n	80000ce4 <printint+0x6c>
80000cf0:	b004      	add	sp, #16
80000cf2:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
80000cf6:	bf00      	nop

80000cf8 <cprintf>:
80000cf8:	b40f      	push	{r0, r1, r2, r3}
80000cfa:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
80000cfe:	9e08      	ldr	r6, [sp, #32]
80000d00:	7830      	ldrb	r0, [r6, #0]
80000d02:	2800      	cmp	r0, #0
80000d04:	d058      	beq.n	80000db8 <cprintf+0xc0>
80000d06:	4603      	mov	r3, r0
80000d08:	f10d 0a24 	add.w	sl, sp, #36	; 0x24
80000d0c:	2400      	movs	r4, #0
80000d0e:	46a1      	mov	r9, r4
80000d10:	f04f 0810 	mov.w	r8, #16
80000d14:	f640 777c 	movw	r7, #3964	; 0xf7c
80000d18:	f2c8 0700 	movt	r7, #32768	; 0x8000
80000d1c:	2b25      	cmp	r3, #37	; 0x25
80000d1e:	d002      	beq.n	80000d26 <cprintf+0x2e>
80000d20:	f7ff ff5e 	bl	80000be0 <mxc_serial_putc>
80000d24:	e043      	b.n	80000dae <cprintf+0xb6>
80000d26:	3401      	adds	r4, #1
80000d28:	5d35      	ldrb	r5, [r6, r4]
80000d2a:	2d00      	cmp	r5, #0
80000d2c:	d044      	beq.n	80000db8 <cprintf+0xc0>
80000d2e:	2d70      	cmp	r5, #112	; 0x70
80000d30:	d014      	beq.n	80000d5c <cprintf+0x64>
80000d32:	d804      	bhi.n	80000d3e <cprintf+0x46>
80000d34:	2d25      	cmp	r5, #37	; 0x25
80000d36:	d02e      	beq.n	80000d96 <cprintf+0x9e>
80000d38:	2d64      	cmp	r5, #100	; 0x64
80000d3a:	d005      	beq.n	80000d48 <cprintf+0x50>
80000d3c:	e02f      	b.n	80000d9e <cprintf+0xa6>
80000d3e:	2d73      	cmp	r5, #115	; 0x73
80000d40:	d016      	beq.n	80000d70 <cprintf+0x78>
80000d42:	2d78      	cmp	r5, #120	; 0x78
80000d44:	d00a      	beq.n	80000d5c <cprintf+0x64>
80000d46:	e02a      	b.n	80000d9e <cprintf+0xa6>
80000d48:	f10a 0504 	add.w	r5, sl, #4
80000d4c:	2201      	movs	r2, #1
80000d4e:	210a      	movs	r1, #10
80000d50:	f8da 0000 	ldr.w	r0, [sl]
80000d54:	f7ff ff90 	bl	80000c78 <printint>
80000d58:	46aa      	mov	sl, r5
80000d5a:	e028      	b.n	80000dae <cprintf+0xb6>
80000d5c:	f10a 0504 	add.w	r5, sl, #4
80000d60:	464a      	mov	r2, r9
80000d62:	4641      	mov	r1, r8
80000d64:	f8da 0000 	ldr.w	r0, [sl]
80000d68:	f7ff ff86 	bl	80000c78 <printint>
80000d6c:	46aa      	mov	sl, r5
80000d6e:	e01e      	b.n	80000dae <cprintf+0xb6>
80000d70:	f10a 0504 	add.w	r5, sl, #4
80000d74:	f8da a000 	ldr.w	sl, [sl]
80000d78:	f1ba 0f00 	cmp.w	sl, #0
80000d7c:	bf08      	it	eq
80000d7e:	46ba      	moveq	sl, r7
80000d80:	f89a 0000 	ldrb.w	r0, [sl]
80000d84:	b190      	cbz	r0, 80000dac <cprintf+0xb4>
80000d86:	f7ff ff2b 	bl	80000be0 <mxc_serial_putc>
80000d8a:	f81a 0f01 	ldrb.w	r0, [sl, #1]!
80000d8e:	2800      	cmp	r0, #0
80000d90:	d1f9      	bne.n	80000d86 <cprintf+0x8e>
80000d92:	46aa      	mov	sl, r5
80000d94:	e00b      	b.n	80000dae <cprintf+0xb6>
80000d96:	2025      	movs	r0, #37	; 0x25
80000d98:	f7ff ff22 	bl	80000be0 <mxc_serial_putc>
80000d9c:	e007      	b.n	80000dae <cprintf+0xb6>
80000d9e:	2025      	movs	r0, #37	; 0x25
80000da0:	f7ff ff1e 	bl	80000be0 <mxc_serial_putc>
80000da4:	4628      	mov	r0, r5
80000da6:	f7ff ff1b 	bl	80000be0 <mxc_serial_putc>
80000daa:	e000      	b.n	80000dae <cprintf+0xb6>
80000dac:	46aa      	mov	sl, r5
80000dae:	3401      	adds	r4, #1
80000db0:	5d30      	ldrb	r0, [r6, r4]
80000db2:	4603      	mov	r3, r0
80000db4:	2800      	cmp	r0, #0
80000db6:	d1b1      	bne.n	80000d1c <cprintf+0x24>
80000db8:	e8bd 47f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
80000dbc:	b004      	add	sp, #16
80000dbe:	4770      	bx	lr

80000dc0 <esrg_Interrupt_Handler>:
80000dc0:	b538      	push	{r3, r4, r5, lr}
80000dc2:	f7ff ecae 	blx	80000720 <readIntAck>
80000dc6:	4604      	mov	r4, r0
80000dc8:	f410 7f00 	tst.w	r0, #512	; 0x200
80000dcc:	d002      	beq.n	80000dd4 <esrg_Interrupt_Handler+0x14>
80000dce:	f7ff ecae 	blx	8000072c <writeEOI>
80000dd2:	bd38      	pop	{r3, r4, r5, pc}
80000dd4:	f3c0 2582 	ubfx	r5, r0, #10, #3
80000dd8:	f3c0 0308 	ubfx	r3, r0, #0, #9
80000ddc:	f640 72a4 	movw	r2, #4004	; 0xfa4
80000de0:	f2c8 0200 	movt	r2, #32768	; 0x8000
80000de4:	f842 3025 	str.w	r3, [r2, r5, lsl #2]
80000de8:	f640 72b4 	movw	r2, #4020	; 0xfb4
80000dec:	f2c8 0200 	movt	r2, #32768	; 0x8000
80000df0:	f852 3023 	ldr.w	r3, [r2, r3, lsl #2]
80000df4:	b103      	cbz	r3, 80000df8 <esrg_Interrupt_Handler+0x38>
80000df6:	4798      	blx	r3
80000df8:	f640 73a4 	movw	r3, #4004	; 0xfa4
80000dfc:	f2c8 0300 	movt	r3, #32768	; 0x8000
80000e00:	2200      	movs	r2, #0
80000e02:	f843 2025 	str.w	r2, [r3, r5, lsl #2]
80000e06:	4620      	mov	r0, r4
80000e08:	f7ff ec90 	blx	8000072c <writeEOI>
80000e0c:	bd38      	pop	{r3, r4, r5, pc}
80000e0e:	bf00      	nop

80000e10 <esrg_Disable_Interrupt>:
80000e10:	b508      	push	{r3, lr}
80000e12:	f7ff ec0a 	blx	80000628 <disableIntID>
80000e16:	bd08      	pop	{r3, pc}

80000e18 <esrg_Enable_Interrupt>:
80000e18:	b538      	push	{r3, r4, r5, lr}
80000e1a:	4604      	mov	r4, r0
80000e1c:	460d      	mov	r5, r1
80000e1e:	4611      	mov	r1, r2
80000e20:	f7ff ec18 	blx	80000654 <setIntPriority>
80000e24:	4620      	mov	r0, r4
80000e26:	f7ff ecc6 	blx	800007b4 <makeIntNonSecure>
80000e2a:	4629      	mov	r1, r5
80000e2c:	4620      	mov	r0, r4
80000e2e:	f7ff ec36 	blx	8000069c <setIntTarget>
80000e32:	4620      	mov	r0, r4
80000e34:	f7ff ebe2 	blx	800005fc <enableIntID>
80000e38:	bd38      	pop	{r3, r4, r5, pc}
80000e3a:	bf00      	nop

80000e3c <esrg_Register_IRS>:
80000e3c:	f640 73b4 	movw	r3, #4020	; 0xfb4
80000e40:	f2c8 0300 	movt	r3, #32768	; 0x8000
80000e44:	f843 1020 	str.w	r1, [r3, r0, lsl #2]
80000e48:	4770      	bx	lr
80000e4a:	bf00      	nop

80000e4c <esrg_Default_ISR>:
80000e4c:	4770      	bx	lr
80000e4e:	bf00      	nop

80000e50 <__aeabi_uidiv>:
80000e50:	e2512001 	subs	r2, r1, #1
80000e54:	012fff1e 	bxeq	lr
80000e58:	3a000036 	bcc	80000f38 <__aeabi_uidiv+0xe8>
80000e5c:	e1500001 	cmp	r0, r1
80000e60:	9a000022 	bls	80000ef0 <__aeabi_uidiv+0xa0>
80000e64:	e1110002 	tst	r1, r2
80000e68:	0a000023 	beq	80000efc <__aeabi_uidiv+0xac>
80000e6c:	e311020e 	tst	r1, #-536870912	; 0xe0000000
80000e70:	01a01181 	lsleq	r1, r1, #3
80000e74:	03a03008 	moveq	r3, #8
80000e78:	13a03001 	movne	r3, #1
80000e7c:	e3510201 	cmp	r1, #268435456	; 0x10000000
80000e80:	31510000 	cmpcc	r1, r0
80000e84:	31a01201 	lslcc	r1, r1, #4
80000e88:	31a03203 	lslcc	r3, r3, #4
80000e8c:	3afffffa 	bcc	80000e7c <__aeabi_uidiv+0x2c>
80000e90:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
80000e94:	31510000 	cmpcc	r1, r0
80000e98:	31a01081 	lslcc	r1, r1, #1
80000e9c:	31a03083 	lslcc	r3, r3, #1
80000ea0:	3afffffa 	bcc	80000e90 <__aeabi_uidiv+0x40>
80000ea4:	e3a02000 	mov	r2, #0
80000ea8:	e1500001 	cmp	r0, r1
80000eac:	20400001 	subcs	r0, r0, r1
80000eb0:	21822003 	orrcs	r2, r2, r3
80000eb4:	e15000a1 	cmp	r0, r1, lsr #1
80000eb8:	204000a1 	subcs	r0, r0, r1, lsr #1
80000ebc:	218220a3 	orrcs	r2, r2, r3, lsr #1
80000ec0:	e1500121 	cmp	r0, r1, lsr #2
80000ec4:	20400121 	subcs	r0, r0, r1, lsr #2
80000ec8:	21822123 	orrcs	r2, r2, r3, lsr #2
80000ecc:	e15001a1 	cmp	r0, r1, lsr #3
80000ed0:	204001a1 	subcs	r0, r0, r1, lsr #3
80000ed4:	218221a3 	orrcs	r2, r2, r3, lsr #3
80000ed8:	e3500000 	cmp	r0, #0
80000edc:	11b03223 	lsrsne	r3, r3, #4
80000ee0:	11a01221 	lsrne	r1, r1, #4
80000ee4:	1affffef 	bne	80000ea8 <__aeabi_uidiv+0x58>
80000ee8:	e1a00002 	mov	r0, r2
80000eec:	e12fff1e 	bx	lr
80000ef0:	03a00001 	moveq	r0, #1
80000ef4:	13a00000 	movne	r0, #0
80000ef8:	e12fff1e 	bx	lr
80000efc:	e3510801 	cmp	r1, #65536	; 0x10000
80000f00:	21a01821 	lsrcs	r1, r1, #16
80000f04:	23a02010 	movcs	r2, #16
80000f08:	33a02000 	movcc	r2, #0
80000f0c:	e3510c01 	cmp	r1, #256	; 0x100
80000f10:	21a01421 	lsrcs	r1, r1, #8
80000f14:	22822008 	addcs	r2, r2, #8
80000f18:	e3510010 	cmp	r1, #16
80000f1c:	21a01221 	lsrcs	r1, r1, #4
80000f20:	22822004 	addcs	r2, r2, #4
80000f24:	e3510004 	cmp	r1, #4
80000f28:	82822003 	addhi	r2, r2, #3
80000f2c:	908220a1 	addls	r2, r2, r1, lsr #1
80000f30:	e1a00230 	lsr	r0, r0, r2
80000f34:	e12fff1e 	bx	lr
80000f38:	e3500000 	cmp	r0, #0
80000f3c:	13e00000 	mvnne	r0, #0
80000f40:	ea000007 	b	80000f64 <__aeabi_idiv0>

80000f44 <__aeabi_uidivmod>:
80000f44:	e3510000 	cmp	r1, #0
80000f48:	0afffffa 	beq	80000f38 <__aeabi_uidiv+0xe8>
80000f4c:	e92d4003 	push	{r0, r1, lr}
80000f50:	ebffffbe 	bl	80000e50 <__aeabi_uidiv>
80000f54:	e8bd4006 	pop	{r1, r2, lr}
80000f58:	e0030092 	mul	r3, r2, r0
80000f5c:	e0411003 	sub	r1, r1, r3
80000f60:	e12fff1e 	bx	lr

80000f64 <__aeabi_idiv0>:
80000f64:	e12fff1e 	bx	lr

Disassembly of section .rodata:

80000f68 <digits.4198>:
80000f68:	33323130 	teqcc	r2, #48, 2
80000f6c:	37363534 			; <UNDEFINED> instruction: 0x37363534
80000f70:	62613938 	rsbvs	r3, r1, #56, 18	; 0xe0000
80000f74:	66656463 	strbtvs	r6, [r5], -r3, ror #8
80000f78:	00000000 	andeq	r0, r0, r0
80000f7c:	6c756e28 	ldclvs	14, cr6, [r5], #-160	; 0xffffff60
80000f80:	0000296c 	andeq	r2, r0, ip, ror #18

Disassembly of section .bss:

80000fa0 <__bss_start__>:
80000fa0:	00000000 	andeq	r0, r0, r0

80000fa4 <g_vectNum>:
	...

80000fb4 <esrg_ISR_Vector>:
	...

Disassembly of section .heap:

800011b4 <__end__-0xc>:
	...

800011c0 <__end__>:
	...

Disassembly of section .stack:

800a11c0 <__stack-0x10000>:
	...

Disassembly of section .irq_stacks:

800b11c0 <__irq_stack-0x400>:
	...

Disassembly of section .pagetable:

80500000 <__pagetable_start>:
	...

Disassembly of section .framebuffer:

80600000 <__framebuffer_start>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00003841 	andeq	r3, r0, r1, asr #16
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	0000002e 	andeq	r0, r0, lr, lsr #32
  10:	726f4305 	rsbvc	r4, pc, #335544320	; 0x14000000
  14:	2d786574 	cfldr64cs	mvdx6, [r8, #-464]!	; 0xfffffe30
  18:	06003941 	streq	r3, [r0], -r1, asr #18
  1c:	0841070a 	stmdaeq	r1, {r1, r3, r8, r9, sl}^
  20:	0a020901 	beq	8242c <L1_COHERENT+0x6d826>
  24:	14041204 	strne	r1, [r4], #-516	; 0xfffffdfc
  28:	17011501 	strne	r1, [r1, -r1, lsl #10]
  2c:	1a011803 	bne	46040 <L1_COHERENT+0x3143a>
  30:	22011c01 	andcs	r1, r1, #256	; 0x100
  34:	44012a01 	strmi	r2, [r1], #-2561	; 0xfffff5ff
  38:	Address 0x0000000000000038 is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <L1_COHERENT+0x10bc11e>
   4:	35312820 	ldrcc	r2, [r1, #-2080]!	; 0xfffff7e0
   8:	342e353a 	strtcc	r3, [lr], #-1338	; 0xfffffac6
   c:	732b312e 			; <UNDEFINED> instruction: 0x732b312e
  10:	34326e76 	ldrtcc	r6, [r2], #-3702	; 0xfffff18a
  14:	35353131 	ldrcc	r3, [r5, #-305]!	; 0xfffffecf
  18:	2029312d 	eorcs	r3, r9, sp, lsr #2
  1c:	2e342e35 	mrccs	14, 1, r2, cr4, cr5, {1}
  20:	30322031 	eorscc	r2, r2, r1, lsr r0
  24:	39303631 	ldmdbcc	r0!, {r0, r4, r5, r9, sl, ip, sp}
  28:	Address 0x0000000000000028 is out of bounds.


Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	andeq	r0, r0, ip
   4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
   8:	7c020001 	stcvc	0, cr0, [r2], {1}
   c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  10:	0000000c 	andeq	r0, r0, ip
  14:	00000000 	andeq	r0, r0, r0
  18:	80000280 	andhi	r0, r0, r0, lsl #5
  1c:	00000008 	andeq	r0, r0, r8
  20:	0000000c 	andeq	r0, r0, ip
  24:	00000000 	andeq	r0, r0, r0
  28:	80000288 	andhi	r0, r0, r8, lsl #5
  2c:	00000008 	andeq	r0, r0, r8
  30:	0000000c 	andeq	r0, r0, ip
  34:	00000000 	andeq	r0, r0, r0
  38:	80000290 	mulhi	r0, r0, r2
  3c:	00000014 	andeq	r0, r0, r4, lsl r0
  40:	0000000c 	andeq	r0, r0, ip
  44:	00000000 	andeq	r0, r0, r0
  48:	800002a4 	andhi	r0, r0, r4, lsr #5
  4c:	00000014 	andeq	r0, r0, r4, lsl r0
  50:	0000000c 	andeq	r0, r0, ip
  54:	00000000 	andeq	r0, r0, r0
  58:	800002b8 			; <UNDEFINED> instruction: 0x800002b8
  5c:	00000088 	andeq	r0, r0, r8, lsl #1
  60:	0000000c 	andeq	r0, r0, ip
  64:	00000000 	andeq	r0, r0, r0
  68:	80000340 	andhi	r0, r0, r0, asr #6
  6c:	00000088 	andeq	r0, r0, r8, lsl #1
  70:	0000000c 	andeq	r0, r0, ip
  74:	00000000 	andeq	r0, r0, r0
  78:	800003c8 	andhi	r0, r0, r8, asr #7
  7c:	00000090 	muleq	r0, r0, r0
  80:	0000000c 	andeq	r0, r0, ip
  84:	00000000 	andeq	r0, r0, r0
  88:	80000458 	andhi	r0, r0, r8, asr r4
  8c:	00000090 	muleq	r0, r0, r0
  90:	0000000c 	andeq	r0, r0, ip
  94:	00000000 	andeq	r0, r0, r0
  98:	800004e8 	andhi	r0, r0, r8, ror #9
  9c:	0000000c 	andeq	r0, r0, ip
  a0:	0000000c 	andeq	r0, r0, ip
  a4:	00000000 	andeq	r0, r0, r0
  a8:	800004f4 	strdhi	r0, [r0], -r4
  ac:	0000000c 	andeq	r0, r0, ip
  b0:	0000000c 	andeq	r0, r0, ip
  b4:	00000000 	andeq	r0, r0, r0
  b8:	80000500 	andhi	r0, r0, r0, lsl #10
  bc:	00000010 	andeq	r0, r0, r0, lsl r0
  c0:	0000000c 	andeq	r0, r0, ip
  c4:	00000000 	andeq	r0, r0, r0
  c8:	80000510 	andhi	r0, r0, r0, lsl r5
  cc:	00000010 	andeq	r0, r0, r0, lsl r0
  d0:	0000000c 	andeq	r0, r0, ip
  d4:	00000000 	andeq	r0, r0, r0
  d8:	80000520 	andhi	r0, r0, r0, lsr #10
  dc:	0000000c 	andeq	r0, r0, ip
  e0:	0000000c 	andeq	r0, r0, ip
  e4:	00000000 	andeq	r0, r0, r0
  e8:	8000052c 	andhi	r0, r0, ip, lsr #10
  ec:	0000000c 	andeq	r0, r0, ip
  f0:	0000000c 	andeq	r0, r0, ip
  f4:	00000000 	andeq	r0, r0, r0
  f8:	80000538 	andhi	r0, r0, r8, lsr r5
  fc:	00000010 	andeq	r0, r0, r0, lsl r0
 100:	0000000c 	andeq	r0, r0, ip
 104:	00000000 	andeq	r0, r0, r0
 108:	80000548 	andhi	r0, r0, r8, asr #10
 10c:	00000010 	andeq	r0, r0, r0, lsl r0
 110:	0000000c 	andeq	r0, r0, ip
 114:	00000000 	andeq	r0, r0, r0
 118:	80000558 	andhi	r0, r0, r8, asr r5
 11c:	00000008 	andeq	r0, r0, r8
 120:	0000000c 	andeq	r0, r0, ip
 124:	00000000 	andeq	r0, r0, r0
 128:	80000560 	andhi	r0, r0, r0, ror #10
 12c:	00000008 	andeq	r0, r0, r8
 130:	0000000c 	andeq	r0, r0, ip
 134:	00000000 	andeq	r0, r0, r0
 138:	80000568 	andhi	r0, r0, r8, ror #10
 13c:	00000008 	andeq	r0, r0, r8
 140:	0000000c 	andeq	r0, r0, ip
 144:	00000000 	andeq	r0, r0, r0
 148:	80000570 	andhi	r0, r0, r0, ror r5
 14c:	00000008 	andeq	r0, r0, r8
 150:	0000000c 	andeq	r0, r0, ip
 154:	00000000 	andeq	r0, r0, r0
 158:	80000578 	andhi	r0, r0, r8, ror r5
 15c:	00000008 	andeq	r0, r0, r8
 160:	0000000c 	andeq	r0, r0, ip
 164:	00000000 	andeq	r0, r0, r0
 168:	80000580 	andhi	r0, r0, r0, lsl #11
 16c:	0000000c 	andeq	r0, r0, ip
 170:	0000000c 	andeq	r0, r0, ip
 174:	00000000 	andeq	r0, r0, r0
 178:	8000058c 	andhi	r0, r0, ip, lsl #11
 17c:	00000010 	andeq	r0, r0, r0, lsl r0
 180:	0000000c 	andeq	r0, r0, ip
 184:	00000000 	andeq	r0, r0, r0
 188:	8000059c 	mulhi	r0, ip, r5
 18c:	00000018 	andeq	r0, r0, r8, lsl r0
 190:	0000000c 	andeq	r0, r0, ip
 194:	00000000 	andeq	r0, r0, r0
 198:	800005b4 			; <UNDEFINED> instruction: 0x800005b4
 19c:	00000010 	andeq	r0, r0, r0, lsl r0
 1a0:	0000000c 	andeq	r0, r0, ip
 1a4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1a8:	7c020001 	stcvc	0, cr0, [r2], {1}
 1ac:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1b0:	0000000c 	andeq	r0, r0, ip
 1b4:	000001a0 	andeq	r0, r0, r0, lsr #3
 1b8:	800005cc 	andhi	r0, r0, ip, asr #11
 1bc:	00000018 	andeq	r0, r0, r8, lsl r0
 1c0:	0000000c 	andeq	r0, r0, ip
 1c4:	000001a0 	andeq	r0, r0, r0, lsr #3
 1c8:	800005e4 	andhi	r0, r0, r4, ror #11
 1cc:	00000018 	andeq	r0, r0, r8, lsl r0
 1d0:	0000000c 	andeq	r0, r0, ip
 1d4:	000001a0 	andeq	r0, r0, r0, lsr #3
 1d8:	800005fc 	strdhi	r0, [r0], -ip
 1dc:	0000002c 	andeq	r0, r0, ip, lsr #32
 1e0:	0000000c 	andeq	r0, r0, ip
 1e4:	000001a0 	andeq	r0, r0, r0, lsr #3
 1e8:	80000628 	andhi	r0, r0, r8, lsr #12
 1ec:	0000002c 	andeq	r0, r0, ip, lsr #32
 1f0:	0000000c 	andeq	r0, r0, ip
 1f4:	000001a0 	andeq	r0, r0, r0, lsr #3
 1f8:	80000654 	andhi	r0, r0, r4, asr r6
 1fc:	00000044 	andeq	r0, r0, r4, asr #32
 200:	0000000c 	andeq	r0, r0, ip
 204:	000001a0 	andeq	r0, r0, r0, lsr #3
 208:	80000698 	mulhi	r0, r8, r6
 20c:	00000004 	andeq	r0, r0, r4
 210:	0000000c 	andeq	r0, r0, ip
 214:	000001a0 	andeq	r0, r0, r0, lsr #3
 218:	8000069c 	mulhi	r0, ip, r6
 21c:	0000003c 	andeq	r0, r0, ip, lsr r0
 220:	0000000c 	andeq	r0, r0, ip
 224:	000001a0 	andeq	r0, r0, r0, lsr #3
 228:	800006d8 	ldrdhi	r0, [r0], -r8
 22c:	00000004 	andeq	r0, r0, r4
 230:	0000000c 	andeq	r0, r0, ip
 234:	000001a0 	andeq	r0, r0, r0, lsr #3
 238:	800006dc 	ldrdhi	r0, [r0], -ip
 23c:	00000018 	andeq	r0, r0, r8, lsl r0
 240:	0000000c 	andeq	r0, r0, ip
 244:	000001a0 	andeq	r0, r0, r0, lsr #3
 248:	800006f4 	strdhi	r0, [r0], -r4
 24c:	00000014 	andeq	r0, r0, r4, lsl r0
 250:	0000000c 	andeq	r0, r0, ip
 254:	000001a0 	andeq	r0, r0, r0, lsr #3
 258:	80000708 	andhi	r0, r0, r8, lsl #14
 25c:	0000000c 	andeq	r0, r0, ip
 260:	0000000c 	andeq	r0, r0, ip
 264:	000001a0 	andeq	r0, r0, r0, lsr #3
 268:	80000714 	andhi	r0, r0, r4, lsl r7
 26c:	0000000c 	andeq	r0, r0, ip
 270:	0000000c 	andeq	r0, r0, ip
 274:	000001a0 	andeq	r0, r0, r0, lsr #3
 278:	80000720 	andhi	r0, r0, r0, lsr #14
 27c:	0000000c 	andeq	r0, r0, ip
 280:	0000000c 	andeq	r0, r0, ip
 284:	000001a0 	andeq	r0, r0, r0, lsr #3
 288:	8000072c 	andhi	r0, r0, ip, lsr #14
 28c:	0000000c 	andeq	r0, r0, ip
 290:	0000000c 	andeq	r0, r0, ip
 294:	000001a0 	andeq	r0, r0, r0, lsr #3
 298:	80000738 	andhi	r0, r0, r8, lsr r7
 29c:	00000024 	andeq	r0, r0, r4, lsr #32
 2a0:	0000000c 	andeq	r0, r0, ip
 2a4:	000001a0 	andeq	r0, r0, r0, lsr #3
 2a8:	8000075c 	andhi	r0, r0, ip, asr r7
 2ac:	00000014 	andeq	r0, r0, r4, lsl r0
 2b0:	0000000c 	andeq	r0, r0, ip
 2b4:	000001a0 	andeq	r0, r0, r0, lsr #3
 2b8:	80000770 	andhi	r0, r0, r0, ror r7
 2bc:	00000014 	andeq	r0, r0, r4, lsl r0
 2c0:	0000000c 	andeq	r0, r0, ip
 2c4:	000001a0 	andeq	r0, r0, r0, lsr #3
 2c8:	80000784 	andhi	r0, r0, r4, lsl #15
 2cc:	00000030 	andeq	r0, r0, r0, lsr r0
 2d0:	0000000c 	andeq	r0, r0, ip
 2d4:	000001a0 	andeq	r0, r0, r0, lsr #3
 2d8:	800007b4 			; <UNDEFINED> instruction: 0x800007b4
 2dc:	00000030 	andeq	r0, r0, r0, lsr r0
 2e0:	0000000c 	andeq	r0, r0, ip
 2e4:	000001a0 	andeq	r0, r0, r0, lsr #3
 2e8:	800007e4 	andhi	r0, r0, r4, ror #15
 2ec:	00000004 	andeq	r0, r0, r4
 2f0:	0000000c 	andeq	r0, r0, ip
 2f4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 2f8:	7c020001 	stcvc	0, cr0, [r2], {1}
 2fc:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 300:	0000000c 	andeq	r0, r0, ip
 304:	000002f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 308:	800008c0 	andhi	r0, r0, r0, asr #17
 30c:	0000000c 	andeq	r0, r0, ip
 310:	0000000c 	andeq	r0, r0, ip
 314:	000002f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 318:	800008cc 	andhi	r0, r0, ip, asr #17
 31c:	0000002c 	andeq	r0, r0, ip, lsr #32
 320:	0000000c 	andeq	r0, r0, ip
 324:	000002f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 328:	800008f8 	strdhi	r0, [r0], -r8
 32c:	00000034 	andeq	r0, r0, r4, lsr r0
 330:	0000000c 	andeq	r0, r0, ip
 334:	000002f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 338:	8000092c 	andhi	r0, r0, ip, lsr #18
 33c:	00000014 	andeq	r0, r0, r4, lsl r0
 340:	0000000c 	andeq	r0, r0, ip
 344:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 348:	7c020001 	stcvc	0, cr0, [r2], {1}
 34c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 350:	00000014 	andeq	r0, r0, r4, lsl r0
 354:	00000340 	andeq	r0, r0, r0, asr #6
 358:	80000940 	andhi	r0, r0, r0, asr #18
 35c:	000000a0 	andeq	r0, r0, r0, lsr #1
 360:	02100e41 	andseq	r0, r0, #1040	; 0x410
 364:	00000e4e 	andeq	r0, r0, lr, asr #28
 368:	0000000c 	andeq	r0, r0, ip
 36c:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 370:	7c020001 	stcvc	0, cr0, [r2], {1}
 374:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 378:	00000014 	andeq	r0, r0, r4, lsl r0
 37c:	00000368 	andeq	r0, r0, r8, ror #6
 380:	800009e0 	andhi	r0, r0, r0, ror #19
 384:	0000000a 	andeq	r0, r0, sl
 388:	83080e41 	movwhi	r0, #36417	; 0x8e41
 38c:	00018e02 	andeq	r8, r1, r2, lsl #28
 390:	00000014 	andeq	r0, r0, r4, lsl r0
 394:	00000368 	andeq	r0, r0, r8, ror #6
 398:	800009ec 	andhi	r0, r0, ip, ror #19
 39c:	0000002c 	andeq	r0, r0, ip, lsr #32
 3a0:	83080e41 	movwhi	r0, #36417	; 0x8e41
 3a4:	00018e02 	andeq	r8, r1, r2, lsl #28
 3a8:	00000014 	andeq	r0, r0, r4, lsl r0
 3ac:	00000368 	andeq	r0, r0, r8, ror #6
 3b0:	80000a18 	andhi	r0, r0, r8, lsl sl
 3b4:	00000066 	andeq	r0, r0, r6, rrx
 3b8:	83080e41 	movwhi	r0, #36417	; 0x8e41
 3bc:	00018e02 	andeq	r8, r1, r2, lsl #28
 3c0:	00000014 	andeq	r0, r0, r4, lsl r0
 3c4:	00000368 	andeq	r0, r0, r8, ror #6
 3c8:	80000a80 	andhi	r0, r0, r0, lsl #21
 3cc:	00000010 	andeq	r0, r0, r0, lsl r0
 3d0:	83080e41 	movwhi	r0, #36417	; 0x8e41
 3d4:	00018e02 	andeq	r8, r1, r2, lsl #28
 3d8:	00000014 	andeq	r0, r0, r4, lsl r0
 3dc:	00000368 	andeq	r0, r0, r8, ror #6
 3e0:	80000a90 	mulhi	r0, r0, sl
 3e4:	00000010 	andeq	r0, r0, r0, lsl r0
 3e8:	83080e41 	movwhi	r0, #36417	; 0x8e41
 3ec:	00018e02 	andeq	r8, r1, r2, lsl #28
 3f0:	0000000c 	andeq	r0, r0, ip
 3f4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 3f8:	7c020001 	stcvc	0, cr0, [r2], {1}
 3fc:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 400:	0000000c 	andeq	r0, r0, ip
 404:	000003f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 408:	80000aa0 	andhi	r0, r0, r0, lsr #21
 40c:	00000014 	andeq	r0, r0, r4, lsl r0
 410:	0000000c 	andeq	r0, r0, ip
 414:	000003f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 418:	80000ab4 			; <UNDEFINED> instruction: 0x80000ab4
 41c:	00000018 	andeq	r0, r0, r8, lsl r0
 420:	0000000c 	andeq	r0, r0, ip
 424:	000003f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 428:	80000acc 	andhi	r0, r0, ip, asr #21
 42c:	00000018 	andeq	r0, r0, r8, lsl r0
 430:	00000014 	andeq	r0, r0, r4, lsl r0
 434:	000003f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 438:	80000ae4 	andhi	r0, r0, r4, ror #21
 43c:	00000016 	andeq	r0, r0, r6, lsl r0
 440:	84080e41 	strhi	r0, [r8], #-3649	; 0xfffff1bf
 444:	00018e02 	andeq	r8, r1, r2, lsl #28
 448:	00000014 	andeq	r0, r0, r4, lsl r0
 44c:	000003f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 450:	80000afc 	strdhi	r0, [r0], -ip
 454:	0000001e 	andeq	r0, r0, lr, lsl r0
 458:	84080e41 	strhi	r0, [r8], #-3649	; 0xfffff1bf
 45c:	00018e02 	andeq	r8, r1, r2, lsl #28
 460:	0000000c 	andeq	r0, r0, ip
 464:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 468:	7c020001 	stcvc	0, cr0, [r2], {1}
 46c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 470:	00000018 	andeq	r0, r0, r8, lsl r0
 474:	00000460 	andeq	r0, r0, r0, ror #8
 478:	80000b1c 	andhi	r0, r0, ip, lsl fp
 47c:	00000058 	andeq	r0, r0, r8, asr r0
 480:	84080e41 	strhi	r0, [r8], #-3649	; 0xfffff1bf
 484:	6a018502 	bvs	61894 <L1_COHERENT+0x4cc8e>
 488:	000ec4c5 	andeq	ip, lr, r5, asr #9
 48c:	0000000c 	andeq	r0, r0, ip
 490:	00000460 	andeq	r0, r0, r0, ror #8
 494:	80000b74 	andhi	r0, r0, r4, ror fp
 498:	00000048 	andeq	r0, r0, r8, asr #32
 49c:	0000000c 	andeq	r0, r0, ip
 4a0:	00000460 	andeq	r0, r0, r0, ror #8
 4a4:	80000bbc 			; <UNDEFINED> instruction: 0x80000bbc
 4a8:	00000024 	andeq	r0, r0, r4, lsr #32
 4ac:	00000014 	andeq	r0, r0, r4, lsl r0
 4b0:	00000460 	andeq	r0, r0, r0, ror #8
 4b4:	80000be0 	andhi	r0, r0, r0, ror #23
 4b8:	00000024 	andeq	r0, r0, r4, lsr #32
 4bc:	83080e41 	movwhi	r0, #36417	; 0x8e41
 4c0:	00018e02 	andeq	r8, r1, r2, lsl #28
 4c4:	00000014 	andeq	r0, r0, r4, lsl r0
 4c8:	00000460 	andeq	r0, r0, r0, ror #8
 4cc:	80000c04 	andhi	r0, r0, r4, lsl #24
 4d0:	00000072 	andeq	r0, r0, r2, ror r0
 4d4:	83080e41 	movwhi	r0, #36417	; 0x8e41
 4d8:	00018e02 	andeq	r8, r1, r2, lsl #28
 4dc:	00000028 	andeq	r0, r0, r8, lsr #32
 4e0:	00000460 	andeq	r0, r0, r0, ror #8
 4e4:	80000c78 	andhi	r0, r0, r8, ror ip
 4e8:	0000007e 	andeq	r0, r0, lr, ror r0
 4ec:	84200e42 	strthi	r0, [r0], #-3650	; 0xfffff1be
 4f0:	86078508 	strhi	r8, [r7], -r8, lsl #10
 4f4:	88058706 	stmdahi	r5, {r1, r2, r8, r9, sl, pc}
 4f8:	8a038904 	bhi	e2910 <L1_COHERENT+0xcdd0a>
 4fc:	41018e02 	tstmi	r1, r2, lsl #28
 500:	0e7a300e 	cdpeq	0, 7, cr3, cr10, cr14, {0}
 504:	00000020 	andeq	r0, r0, r0, lsr #32
 508:	00000040 	andeq	r0, r0, r0, asr #32
 50c:	00000460 	andeq	r0, r0, r0, ror #8
 510:	80000cf8 	strdhi	r0, [r0], -r8
 514:	000000c8 	andeq	r0, r0, r8, asr #1
 518:	80100e41 	andshi	r0, r0, r1, asr #28
 51c:	82038104 	andhi	r8, r3, #4, 2
 520:	42018302 	andmi	r8, r1, #134217728	; 0x8000000
 524:	0c84300e 	stceq	0, cr3, [r4], {14}
 528:	0a860b85 	beq	fe183344 <__framebuffer_start+0x7db83344>
 52c:	08880987 	stmeq	r8, {r0, r1, r2, r7, r8, fp}
 530:	068a0789 	streq	r0, [sl], r9, lsl #15
 534:	5f02058e 	svcpl	0x0002058e
 538:	c8c9cace 	stmiagt	r9, {r1, r2, r3, r6, r7, r9, fp, lr, pc}^
 53c:	c4c5c6c7 	strbgt	ip, [r5], #1735	; 0x6c7
 540:	c341100e 	movtgt	r1, #4110	; 0x100e
 544:	0ec0c1c2 	acseqdm	f4, f2
 548:	00000000 	andeq	r0, r0, r0
 54c:	0000000c 	andeq	r0, r0, ip
 550:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 554:	7c020001 	stcvc	0, cr0, [r2], {1}
 558:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 55c:	00000018 	andeq	r0, r0, r8, lsl r0
 560:	0000054c 	andeq	r0, r0, ip, asr #10
 564:	80000dc0 	andhi	r0, r0, r0, asr #27
 568:	0000004e 	andeq	r0, r0, lr, asr #32
 56c:	83100e41 	tsthi	r0, #1040	; 0x410
 570:	85038404 	strhi	r8, [r3, #-1028]	; 0xfffffbfc
 574:	00018e02 	andeq	r8, r1, r2, lsl #28
 578:	00000014 	andeq	r0, r0, r4, lsl r0
 57c:	0000054c 	andeq	r0, r0, ip, asr #10
 580:	80000e10 	andhi	r0, r0, r0, lsl lr
 584:	00000008 	andeq	r0, r0, r8
 588:	83080e41 	movwhi	r0, #36417	; 0x8e41
 58c:	00018e02 	andeq	r8, r1, r2, lsl #28
 590:	00000018 	andeq	r0, r0, r8, lsl r0
 594:	0000054c 	andeq	r0, r0, ip, asr #10
 598:	80000e18 	andhi	r0, r0, r8, lsl lr
 59c:	00000022 	andeq	r0, r0, r2, lsr #32
 5a0:	83100e41 	tsthi	r0, #1040	; 0x410
 5a4:	85038404 	strhi	r8, [r3, #-1028]	; 0xfffffbfc
 5a8:	00018e02 	andeq	r8, r1, r2, lsl #28
 5ac:	0000000c 	andeq	r0, r0, ip
 5b0:	0000054c 	andeq	r0, r0, ip, asr #10
 5b4:	80000e3c 	andhi	r0, r0, ip, lsr lr
 5b8:	0000000e 	andeq	r0, r0, lr
 5bc:	0000000c 	andeq	r0, r0, ip
 5c0:	0000054c 	andeq	r0, r0, ip, asr #10
 5c4:	80000e4c 	andhi	r0, r0, ip, asr #28
 5c8:	00000002 	andeq	r0, r0, r2
 5cc:	0000000c 	andeq	r0, r0, ip
 5d0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 5d4:	7c010001 	stcvc	0, cr0, [r1], {1}
 5d8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 5dc:	0000000c 	andeq	r0, r0, ip
 5e0:	000005cc 	andeq	r0, r0, ip, asr #11
 5e4:	80000e50 	andhi	r0, r0, r0, asr lr
 5e8:	000000f4 	strdeq	r0, [r0], -r4

Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	0000006e 	andeq	r0, r0, lr, rrx
   4:	00000004 	andeq	r0, r0, r4
   8:	01040000 	mrseq	r0, (UNDEF: 4)
   c:	0000000b 	andeq	r0, r0, fp
  10:	00006b0c 	andeq	r6, r0, ip, lsl #22
  14:	00008500 	andeq	r8, r0, r0, lsl #10
  18:	00094000 	andeq	r4, r9, r0
  1c:	0000a080 	andeq	sl, r0, r0, lsl #1
  20:	00000000 	andeq	r0, r0, r0
  24:	00000200 	andeq	r0, r0, r0, lsl #4
  28:	22010000 	andcs	r0, r1, #0
  2c:	80000940 	andhi	r0, r0, r0, asr #18
  30:	000000a0 	andeq	r0, r0, r0, lsr #1
  34:	00659c01 	rsbeq	r9, r5, r1, lsl #24
  38:	7e030000 	cdpvc	0, 0, cr0, cr3, cr0, {0}
  3c:	01000000 	mrseq	r0, (UNDEF: 0)
  40:	00006c24 	andeq	r6, r0, r4, lsr #24
  44:	7c910200 	lfmvc	f0, 4, [r1], {0}
  48:	00006203 	andeq	r6, r0, r3, lsl #4
  4c:	6c240100 	stfvss	f0, [r4], #-0
  50:	02000000 	andeq	r0, r0, #0
  54:	05037891 	streq	r7, [r3, #-2193]	; 0xfffff76f
  58:	01000000 	mrseq	r0, (UNDEF: 0)
  5c:	00006c24 	andeq	r6, r0, r4, lsr #24
  60:	74910200 	ldrvc	r0, [r1], #512	; 0x200
  64:	07040400 	streq	r0, [r4, -r0, lsl #8]
  68:	000001d3 	ldrdeq	r0, [r0], -r3
  6c:	00006505 	andeq	r6, r0, r5, lsl #10
  70:	03cf0000 	biceq	r0, pc, #0
  74:	00040000 	andeq	r0, r4, r0
  78:	0000004f 	andeq	r0, r0, pc, asr #32
  7c:	000b0104 	andeq	r0, fp, r4, lsl #2
  80:	110c0000 	mrsne	r0, (UNDEF: 12)
  84:	85000002 	strhi	r0, [r0, #-2]
  88:	e0000000 	and	r0, r0, r0
  8c:	c0800009 	addgt	r0, r0, r9
  90:	51000000 	mrspl	r0, (UNDEF: 0)
  94:	02000000 	andeq	r0, r0, #0
  98:	012c0601 			; <UNDEFINED> instruction: 0x012c0601
  9c:	01020000 	mrseq	r0, (UNDEF: 2)
  a0:	00012a08 	andeq	r2, r1, r8, lsl #20
  a4:	05020200 	streq	r0, [r2, #-512]	; 0xfffffe00
  a8:	00000101 	andeq	r0, r0, r1, lsl #2
  ac:	56070202 	strpl	r0, [r7], -r2, lsl #4
  b0:	02000001 	andeq	r0, r0, #1
  b4:	01f80504 	mvnseq	r0, r4, lsl #10
  b8:	79030000 	stmdbvc	r3, {}	; <UNPREDICTABLE>
  bc:	02000001 	andeq	r0, r0, #1
  c0:	00005341 	andeq	r5, r0, r1, asr #6
  c4:	07040200 	streq	r0, [r4, -r0, lsl #4]
  c8:	000001ce 	andeq	r0, r0, lr, asr #3
  cc:	f3050802 	vsub.i8	d0, d5, d2
  d0:	02000001 	andeq	r0, r0, #1
  d4:	01c90708 	biceq	r0, r9, r8, lsl #14
  d8:	04040000 	streq	r0, [r4], #-0
  dc:	746e6905 	strbtvc	r6, [lr], #-2309	; 0xfffff6fb
  e0:	07040200 	streq	r0, [r4, -r0, lsl #4]
  e4:	000001d3 	ldrdeq	r0, [r0], -r3
  e8:	2e040802 	cdpcs	8, 0, cr0, cr4, cr2, {0}
  ec:	02000002 	andeq	r0, r0, #2
  f0:	01ea0704 	mvneq	r0, r4, lsl #14
  f4:	04050000 	streq	r0, [r5], #-0
  f8:	0000008a 	andeq	r0, r0, sl, lsl #1
  fc:	08010206 	stmdaeq	r1, {r1, r2, r9}
 100:	00000133 	andeq	r0, r0, r3, lsr r1
 104:	00017b03 	andeq	r7, r1, r3, lsl #22
 108:	48300300 	ldmdami	r0!, {r8, r9}
 10c:	07000000 	streq	r0, [r0, -r0]
 110:	b20f0404 	andlt	r0, pc, #4, 8	; 0x4000000
 114:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
 118:	000000ef 	andeq	r0, r0, pc, ror #1
 11c:	006f1104 	rsbeq	r1, pc, r4, lsl #2
 120:	00000000 	andeq	r0, r0, r0
 124:	0000d603 	andeq	sp, r0, r3, lsl #12
 128:	9d120400 	cfldrsls	mvf0, [r2, #-0]
 12c:	03000000 	movweq	r0, #0
 130:	0000023a 	andeq	r0, r0, sl, lsr r2
 134:	00840b05 	addeq	r0, r4, r5, lsl #22
 138:	18090000 	stmdane	r9, {}	; <UNPREDICTABLE>
 13c:	01000002 	tsteq	r0, r2
 140:	0009e011 	andeq	lr, r9, r1, lsl r0
 144:	00000a80 	andeq	r0, r0, r0, lsl #21
 148:	ff9c0100 			; <UNDEFINED> instruction: 0xff9c0100
 14c:	0a000000 	beq	154 <UNLOCKED+0x55>
 150:	00000184 	andeq	r0, r0, r4, lsl #3
 154:	00681301 	rsbeq	r1, r8, r1, lsl #6
 158:	00ee0000 	rsceq	r0, lr, r0
 15c:	000b0000 	andeq	r0, fp, r0
 160:	0009e80c 	andeq	lr, r9, ip, lsl #16
 164:	00032d80 	andeq	r2, r3, r0, lsl #27
 168:	50010d00 	andpl	r0, r1, r0, lsl #26
 16c:	00420802 	subeq	r0, r2, r2, lsl #16
 170:	01170e00 	tsteq	r7, r0, lsl #28
 174:	34010000 	strcc	r0, [r1], #-0
 178:	800009ec 	andhi	r0, r0, ip, ror #19
 17c:	0000002c 	andeq	r0, r0, ip, lsr #32
 180:	016c9c01 	cmneq	ip, r1, lsl #24
 184:	690f0000 	stmdbvs	pc, {}	; <UNPREDICTABLE>
 188:	36010064 	strcc	r0, [r1], -r4, rrx
 18c:	0000006f 	andeq	r0, r0, pc, rrx
 190:	00000000 	andeq	r0, r0, r0
 194:	0001840a 	andeq	r8, r1, sl, lsl #8
 198:	68130100 	ldmdavs	r3, {r8}
 19c:	33000000 	movwcc	r0, #0
 1a0:	0b000001 	bleq	1ac <UNLOCKED+0xad>
 1a4:	09f21000 	ldmibeq	r2!, {ip}^
 1a8:	03388000 	teqeq	r8, #0
 1ac:	f6100000 			; <UNDEFINED> instruction: 0xf6100000
 1b0:	43800009 	orrmi	r0, r0, #9
 1b4:	11000003 	tstne	r0, r3
 1b8:	800009fc 	strdhi	r0, [r0], -ip
 1bc:	0000032d 	andeq	r0, r0, sp, lsr #6
 1c0:	00000159 	andeq	r0, r0, r9, asr r1
 1c4:	0250010d 	subseq	r0, r0, #1073741827	; 0x40000003
 1c8:	10004308 	andne	r4, r0, r8, lsl #6
 1cc:	80000a00 	andhi	r0, r0, r0, lsl #20
 1d0:	0000034e 	andeq	r0, r0, lr, asr #6
 1d4:	000a0610 	andeq	r0, sl, r0, lsl r6
 1d8:	00035980 	andeq	r5, r3, r0, lsl #19
 1dc:	950e0000 	strls	r0, [lr, #-0]
 1e0:	01000001 	tsteq	r0, r1
 1e4:	000a1855 	andeq	r1, sl, r5, asr r8
 1e8:	00006680 	andeq	r6, r0, r0, lsl #13
 1ec:	7e9c0100 	fmlvce	f0, f4, f0
 1f0:	0a000002 	beq	200 <UNLOCKED+0x101>
 1f4:	00000184 	andeq	r0, r0, r4, lsl #3
 1f8:	00681301 	rsbeq	r1, r8, r1, lsl #6
 1fc:	01920000 	orrseq	r0, r2, r0
 200:	000b0000 	andeq	r0, fp, r0
 204:	000a1e10 	andeq	r1, sl, r0, lsl lr
 208:	00033880 	andeq	r3, r3, r0, lsl #17
 20c:	0a221000 	beq	884214 <L1_COHERENT+0x86f60e>
 210:	03438000 	movteq	r8, #12288	; 0x3000
 214:	2e110000 	cdpcs	0, 1, cr0, cr1, cr0, {0}
 218:	6480000a 	strvs	r0, [r0], #10
 21c:	bb000003 	bllt	230 <UNLOCKED+0x131>
 220:	0d000001 	stceq	0, cr0, [r0, #-4]
 224:	03055001 	movweq	r5, #20481	; 0x5001
 228:	80000fa0 	andhi	r0, r0, r0, lsr #31
 22c:	0a321000 	beq	c84234 <L1_COHERENT+0xc6f62e>
 230:	036f8000 	cmneq	pc, #0
 234:	38110000 	ldmdacc	r1, {}	; <UNPREDICTABLE>
 238:	2d80000a 	stccs	0, cr0, [r0, #40]	; 0x28
 23c:	d8000003 	stmdale	r0, {r0, r1}
 240:	0d000001 	stceq	0, cr0, [r0, #-4]
 244:	08025001 	stmdaeq	r2, {r0, ip, lr}
 248:	3e110041 	cdpcc	0, 1, cr0, cr1, cr1, {2}
 24c:	7a80000a 	bvc	fe00027c <__framebuffer_start+0x7da0027c>
 250:	eb000003 	bl	264 <UNLOCKED+0x165>
 254:	0d000001 	stceq	0, cr0, [r0, #-4]
 258:	35015001 	strcc	r5, [r1, #-1]
 25c:	0a461100 	beq	1184664 <L1_COHERENT+0x116fa5e>
 260:	03858000 	orreq	r8, r5, #0
 264:	02030000 	andeq	r0, r3, #0
 268:	010d0000 	mrseq	r0, (UNDEF: 13)
 26c:	0d350150 	ldfeqs	f0, [r5, #-320]!	; 0xfffffec0
 270:	30015101 	andcc	r5, r1, r1, lsl #2
 274:	0a541100 	beq	150467c <L1_COHERENT+0x14efa76>
 278:	03908000 	orrseq	r8, r0, #0
 27c:	021f0000 	andseq	r0, pc, #0
 280:	010d0000 	mrseq	r0, (UNDEF: 13)
 284:	0d350150 	ldfeqs	f0, [r5, #-320]!	; 0xfffffec0
 288:	03055101 	movweq	r5, #20737	; 0x5101
 28c:	800009e1 	andhi	r0, r0, r1, ror #19
 290:	0a581000 	beq	1604298 <L1_COHERENT+0x15ef692>
 294:	039b8000 	orrseq	r8, fp, #0
 298:	64110000 	ldrvs	r0, [r1], #-0
 29c:	a680000a 	strge	r0, [r0], sl
 2a0:	45000003 	strmi	r0, [r0, #-3]
 2a4:	0d000002 	stceq	0, cr0, [r0, #-8]
 2a8:	35015001 	strcc	r5, [r1, #-1]
 2ac:	0151010d 	cmpeq	r1, sp, lsl #2
 2b0:	52010d3f 	andpl	r0, r1, #4032	; 0xfc0
 2b4:	10003001 	andne	r3, r0, r1
 2b8:	80000a68 	andhi	r0, r0, r8, ror #20
 2bc:	000003b1 			; <UNDEFINED> instruction: 0x000003b1
 2c0:	000a6c10 	andeq	r6, sl, r0, lsl ip
 2c4:	00035980 	andeq	r5, r3, r0, lsl #19
 2c8:	0a7a1100 	beq	1e846d0 <L1_COHERENT+0x1e6faca>
 2cc:	03a68000 			; <UNDEFINED> instruction: 0x03a68000
 2d0:	02740000 	rsbseq	r0, r4, #0
 2d4:	010d0000 	mrseq	r0, (UNDEF: 13)
 2d8:	0d300150 	ldfeqs	f0, [r0, #-320]!	; 0xfffffec0
 2dc:	3f015101 	svccc	0x00015101
 2e0:	0152010d 	cmpeq	r2, sp, lsl #2
 2e4:	7e100030 	mrcvc	0, 0, r0, cr0, cr0, {1}
 2e8:	ff80000a 			; <UNDEFINED> instruction: 0xff80000a
 2ec:	00000000 	andeq	r0, r0, r0
 2f0:	0000e609 	andeq	lr, r0, r9, lsl #12
 2f4:	80820100 	addhi	r0, r2, r0, lsl #2
 2f8:	1080000a 	addne	r0, r0, sl
 2fc:	01000000 	mrseq	r0, (UNDEF: 0)
 300:	0002a79c 	muleq	r2, ip, r7
 304:	0a8e0c00 	beq	fe38330c <__framebuffer_start+0x7dd8330c>
 308:	03bc8000 			; <UNDEFINED> instruction: 0x03bc8000
 30c:	010d0000 	mrseq	r0, (UNDEF: 13)
 310:	a0030550 	andge	r0, r3, r0, asr r5
 314:	0080000f 	addeq	r0, r0, pc
 318:	01690900 	cmneq	r9, r0, lsl #18
 31c:	88010000 	stmdahi	r1, {}	; <UNPREDICTABLE>
 320:	80000a90 	mulhi	r0, r0, sl
 324:	00000010 	andeq	r0, r0, r0, lsl r0
 328:	02d09c01 	sbcseq	r9, r0, #256	; 0x100
 32c:	9e0c0000 	cdpls	0, 0, cr0, cr12, cr0, {0}
 330:	c780000a 	strgt	r0, [r0, sl]
 334:	0d000003 	stceq	0, cr0, [r0, #-12]
 338:	03055001 	movweq	r5, #20481	; 0x5001
 33c:	80000fa0 	andhi	r0, r0, r0, lsr #31
 340:	bd120000 	ldclt	0, cr0, [r2, #-0]
 344:	e0000000 	and	r0, r0, r0
 348:	13000002 	movwne	r0, #2
 34c:	0000007d 	andeq	r0, r0, sp, ror r0
 350:	0114007f 	tsteq	r4, pc, ror r0
 354:	01000002 	tsteq	r0, r2
 358:	0002d017 	andeq	sp, r2, r7, lsl r0
 35c:	b4030500 	strlt	r0, [r3], #-1280	; 0xfffffb00
 360:	1280000f 	addne	r0, r0, #15
 364:	00000301 	andeq	r0, r0, r1, lsl #6
 368:	00000301 	andeq	r0, r0, r1, lsl #6
 36c:	00007d13 	andeq	r7, r0, r3, lsl sp
 370:	15000300 	strne	r0, [r0, #-768]	; 0xfffffd00
 374:	00000092 	muleq	r0, r2, r0
 378:	00024f14 	andeq	r4, r2, r4, lsl pc
 37c:	17180100 	ldrne	r0, [r8, -r0, lsl #2]
 380:	05000003 	streq	r0, [r0, #-3]
 384:	000fa403 	andeq	sl, pc, r3, lsl #8
 388:	02f11580 	rscseq	r1, r1, #128, 10	; 0x20000000
 38c:	e8140000 	ldmda	r4, {}	; <UNPREDICTABLE>
 390:	01000000 	mrseq	r0, (UNDEF: 0)
 394:	0000b223 	andeq	fp, r0, r3, lsr #4
 398:	a0030500 	andge	r0, r3, r0, lsl #10
 39c:	1680000f 	strne	r0, [r0], pc
 3a0:	00000184 	andeq	r0, r0, r4, lsl #3
 3a4:	00000184 	andeq	r0, r0, r4, lsl #3
 3a8:	b2161301 	andslt	r1, r6, #67108864	; 0x4000000
 3ac:	b2000001 	andlt	r0, r0, #1
 3b0:	06000001 	streq	r0, [r0], -r1
 3b4:	00f41634 	rscseq	r1, r4, r4, lsr r6
 3b8:	00f40000 	rscseq	r0, r4, r0
 3bc:	26010000 	strcs	r0, [r1], -r0
 3c0:	0001a916 	andeq	sl, r1, r6, lsl r9
 3c4:	0001a900 	andeq	sl, r1, r0, lsl #18
 3c8:	168b0600 	strne	r0, [fp], r0, lsl #12
 3cc:	00000259 	andeq	r0, r0, r9, asr r2
 3d0:	00000259 	andeq	r0, r0, r9, asr r2
 3d4:	e0161107 	ands	r1, r6, r7, lsl #2
 3d8:	e0000001 	and	r0, r0, r1
 3dc:	04000001 	streq	r0, [r0], #-1
 3e0:	01201616 			; <UNDEFINED> instruction: 0x01201616
 3e4:	01200000 			; <UNDEFINED> instruction: 0x01200000
 3e8:	28010000 	stmdacs	r1, {}	; <UNPREDICTABLE>
 3ec:	00010b16 	andeq	r0, r1, r6, lsl fp
 3f0:	00010b00 	andeq	r0, r1, r0, lsl #22
 3f4:	16280800 	strtne	r0, [r8], -r0, lsl #16
 3f8:	0000019a 	muleq	r0, sl, r1
 3fc:	0000019a 	muleq	r0, sl, r1
 400:	44163f08 	ldrmi	r3, [r6], #-3848	; 0xfffff0f8
 404:	44000001 	strmi	r0, [r0], #-1
 408:	05000001 	streq	r0, [r0, #-1]
 40c:	0224160f 	eoreq	r1, r4, #15728640	; 0xf00000
 410:	02240000 	eoreq	r0, r4, #0
 414:	22080000 	andcs	r0, r8, #0
 418:	0000de16 	andeq	sp, r0, r6, lsl lr
 41c:	0000de00 	andeq	sp, r0, r0, lsl #28
 420:	165d0800 	ldrbne	r0, [sp], -r0, lsl #16
	...
 42c:	3a162901 	bcc	58a838 <L1_COHERENT+0x575c32>
 430:	3a000001 	bcc	43c <UNLOCKED+0x33d>
 434:	04000001 	streq	r0, [r0], #-1
 438:	0138161a 	teqeq	r8, sl, lsl r6
 43c:	01380000 	teqeq	r8, r0
 440:	1f040000 	svcne	0x00040000
 444:	0000dd00 	andeq	sp, r0, r0, lsl #26
 448:	7a000400 	bvc	1450 <L1_NONCOHERENT+0x832>
 44c:	04000001 	streq	r0, [r0], #-1
 450:	00000b01 	andeq	r0, r0, r1, lsl #22
 454:	029f0c00 	addseq	r0, pc, #0, 24
 458:	00850000 	addeq	r0, r5, r0
 45c:	0aa00000 	beq	fe800464 <__framebuffer_start+0x7e200464>
 460:	007a8000 	rsbseq	r8, sl, r0
 464:	01470000 	mrseq	r0, (UNDEF: 71)
 468:	20020000 	andcs	r0, r2, r0
 46c:	01000001 	tsteq	r0, r1
 470:	000aa010 	andeq	sl, sl, r0, lsl r0
 474:	00001480 	andeq	r1, r0, r0, lsl #9
 478:	039c0100 	orrseq	r0, ip, #0, 2
 47c:	00000184 	andeq	r0, r0, r4, lsl #3
 480:	0ab41501 	beq	fed0588c <__framebuffer_start+0x7e70588c>
 484:	00188000 	andseq	r8, r8, r0
 488:	9c010000 	stcls	0, cr0, [r1], {-0}
 48c:	00000057 	andeq	r0, r0, r7, asr r0
 490:	01006304 	tsteq	r0, r4, lsl #6
 494:	00005715 	andeq	r5, r0, r5, lsl r7
 498:	00500100 	subseq	r0, r0, r0, lsl #2
 49c:	33080105 	movwcc	r0, #33029	; 0x8105
 4a0:	06000001 	streq	r0, [r0], -r1
 4a4:	0000027a 	andeq	r0, r0, sl, ror r2
 4a8:	00571a01 	subseq	r1, r7, r1, lsl #20
 4ac:	0acc0000 	beq	ff3004b4 <__framebuffer_start+0x7ed004b4>
 4b0:	00188000 	andseq	r8, r8, r0
 4b4:	9c010000 	stcls	0, cr0, [r1], {-0}
 4b8:	00026403 	andeq	r6, r2, r3, lsl #8
 4bc:	e4200100 	strt	r0, [r0], #-256	; 0xffffff00
 4c0:	1680000a 	strne	r0, [r0], sl
 4c4:	01000000 	mrseq	r0, (UNDEF: 0)
 4c8:	0000a19c 	muleq	r0, ip, r1
 4cc:	02730700 	rsbseq	r0, r3, #0, 14
 4d0:	20010000 	andcs	r0, r1, r0
 4d4:	000000a1 	andeq	r0, r0, r1, lsr #1
 4d8:	0000001e 	andeq	r0, r0, lr, lsl r0
 4dc:	000af208 	andeq	pc, sl, r8, lsl #4
 4e0:	00003680 	andeq	r3, r0, r0, lsl #13
 4e4:	04090000 	streq	r0, [r9], #-0
 4e8:	00000057 	andeq	r0, r0, r7, asr r0
 4ec:	00028e0a 	andeq	r8, r2, sl, lsl #28
 4f0:	fc250100 	stc2	1, cr0, [r5], #-0
 4f4:	1e80000a 	cdpne	0, 8, cr0, cr0, cr10, {0}
 4f8:	01000000 	mrseq	r0, (UNDEF: 0)
 4fc:	0273079c 	rsbseq	r0, r3, #156, 14	; 0x2700000
 500:	25010000 	strcs	r0, [r1, #-0]
 504:	000000a1 	andeq	r0, r0, r1, lsr #1
 508:	0000003c 	andeq	r0, r0, ip, lsr r0
 50c:	000b0a08 	andeq	r0, fp, r8, lsl #20
 510:	00003680 	andeq	r3, r0, r0, lsl #13
 514:	0b180b00 	bleq	60311c <L1_COHERENT+0x5ee516>
 518:	00368000 	eorseq	r8, r6, r0
 51c:	010c0000 	mrseq	r0, (UNDEF: 12)
 520:	003a0150 	eorseq	r0, sl, r0, asr r1
 524:	03d10000 	bicseq	r0, r1, #0
 528:	00040000 	andeq	r0, r4, r0
 52c:	00000246 	andeq	r0, r0, r6, asr #4
 530:	000b0104 	andeq	r0, fp, r4, lsl #2
 534:	f10c0000 	cpsid	
 538:	85000002 	strhi	r0, [r0, #-2]
 53c:	1c000000 	stcne	0, cr0, [r0], {-0}
 540:	a480000b 	strge	r0, [r0], #11
 544:	9c000002 	stcls	0, cr0, [r0], {2}
 548:	02000001 	andeq	r0, r0, #1
 54c:	01c90708 	biceq	r0, r9, r8, lsl #14
 550:	2b030000 	blcs	c0558 <L1_COHERENT+0xab952>
 554:	01000003 	tsteq	r0, r3
 558:	00910103 	addseq	r0, r1, r3, lsl #2
 55c:	70040000 	andvc	r0, r4, r0
 560:	01006461 	tsteq	r0, r1, ror #8
 564:	00002503 	andeq	r2, r0, r3, lsl #10
 568:	02db0500 	sbcseq	r0, fp, #0, 10
 56c:	05010000 	streq	r0, [r1, #-0]
 570:	00000091 	muleq	r0, r1, r0
 574:	0002ce05 	andeq	ip, r2, r5, lsl #28
 578:	93070100 	movwls	r0, #28928	; 0x7100
 57c:	05000000 	streq	r0, [r0, #-0]
 580:	000002fe 	strdeq	r0, [r0], -lr
 584:	00930801 	addseq	r0, r3, r1, lsl #16
 588:	b0050000 	andlt	r0, r5, r0
 58c:	01000002 	tsteq	r0, r2
 590:	00009309 	andeq	r9, r0, r9, lsl #6
 594:	02a60500 	adceq	r0, r6, #0, 10
 598:	0b010000 	bleq	405a0 <L1_COHERENT+0x2b99a>
 59c:	00000093 	muleq	r0, r3, r0
 5a0:	00034205 	andeq	r4, r3, r5, lsl #4
 5a4:	930d0100 	movwls	r0, #53504	; 0xd100
 5a8:	05000000 	streq	r0, [r0, #-0]
 5ac:	0000036d 	andeq	r0, r0, sp, ror #6
 5b0:	00930f01 	addseq	r0, r3, r1, lsl #30
 5b4:	06000000 	streq	r0, [r0], -r0
 5b8:	07040204 	streq	r0, [r4, -r4, lsl #4]
 5bc:	000001d3 	ldrdeq	r0, [r0], -r3
 5c0:	00002c07 	andeq	r2, r0, r7, lsl #24
 5c4:	000b1c00 	andeq	r1, fp, r0, lsl #24
 5c8:	00005880 	andeq	r5, r0, r0, lsl #17
 5cc:	ee9c0100 	fmle	f0, f4, f0
 5d0:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
 5d4:	00000038 	andeq	r0, r0, r8, lsr r0
 5d8:	00000067 	andeq	r0, r0, r7, rrx
 5dc:	00004309 	andeq	r4, r0, r9, lsl #6
 5e0:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
 5e4:	004e0a02 	subeq	r0, lr, r2, lsl #20
 5e8:	008f0000 	addeq	r0, pc, r0
 5ec:	590b0000 	stmdbpl	fp, {}	; <UNPREDICTABLE>
 5f0:	0a000000 	beq	5f8 <UNLOCKED+0x4f9>
 5f4:	00000064 	andeq	r0, r0, r4, rrx
 5f8:	000000c2 	andeq	r0, r0, r2, asr #1
 5fc:	00006f0b 	andeq	r6, r0, fp, lsl #30
 600:	007a0a00 	rsbseq	r0, sl, r0, lsl #20
 604:	00f50000 	rscseq	r0, r5, r0
 608:	850a0000 	strhi	r0, [sl, #-0]
 60c:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
 610:	00000001 	andeq	r0, r0, r1
 614:	0003070c 	andeq	r0, r3, ip, lsl #14
 618:	74200100 	strtvc	r0, [r0], #-256	; 0xffffff00
 61c:	4880000b 	stmmi	r0, {r0, r1, r3}
 620:	01000000 	mrseq	r0, (UNDEF: 0)
 624:	0001cc9c 	muleq	r1, ip, ip
 628:	002c0d00 	eoreq	r0, ip, r0, lsl #26
 62c:	0b740000 	bleq	1d00634 <L1_COHERENT+0x1ceba2e>
 630:	001e8000 	andseq	r8, lr, r0
 634:	22010000 	andcs	r0, r1, #0
 638:	00000169 	andeq	r0, r0, r9, ror #2
 63c:	00003808 	andeq	r3, r0, r8, lsl #16
 640:	00012300 	andeq	r2, r1, r0, lsl #6
 644:	0b740e00 	bleq	1d03e4c <L1_COHERENT+0x1cef246>
 648:	001e8000 	andseq	r8, lr, r0
 64c:	43090000 	movwmi	r0, #36864	; 0x9000
 650:	00000000 	andeq	r0, r0, r0
 654:	0a020e00 	beq	83e5c <L1_COHERENT+0x6f256>
 658:	0000004e 	andeq	r0, r0, lr, asr #32
 65c:	0000013f 	andeq	r0, r0, pc, lsr r1
 660:	0000590a 	andeq	r5, r0, sl, lsl #18
 664:	00015500 	andeq	r5, r1, r0, lsl #10
 668:	00640a00 	rsbeq	r0, r4, r0, lsl #20
 66c:	01690000 	cmneq	r9, r0
 670:	6f0a0000 	svcvs	0x000a0000
 674:	69000000 	stmdbvs	r0, {}	; <UNPREDICTABLE>
 678:	0a000001 	beq	684 <UNLOCKED+0x585>
 67c:	0000007a 	andeq	r0, r0, sl, ror r0
 680:	0000017d 	andeq	r0, r0, sp, ror r1
 684:	0000850a 	andeq	r8, r0, sl, lsl #10
 688:	00019300 	andeq	r9, r1, r0, lsl #6
 68c:	0f000000 	svceq	0x00000000
 690:	0000002c 	andeq	r0, r0, ip, lsr #32
 694:	80000b92 	mulhi	r0, r2, fp
 698:	0000002a 	andeq	r0, r0, sl, lsr #32
 69c:	38082301 	stmdacc	r8, {r0, r8, r9, sp}
 6a0:	ab000000 	blge	6a8 <UNLOCKED+0x5a9>
 6a4:	0e000001 	cdpeq	0, 0, cr0, cr0, cr1, {0}
 6a8:	80000b92 	mulhi	r0, r2, fp
 6ac:	0000002a 	andeq	r0, r0, sl, lsr #32
 6b0:	00004309 	andeq	r4, r0, r9, lsl #6
 6b4:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
 6b8:	004e0a02 	subeq	r0, lr, r2, lsl #20
 6bc:	01c70000 	biceq	r0, r7, r0
 6c0:	590a0000 	stmdbpl	sl, {}	; <UNPREDICTABLE>
 6c4:	dd000000 	stcle	0, cr0, [r0, #-0]
 6c8:	0a000001 	beq	6d4 <UNLOCKED+0x5d5>
 6cc:	00000064 	andeq	r0, r0, r4, rrx
 6d0:	000001f1 	strdeq	r0, [r0], -r1
 6d4:	00006f0a 	andeq	r6, r0, sl, lsl #30
 6d8:	00020700 	andeq	r0, r2, r0, lsl #14
 6dc:	007a0a00 	rsbseq	r0, sl, r0, lsl #20
 6e0:	021b0000 	andseq	r0, fp, #0
 6e4:	850a0000 	strhi	r0, [sl, #-0]
 6e8:	31000000 	mrscc	r0, (UNDEF: 0)
 6ec:	00000002 	andeq	r0, r0, r2
 6f0:	56100000 	ldrpl	r0, [r0], -r0
 6f4:	01000003 	tsteq	r0, r3
 6f8:	000bbc26 	andeq	fp, fp, r6, lsr #24
 6fc:	00002480 	andeq	r2, r0, r0, lsl #9
 700:	0c9c0100 	ldfeqs	f0, [ip], {0}
 704:	000002be 			; <UNDEFINED> instruction: 0x000002be
 708:	0be02d01 	bleq	ff80bb14 <__framebuffer_start+0x7f20bb14>
 70c:	00248000 	eoreq	r8, r4, r0
 710:	9c010000 	stcls	0, cr0, [r1], {-0}
 714:	0000020f 	andeq	r0, r0, pc, lsl #4
 718:	01006311 	tsteq	r0, r1, lsl r3
 71c:	0002162d 	andeq	r1, r2, sp, lsr #12
 720:	00024900 	andeq	r4, r2, r0, lsl #18
 724:	0c021200 	sfmeq	f1, 4, [r2], {-0}
 728:	01dd8000 	bicseq	r8, sp, r0
 72c:	01130000 	tsteq	r3, r0
 730:	003d0150 	eorseq	r0, sp, r0, asr r1
 734:	08010200 	stmdaeq	r1, {r9}
 738:	00000133 	andeq	r0, r0, r3, lsr r1
 73c:	00020f14 	andeq	r0, r2, r4, lsl pc
 740:	031b0c00 	tsteq	fp, #0, 24
 744:	3f010000 	svccc	0x00010000
 748:	80000c04 	andhi	r0, r0, r4, lsl #24
 74c:	00000072 	andeq	r0, r0, r2, ror r0
 750:	023a9c01 	eorseq	r9, sl, #256	; 0x100
 754:	5e150000 	cdppl	0, 1, cr0, cr5, cr0, {0}
 758:	cc80000c 	stcgt	0, cr0, [r0], {12}
 75c:	00000001 	andeq	r0, r0, r1
 760:	0002e016 	andeq	lr, r2, r6, lsl r0
 764:	78560100 	ldmdavc	r6, {r8}^
 768:	7e80000c 	cdpvc	0, 8, cr0, cr0, cr12, {0}
 76c:	01000000 	mrseq	r0, (UNDEF: 0)
 770:	0002be9c 	muleq	r2, ip, lr
 774:	78781100 	ldmdavc	r8!, {r8, ip}^
 778:	be560100 	rdflts	f0, f6, f0
 77c:	6a000002 	bvs	78c <UNLOCKED+0x68d>
 780:	17000002 	strne	r0, [r0, -r2]
 784:	000002db 	ldrdeq	r0, [r0], -fp
 788:	02be5601 	adcseq	r5, lr, #1048576	; 0x100000
 78c:	028b0000 	addeq	r0, fp, #0
 790:	16170000 	ldrne	r0, [r7], -r0
 794:	01000003 	tsteq	r0, r3
 798:	0002be56 	andeq	fp, r2, r6, asr lr
 79c:	0002a900 	andeq	sl, r2, r0, lsl #18
 7a0:	034f1800 	movteq	r1, #63488	; 0xf800
 7a4:	58010000 	stmdapl	r1, {}	; <UNPREDICTABLE>
 7a8:	000002dc 	ldrdeq	r0, [r0], -ip
 7ac:	0f680305 	svceq	0x00680305
 7b0:	62198000 	andsvs	r8, r9, #0
 7b4:	01006675 	tsteq	r0, r5, ror r6
 7b8:	0002e159 	andeq	lr, r2, r9, asr r1
 7bc:	50910200 	addspl	r0, r1, r0, lsl #4
 7c0:	0100691a 	tsteq	r0, sl, lsl r9
 7c4:	0002be5a 	andeq	fp, r2, sl, asr lr
 7c8:	0002c700 	andeq	ip, r2, r0, lsl #14
 7cc:	00781a00 	rsbseq	r1, r8, r0, lsl #20
 7d0:	00935b01 	addseq	r5, r3, r1, lsl #22
 7d4:	034c0000 	movteq	r0, #49152	; 0xc000
 7d8:	ec150000 	ldc	0, cr0, [r5], {-0}
 7dc:	dd80000c 	stcle	0, cr0, [r0, #48]	; 0x30
 7e0:	00000001 	andeq	r0, r0, r1
 7e4:	6905041b 	stmdbvs	r5, {r0, r1, r3, r4, sl}
 7e8:	1c00746e 	cfstrsne	mvf7, [r0], {110}	; 0x6e
 7ec:	0000020f 	andeq	r0, r0, pc, lsl #4
 7f0:	000002d5 	ldrdeq	r0, [r0], -r5
 7f4:	0002d51d 	andeq	sp, r2, sp, lsl r5
 7f8:	02001000 	andeq	r1, r0, #0
 7fc:	01ea0704 	mvneq	r0, r4, lsl #14
 800:	c5140000 	ldrgt	r0, [r4, #-0]
 804:	1c000002 	stcne	0, cr0, [r0], {2}
 808:	0000020f 	andeq	r0, r0, pc, lsl #4
 80c:	000002f1 	strdeq	r0, [r0], -r1
 810:	0002d51d 	andeq	sp, r2, sp, lsl r5
 814:	0c000f00 	stceq	15, cr0, [r0], {-0}
 818:	000002e9 	andeq	r0, r0, r9, ror #5
 81c:	0cf86e01 	ldcleq	14, cr6, [r8], #4
 820:	00c88000 	sbceq	r8, r8, r0
 824:	9c010000 	stcls	0, cr0, [r1], {-0}
 828:	000003c8 	andeq	r0, r0, r8, asr #7
 82c:	746d661e 	strbtvc	r6, [sp], #-1566	; 0xfffff9e2
 830:	c86e0100 	stmdagt	lr!, {r8}^
 834:	02000003 	andeq	r0, r0, #3
 838:	1a1f7091 	bne	7dca84 <L1_COHERENT+0x7c7e7e>
 83c:	70010069 	andvc	r0, r1, r9, rrx
 840:	000002be 			; <UNDEFINED> instruction: 0x000002be
 844:	00000380 	andeq	r0, r0, r0, lsl #7
 848:	0100631a 	tsteq	r0, sl, lsl r3
 84c:	0002be70 	andeq	fp, r2, r0, ror lr
 850:	00039f00 	andeq	r9, r3, r0, lsl #30
 854:	03682000 	cmneq	r8, #0
 858:	71010000 	mrsvc	r0, (UNDEF: 1)
 85c:	000003ce 	andeq	r0, r0, lr, asr #7
 860:	0000045c 	andeq	r0, r0, ip, asr r4
 864:	0100731a 	tsteq	r0, sl, lsl r3
 868:	0003c872 	andeq	ip, r3, r2, ror r8
 86c:	0004d400 	andeq	sp, r4, r0, lsl #8
 870:	0d241500 	cfstr32eq	mvfx1, [r4, #-0]
 874:	01dd8000 	bicseq	r8, sp, r0
 878:	58210000 	stmdapl	r1!, {}	; <UNPREDICTABLE>
 87c:	3a80000d 	bcc	fe0008b8 <__framebuffer_start+0x7da008b8>
 880:	6c000002 	stcvs	0, cr0, [r0], {2}
 884:	13000003 	movwne	r0, #3
 888:	3a015101 	bcc	54c94 <L1_COHERENT+0x4008e>
 88c:	01520113 	cmpeq	r2, r3, lsl r1
 890:	6c210031 	stcvs	0, cr0, [r1], #-196	; 0xffffff3c
 894:	3a80000d 	bcc	fe0008d0 <__framebuffer_start+0x7da008d0>
 898:	86000002 	strhi	r0, [r0], -r2
 89c:	13000003 	movwne	r0, #3
 8a0:	78025101 	stmdavc	r2, {r0, r8, ip, lr}
 8a4:	52011300 	andpl	r1, r1, #0, 6
 8a8:	00007902 	andeq	r7, r0, r2, lsl #18
 8ac:	000d8a15 	andeq	r8, sp, r5, lsl sl
 8b0:	0001dd80 	andeq	sp, r1, r0, lsl #27
 8b4:	0d9c2100 	ldfeqs	f2, [ip]
 8b8:	01dd8000 	bicseq	r8, sp, r0
 8bc:	03a30000 			; <UNDEFINED> instruction: 0x03a30000
 8c0:	01130000 	tsteq	r3, r0
 8c4:	25080250 	strcs	r0, [r8, #-592]	; 0xfffffdb0
 8c8:	0da42100 	stfeqs	f2, [r4]
 8cc:	01dd8000 	bicseq	r8, sp, r0
 8d0:	03b70000 			; <UNDEFINED> instruction: 0x03b70000
 8d4:	01130000 	tsteq	r3, r0
 8d8:	25080250 	strcs	r0, [r8, #-592]	; 0xfffffdb0
 8dc:	0daa1200 	sfmeq	f1, 4, [sl]
 8e0:	01dd8000 	bicseq	r8, sp, r0
 8e4:	01130000 	tsteq	r3, r0
 8e8:	00750250 	rsbseq	r0, r5, r0, asr r2
 8ec:	04220000 	strteq	r0, [r2], #-0
 8f0:	0000020f 	andeq	r0, r0, pc, lsl #4
 8f4:	00930422 	addseq	r0, r3, r2, lsr #8
 8f8:	d4000000 	strle	r0, [r0], #-0
 8fc:	04000002 	streq	r0, [r0], #-2
 900:	00040c00 	andeq	r0, r4, r0, lsl #24
 904:	0b010400 	bleq	4190c <L1_COHERENT+0x2cd06>
 908:	0c000000 	stceq	0, cr0, [r0], {-0}
 90c:	000003be 			; <UNDEFINED> instruction: 0x000003be
 910:	00000085 	andeq	r0, r0, r5, lsl #1
 914:	80000dc0 	andhi	r0, r0, r0, asr #27
 918:	0000008e 	andeq	r0, r0, lr, lsl #1
 91c:	00000280 	andeq	r0, r0, r0, lsl #5
 920:	2c060102 	stfcss	f0, [r6], {2}
 924:	02000001 	andeq	r0, r0, #1
 928:	012a0801 			; <UNDEFINED> instruction: 0x012a0801
 92c:	02020000 	andeq	r0, r2, #0
 930:	00010105 	andeq	r0, r1, r5, lsl #2
 934:	07020200 	streq	r0, [r2, -r0, lsl #4]
 938:	00000156 	andeq	r0, r0, r6, asr r1
 93c:	f8050402 			; <UNDEFINED> instruction: 0xf8050402
 940:	03000001 	movweq	r0, #1
 944:	00000179 	andeq	r0, r0, r9, ror r1
 948:	00534102 	subseq	r4, r3, r2, lsl #2
 94c:	04020000 	streq	r0, [r2], #-0
 950:	0001ce07 	andeq	ip, r1, r7, lsl #28
 954:	05080200 	streq	r0, [r8, #-512]	; 0xfffffe00
 958:	000001f3 	strdeq	r0, [r0], -r3
 95c:	c9070802 	stmdbgt	r7, {r1, fp}
 960:	04000001 	streq	r0, [r0], #-1
 964:	6e690504 	cdpvs	5, 6, cr0, cr9, cr4, {0}
 968:	04020074 	streq	r0, [r2], #-116	; 0xffffff8c
 96c:	0001d307 	andeq	sp, r1, r7, lsl #6
 970:	017b0300 	cmneq	fp, r0, lsl #6
 974:	30030000 	andcc	r0, r3, r0
 978:	00000048 	andeq	r0, r0, r8, asr #32
 97c:	00023a03 	andeq	r3, r2, r3, lsl #20
 980:	8c0b0400 	cfstrshi	mvf0, [fp], {-0}
 984:	05000000 	streq	r0, [r0, #-0]
 988:	00009204 	andeq	r9, r0, r4, lsl #4
 98c:	f2070600 	vmax.s8	d0, d7, d0
 990:	01000003 	tsteq	r0, r3
 994:	000dc00b 	andeq	ip, sp, fp
 998:	00004e80 	andeq	r4, r0, r0, lsl #29
 99c:	189c0100 	ldmne	ip, {r8}
 9a0:	08000001 	stmdaeq	r0, {r0}
 9a4:	000003b9 			; <UNDEFINED> instruction: 0x000003b9
 9a8:	00760d01 	rsbseq	r0, r6, r1, lsl #26
 9ac:	04ff0000 	ldrbteq	r0, [pc], #0	; 9b4 <UNLOCKED+0x8b5>
 9b0:	d4090000 	strle	r0, [r9], #-0
 9b4:	3a80000d 	bcc	fe0009f0 <__framebuffer_start+0x7da009f0>
 9b8:	fe000000 	cdp2	0, 0, cr0, cr0, cr0, {0}
 9bc:	0a000000 	beq	9c4 <UNLOCKED+0x8c5>
 9c0:	000003b2 			; <UNDEFINED> instruction: 0x000003b2
 9c4:	006f1401 	rsbeq	r1, pc, r1, lsl #8
 9c8:	55010000 	strpl	r0, [r1, #-0]
 9cc:	00038c0a 	andeq	r8, r3, sl, lsl #24
 9d0:	6f150100 	svcvs	0x00150100
 9d4:	01000000 	mrseq	r0, (UNDEF: 0)
 9d8:	03a90853 			; <UNDEFINED> instruction: 0x03a90853
 9dc:	1c010000 	stcne	0, cr0, [r1], {-0}
 9e0:	00000081 	andeq	r0, r0, r1, lsl #1
 9e4:	00000533 	andeq	r0, r0, r3, lsr r5
 9e8:	000e0c0b 	andeq	r0, lr, fp, lsl #24
 9ec:	00028a80 	andeq	r8, r2, r0, lsl #21
 9f0:	50010c00 	andpl	r0, r1, r0, lsl #24
 9f4:	00007402 	andeq	r7, r0, r2, lsl #8
 9f8:	0dc60d00 	stcleq	13, cr0, [r6]
 9fc:	02958000 	addseq	r8, r5, #0
 a00:	d20b0000 	andle	r0, fp, #0
 a04:	8a80000d 	bhi	fe000a40 <__framebuffer_start+0x7da00a40>
 a08:	0c000002 	stceq	0, cr0, [r0], {2}
 a0c:	74025001 	strvc	r5, [r2], #-1
 a10:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
 a14:	00000409 	andeq	r0, r0, r9, lsl #8
 a18:	0e102d01 	cdpeq	13, 1, cr2, cr0, cr1, {0}
 a1c:	00088000 	andeq	r8, r8, r0
 a20:	9c010000 	stcls	0, cr0, [r1], {-0}
 a24:	0000015c 	andeq	r0, r0, ip, asr r1
 a28:	0044490f 	subeq	r4, r4, pc, lsl #18
 a2c:	00762d01 	rsbseq	r2, r6, r1, lsl #26
 a30:	05460000 	strbeq	r0, [r6, #-0]
 a34:	e0100000 	ands	r0, r0, r0
 a38:	01000003 	tsteq	r0, r3
 a3c:	0000762d 	andeq	r7, r0, sp, lsr #12
 a40:	00056700 	andeq	r6, r5, r0, lsl #14
 a44:	0e160b00 	vnmlseq.f64	d0, d6, d0
 a48:	02a08000 	adceq	r8, r0, #0
 a4c:	010c0000 	mrseq	r0, (UNDEF: 12)
 a50:	01f30350 	mvnseq	r0, r0, asr r3
 a54:	0e000050 	mcreq	0, 0, r0, cr0, cr0, {2}
 a58:	00000376 	andeq	r0, r0, r6, ror r3
 a5c:	0e183101 	mufeqe	f3, f0, f1
 a60:	00228000 	eoreq	r8, r2, r0
 a64:	9c010000 	stcls	0, cr0, [r1], {-0}
 a68:	000001f7 	strdeq	r0, [r0], -r7
 a6c:	0044490f 	subeq	r4, r4, pc, lsl #18
 a70:	00763101 	rsbseq	r3, r6, r1, lsl #2
 a74:	05880000 	streq	r0, [r8]
 a78:	e0100000 	ands	r0, r0, r0
 a7c:	01000003 	tsteq	r0, r3
 a80:	00007631 	andeq	r7, r0, r1, lsr r6
 a84:	0005a600 	andeq	sl, r5, r0, lsl #12
 a88:	01a01000 	moveq	r1, r0
 a8c:	31010000 	mrscc	r0, (UNDEF: 1)
 a90:	00000076 	andeq	r0, r0, r6, ror r0
 a94:	000005c4 	andeq	r0, r0, r4, asr #11
 a98:	000e2411 	andeq	r2, lr, r1, lsl r4
 a9c:	0002ab80 	andeq	sl, r2, r0, lsl #23
 aa0:	0001b800 	andeq	fp, r1, r0, lsl #16
 aa4:	50010c00 	andpl	r0, r1, r0, lsl #24
 aa8:	0c007402 	cfstrseq	mvf7, [r0], {2}
 aac:	f3035101 	vrhadd.u8	d5, d3, d1
 ab0:	11005201 	tstne	r0, r1, lsl #4
 ab4:	80000e2a 	andhi	r0, r0, sl, lsr #28
 ab8:	000002b6 			; <UNDEFINED> instruction: 0x000002b6
 abc:	000001cc 	andeq	r0, r0, ip, asr #3
 ac0:	0250010c 	subseq	r0, r0, #12, 2
 ac4:	11000074 	tstne	r0, r4, ror r0
 ac8:	80000e32 	andhi	r0, r0, r2, lsr lr
 acc:	000002c1 	andeq	r0, r0, r1, asr #5
 ad0:	000001e6 	andeq	r0, r0, r6, ror #3
 ad4:	0250010c 	subseq	r0, r0, #12, 2
 ad8:	010c0074 	tsteq	ip, r4, ror r0
 adc:	00750251 	rsbseq	r0, r5, r1, asr r2
 ae0:	0e380b00 	vaddeq.f64	d0, d8, d0
 ae4:	02cc8000 	sbceq	r8, ip, #0
 ae8:	010c0000 	mrseq	r0, (UNDEF: 12)
 aec:	00740250 	rsbseq	r0, r4, r0, asr r2
 af0:	440e0000 	strmi	r0, [lr], #-0
 af4:	01000001 	tsteq	r0, r1
 af8:	000e3c38 	andeq	r3, lr, r8, lsr ip
 afc:	00000e80 	andeq	r0, r0, r0, lsl #29
 b00:	269c0100 	ldrcs	r0, [ip], r0, lsl #2
 b04:	12000002 	andne	r0, r0, #2
 b08:	01004449 	tsteq	r0, r9, asr #8
 b0c:	00007638 	andeq	r7, r0, r8, lsr r6
 b10:	13500100 	cmpne	r0, #0, 2
 b14:	000003a9 	andeq	r0, r0, r9, lsr #7
 b18:	00813801 	addeq	r3, r1, r1, lsl #16
 b1c:	51010000 	mrspl	r0, (UNDEF: 1)
 b20:	04201400 	strteq	r1, [r0], #-1024	; 0xfffffc00
 b24:	3c010000 	stccc	0, cr0, [r1], {-0}
 b28:	80000e4c 	andhi	r0, r0, ip, asr #28
 b2c:	00000002 	andeq	r0, r0, r2
 b30:	81159c01 	tsthi	r5, r1, lsl #24
 b34:	47000000 	strmi	r0, [r0, -r0]
 b38:	16000002 	strne	r0, [r0], -r2
 b3c:	00000247 	andeq	r0, r0, r7, asr #4
 b40:	0402007f 	streq	r0, [r2], #-127	; 0xffffff81
 b44:	0001ea07 	andeq	lr, r1, r7, lsl #20
 b48:	02011700 	andeq	r1, r1, #0, 14
 b4c:	05010000 	streq	r0, [r1, #-0]
 b50:	00000237 	andeq	r0, r0, r7, lsr r2
 b54:	0fb40305 	svceq	0x00b40305
 b58:	6f158000 	svcvs	0x00158000
 b5c:	6f000002 	svcvs	0x00000002
 b60:	16000002 	strne	r0, [r0], -r2
 b64:	00000247 	andeq	r0, r0, r7, asr #4
 b68:	76180003 	ldrvc	r0, [r8], -r3
 b6c:	17000000 	strne	r0, [r0, -r0]
 b70:	0000024f 	andeq	r0, r0, pc, asr #4
 b74:	02850601 	addeq	r0, r5, #1048576	; 0x100000
 b78:	03050000 	movweq	r0, #20480	; 0x5000
 b7c:	80000fa4 	andhi	r0, r0, r4, lsr #31
 b80:	00025f18 	andeq	r5, r2, r8, lsl pc
 b84:	03931900 	orrseq	r1, r3, #0, 18
 b88:	03930000 	orrseq	r0, r3, #0
 b8c:	55050000 	strpl	r0, [r5, #-0]
 b90:	0003e719 	andeq	lr, r3, r9, lsl r7
 b94:	0003e700 	andeq	lr, r3, r0, lsl #14
 b98:	19520500 	ldmdbne	r2, {r8, sl}^
 b9c:	0000039c 	muleq	r0, ip, r3
 ba0:	0000039c 	muleq	r0, ip, r3
 ba4:	9a192b05 	bls	64b7c0 <L1_COHERENT+0x636bba>
 ba8:	9a000001 	bls	bb4 <UNLOCKED+0xab5>
 bac:	05000001 	streq	r0, [r0, #-1]
 bb0:	03cf193f 	biceq	r1, pc, #1032192	; 0xfc000
 bb4:	03cf0000 	biceq	r0, pc, #0
 bb8:	6d050000 	stcvs	0, cr0, [r5, #-0]
 bbc:	00043119 	andeq	r3, r4, r9, lsl r1
 bc0:	00043100 	andeq	r3, r4, r0, lsl #2
 bc4:	194c0500 	stmdbne	ip, {r8, sl}^
 bc8:	0000010b 	andeq	r0, r0, fp, lsl #2
 bcc:	0000010b 	andeq	r0, r0, fp, lsl #2
 bd0:	27002805 	strcs	r2, [r0, -r5, lsl #16]
 bd4:	02000001 	andeq	r0, r0, #1
 bd8:	00056e00 	andeq	r6, r5, r0, lsl #28
 bdc:	4a010400 	bmi	41be4 <L1_COHERENT+0x2cfde>
 be0:	50000003 	andpl	r0, r0, r3
 be4:	6480000e 	strvs	r0, [r0], #14
 be8:	2f80000f 	svccs	0x0080000f
 bec:	2f74706f 	svccs	0x0074706f
 bf0:	61636f6c 	cmnvs	r3, ip, ror #30
 bf4:	61762f6c 	cmnvs	r6, ip, ror #30
 bf8:	616d2f72 	smcvs	54002	; 0xd2f2
 bfc:	726f7063 	rsbvc	r7, pc, #99	; 0x63
 c00:	622f7374 	eorvs	r7, pc, #116, 6	; 0xd0000001
 c04:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
 c08:	706f5f2f 	rsbvc	r5, pc, pc, lsr #30
 c0c:	706d5f74 	rsbvc	r5, sp, r4, ror pc
 c10:	7374726f 	cmnvc	r4, #-268435450	; 0xf0000006
 c14:	6f70645f 	svcvs	0x0070645f
 c18:	5f737472 	svcpl	0x00737472
 c1c:	736f7263 	cmnvc	pc, #805306374	; 0x30000006
 c20:	72615f73 	rsbvc	r5, r1, #460	; 0x1cc
 c24:	6f6e2d6d 	svcvs	0x006e2d6d
 c28:	652d656e 	strvs	r6, [sp, #-1390]!	; 0xfffffa92
 c2c:	2d696261 	sfmcs	f6, 2, [r9, #-388]!	; 0xfffffe7c
 c30:	2f636367 	svccs	0x00636367
 c34:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 c38:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xfffff092
 c3c:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 c40:	63672d69 	cmnvs	r7, #6720	; 0x1a40
 c44:	6f772f63 	svcvs	0x00772f63
 c48:	672f6b72 			; <UNDEFINED> instruction: 0x672f6b72
 c4c:	342d6363 	strtcc	r6, [sp], #-867	; 0xfffffc9d
 c50:	322e372e 	eorcc	r3, lr, #12058624	; 0xb80000
 c54:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 c58:	2f636367 	svccs	0x00636367
 c5c:	666e6f63 	strbtvs	r6, [lr], -r3, ror #30
 c60:	612f6769 			; <UNDEFINED> instruction: 0x612f6769
 c64:	6c2f6d72 	stcvs	13, cr6, [pc], #-456	; aa4 <UNLOCKED+0x9a5>
 c68:	66316269 	ldrtvs	r6, [r1], -r9, ror #4
 c6c:	73636e75 	cmnvc	r3, #1872	; 0x750
 c70:	2f00532e 	svccs	0x0000532e
 c74:	2f74706f 	svccs	0x0074706f
 c78:	61636f6c 	cmnvs	r3, ip, ror #30
 c7c:	61762f6c 	cmnvs	r6, ip, ror #30
 c80:	616d2f72 	smcvs	54002	; 0xd2f2
 c84:	726f7063 	rsbvc	r7, pc, #99	; 0x63
 c88:	622f7374 	eorvs	r7, pc, #116, 6	; 0xd0000001
 c8c:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
 c90:	706f5f2f 	rsbvc	r5, pc, pc, lsr #30
 c94:	706d5f74 	rsbvc	r5, sp, r4, ror pc
 c98:	7374726f 	cmnvc	r4, #-268435450	; 0xf0000006
 c9c:	6f70645f 	svcvs	0x0070645f
 ca0:	5f737472 	svcpl	0x00737472
 ca4:	736f7263 	cmnvc	pc, #805306374	; 0x30000006
 ca8:	72615f73 	rsbvc	r5, r1, #460	; 0x1cc
 cac:	6f6e2d6d 	svcvs	0x006e2d6d
 cb0:	652d656e 	strvs	r6, [sp, #-1390]!	; 0xfffffa92
 cb4:	2d696261 	sfmcs	f6, 2, [r9, #-388]!	; 0xfffffe7c
 cb8:	2f636367 	svccs	0x00636367
 cbc:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 cc0:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xfffff092
 cc4:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 cc8:	63672d69 	cmnvs	r7, #6720	; 0x1a40
 ccc:	6f772f63 	svcvs	0x00772f63
 cd0:	622f6b72 	eorvs	r6, pc, #116736	; 0x1c800
 cd4:	646c6975 	strbtvs	r6, [ip], #-2421	; 0xfffff68b
 cd8:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 cdc:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 ce0:	61652d65 	cmnvs	r5, r5, ror #26
 ce4:	6c2f6962 			; <UNDEFINED> instruction: 0x6c2f6962
 ce8:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
 cec:	4e470063 	cdpmi	0, 4, cr0, cr7, cr3, {3}
 cf0:	53412055 	movtpl	r2, #4181	; 0x1055
 cf4:	322e3220 	eorcc	r3, lr, #32, 4
 cf8:	00312e33 	eorseq	r2, r1, r3, lsr lr
 cfc:	01278001 			; <UNDEFINED> instruction: 0x01278001
 d00:	00020000 	andeq	r0, r2, r0
 d04:	00000582 	andeq	r0, r0, r2, lsl #11
 d08:	042b0104 	strteq	r0, [fp], #-260	; 0xfffffefc
 d0c:	0f640000 	svceq	0x00640000
 d10:	0f688000 	svceq	0x00688000
 d14:	6f2f8000 	svcvs	0x002f8000
 d18:	6c2f7470 	cfstrsvs	mvf7, [pc], #-448	; b60 <UNLOCKED+0xa61>
 d1c:	6c61636f 	stclvs	3, cr6, [r1], #-444	; 0xfffffe44
 d20:	7261762f 	rsbvc	r7, r1, #49283072	; 0x2f00000
 d24:	63616d2f 	cmnvs	r1, #3008	; 0xbc0
 d28:	74726f70 	ldrbtvc	r6, [r2], #-3952	; 0xfffff090
 d2c:	75622f73 	strbvc	r2, [r2, #-3955]!	; 0xfffff08d
 d30:	2f646c69 	svccs	0x00646c69
 d34:	74706f5f 	ldrbtvc	r6, [r0], #-3935	; 0xfffff0a1
 d38:	6f706d5f 	svcvs	0x00706d5f
 d3c:	5f737472 	svcpl	0x00737472
 d40:	726f7064 	rsbvc	r7, pc, #100	; 0x64
 d44:	635f7374 	cmpvs	pc, #116, 6	; 0xd0000001
 d48:	73736f72 	cmnvc	r3, #456	; 0x1c8
 d4c:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
 d50:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 d54:	61652d65 	cmnvs	r5, r5, ror #26
 d58:	672d6962 	strvs	r6, [sp, -r2, ror #18]!
 d5c:	612f6363 			; <UNDEFINED> instruction: 0x612f6363
 d60:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
 d64:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
 d68:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
 d6c:	6363672d 	cmnvs	r3, #11796480	; 0xb40000
 d70:	726f772f 	rsbvc	r7, pc, #12320768	; 0xbc0000
 d74:	63672f6b 	cmnvs	r7, #428	; 0x1ac
 d78:	2e342d63 	cdpcs	13, 3, cr2, cr4, cr3, {3}
 d7c:	2f322e37 	svccs	0x00322e37
 d80:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
 d84:	632f6363 			; <UNDEFINED> instruction: 0x632f6363
 d88:	69666e6f 	stmdbvs	r6!, {r0, r1, r2, r3, r5, r6, r9, sl, fp, sp, lr}^
 d8c:	72612f67 	rsbvc	r2, r1, #412	; 0x19c
 d90:	696c2f6d 	stmdbvs	ip!, {r0, r2, r3, r5, r6, r8, r9, sl, fp, sp}^
 d94:	75663162 	strbvc	r3, [r6, #-354]!	; 0xfffffe9e
 d98:	2e73636e 	cdpcs	3, 7, cr6, cr3, cr14, {3}
 d9c:	6f2f0053 	svcvs	0x002f0053
 da0:	6c2f7470 	cfstrsvs	mvf7, [pc], #-448	; be8 <UNLOCKED+0xae9>
 da4:	6c61636f 	stclvs	3, cr6, [r1], #-444	; 0xfffffe44
 da8:	7261762f 	rsbvc	r7, r1, #49283072	; 0x2f00000
 dac:	63616d2f 	cmnvs	r1, #3008	; 0xbc0
 db0:	74726f70 	ldrbtvc	r6, [r2], #-3952	; 0xfffff090
 db4:	75622f73 	strbvc	r2, [r2, #-3955]!	; 0xfffff08d
 db8:	2f646c69 	svccs	0x00646c69
 dbc:	74706f5f 	ldrbtvc	r6, [r0], #-3935	; 0xfffff0a1
 dc0:	6f706d5f 	svcvs	0x00706d5f
 dc4:	5f737472 	svcpl	0x00737472
 dc8:	726f7064 	rsbvc	r7, pc, #100	; 0x64
 dcc:	635f7374 	cmpvs	pc, #116, 6	; 0xd0000001
 dd0:	73736f72 	cmnvc	r3, #456	; 0x1c8
 dd4:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
 dd8:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 ddc:	61652d65 	cmnvs	r5, r5, ror #26
 de0:	672d6962 	strvs	r6, [sp, -r2, ror #18]!
 de4:	612f6363 			; <UNDEFINED> instruction: 0x612f6363
 de8:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
 dec:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
 df0:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
 df4:	6363672d 	cmnvs	r3, #11796480	; 0xb40000
 df8:	726f772f 	rsbvc	r7, pc, #12320768	; 0xbc0000
 dfc:	75622f6b 	strbvc	r2, [r2, #-3947]!	; 0xfffff095
 e00:	2f646c69 	svccs	0x00646c69
 e04:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 e08:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xfffff092
 e0c:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 e10:	696c2f69 	stmdbvs	ip!, {r0, r3, r5, r6, r8, r9, sl, fp, sp}^
 e14:	63636762 	cmnvs	r3, #25690112	; 0x1880000
 e18:	554e4700 	strbpl	r4, [lr, #-1792]	; 0xfffff900
 e1c:	20534120 	subscs	r4, r3, r0, lsr #2
 e20:	33322e32 	teqcc	r2, #800	; 0x320
 e24:	0100312e 	tsteq	r0, lr, lsr #2
 e28:	Address 0x0000000000000e28 is out of bounds.


Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
   4:	030b130e 	movweq	r1, #45838	; 0xb30e
   8:	110e1b0e 	tstne	lr, lr, lsl #22
   c:	10061201 	andne	r1, r6, r1, lsl #4
  10:	02000017 	andeq	r0, r0, #23
  14:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  18:	0b3a0e03 	bleq	e8382c <L1_COHERENT+0xe6ec26>
  1c:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
  20:	06120111 			; <UNDEFINED> instruction: 0x06120111
  24:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
  28:	00130119 	andseq	r0, r3, r9, lsl r1
  2c:	00340300 	eorseq	r0, r4, r0, lsl #6
  30:	0b3a0e03 	bleq	e83844 <L1_COHERENT+0xe6ec3e>
  34:	13490b3b 	movtne	r0, #39739	; 0x9b3b
  38:	00001802 	andeq	r1, r0, r2, lsl #16
  3c:	0b002404 	bleq	9054 <L1_NONCOHERENT+0x8436>
  40:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
  44:	0500000e 	streq	r0, [r0, #-14]
  48:	13490035 	movtne	r0, #36917	; 0x9035
  4c:	01000000 	mrseq	r0, (UNDEF: 0)
  50:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
  54:	0e030b13 	vmoveq.32	d3[0], r0
  58:	01110e1b 	tsteq	r1, fp, lsl lr
  5c:	17100612 			; <UNDEFINED> instruction: 0x17100612
  60:	24020000 	strcs	r0, [r2], #-0
  64:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  68:	000e030b 	andeq	r0, lr, fp, lsl #6
  6c:	00160300 	andseq	r0, r6, r0, lsl #6
  70:	0b3a0e03 	bleq	e83884 <L1_COHERENT+0xe6ec7e>
  74:	13490b3b 	movtne	r0, #39739	; 0x9b3b
  78:	24040000 	strcs	r0, [r4], #-0
  7c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
  80:	0008030b 	andeq	r0, r8, fp, lsl #6
  84:	000f0500 	andeq	r0, pc, r0, lsl #10
  88:	13490b0b 	movtne	r0, #39691	; 0x9b0b
  8c:	15060000 	strne	r0, [r6, #-0]
  90:	00192700 	andseq	r2, r9, r0, lsl #14
  94:	01130700 	tsteq	r3, r0, lsl #14
  98:	0b3a0b0b 	bleq	e82ccc <L1_COHERENT+0xe6e0c6>
  9c:	13010b3b 	movwne	r0, #6971	; 0x1b3b
  a0:	0d080000 	stceq	0, cr0, [r8, #-0]
  a4:	3a0e0300 	bcc	380cac <L1_COHERENT+0x36c0a6>
  a8:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  ac:	000b3813 	andeq	r3, fp, r3, lsl r8
  b0:	012e0900 			; <UNDEFINED> instruction: 0x012e0900
  b4:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
  b8:	0b3b0b3a 	bleq	ec2da8 <L1_COHERENT+0xeae1a2>
  bc:	01111927 	tsteq	r1, r7, lsr #18
  c0:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
  c4:	01194297 			; <UNDEFINED> instruction: 0x01194297
  c8:	0a000013 	beq	11c <UNLOCKED+0x1d>
  cc:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
  d0:	0b3a0e03 	bleq	e838e4 <L1_COHERENT+0xe6ecde>
  d4:	13490b3b 	movtne	r0, #39739	; 0x9b3b
  d8:	1301193c 	movwne	r1, #6460	; 0x193c
  dc:	180b0000 	stmdane	fp, {}	; <UNPREDICTABLE>
  e0:	0c000000 	stceq	0, cr0, [r0], {-0}
  e4:	01018289 	smlabbeq	r1, r9, r2, r8
  e8:	13310111 	teqne	r1, #1073741828	; 0x40000004
  ec:	8a0d0000 	bhi	3400f4 <L1_COHERENT+0x32b4ee>
  f0:	02000182 	andeq	r0, r0, #-2147483616	; 0x80000020
  f4:	18429118 	stmdane	r2, {r3, r4, r8, ip, pc}^
  f8:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
  fc:	03193f01 	tsteq	r9, #1, 30
 100:	3b0b3a0e 	blcc	2ce940 <L1_COHERENT+0x2b9d3a>
 104:	8719270b 	ldrhi	r2, [r9, -fp, lsl #14]
 108:	01111901 	tsteq	r1, r1, lsl #18
 10c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 110:	01194297 			; <UNDEFINED> instruction: 0x01194297
 114:	0f000013 	svceq	0x00000013
 118:	08030034 	stmdaeq	r3, {r2, r4, r5}
 11c:	0b3b0b3a 	bleq	ec2e0c <L1_COHERENT+0xeae206>
 120:	17021349 	strne	r1, [r2, -r9, asr #6]
 124:	89100000 	ldmdbhi	r0, {}	; <UNPREDICTABLE>
 128:	11000182 	smlabbne	r0, r2, r1, r0
 12c:	00133101 	andseq	r3, r3, r1, lsl #2
 130:	82891100 	addhi	r1, r9, #0, 2
 134:	01110101 	tsteq	r1, r1, lsl #2
 138:	13011331 	movwne	r1, #4913	; 0x1331
 13c:	01120000 	tsteq	r2, r0
 140:	01134901 	tsteq	r3, r1, lsl #18
 144:	13000013 	movwne	r0, #19
 148:	13490021 	movtne	r0, #36897	; 0x9021
 14c:	00000b2f 	andeq	r0, r0, pc, lsr #22
 150:	03003414 	movweq	r3, #1044	; 0x414
 154:	3b0b3a0e 	blcc	2ce994 <L1_COHERENT+0x2b9d8e>
 158:	3f13490b 	svccc	0x0013490b
 15c:	00180219 	andseq	r0, r8, r9, lsl r2
 160:	00351500 	eorseq	r1, r5, r0, lsl #10
 164:	00001349 	andeq	r1, r0, r9, asr #6
 168:	3f002e16 	svccc	0x00002e16
 16c:	6e193c19 	mrcvs	12, 0, r3, cr9, cr9, {0}
 170:	3a0e030e 	bcc	380db0 <L1_COHERENT+0x36c1aa>
 174:	000b3b0b 	andeq	r3, fp, fp, lsl #22
 178:	11010000 	mrsne	r0, (UNDEF: 1)
 17c:	130e2501 	movwne	r2, #58625	; 0xe501
 180:	1b0e030b 	blne	380db4 <L1_COHERENT+0x36c1ae>
 184:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 188:	00171006 	andseq	r1, r7, r6
 18c:	002e0200 	eoreq	r0, lr, r0, lsl #4
 190:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 194:	0b3b0b3a 	bleq	ec2e84 <L1_COHERENT+0xeae27e>
 198:	01111927 	tsteq	r1, r7, lsr #18
 19c:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 1a0:	00194297 	mulseq	r9, r7, r2
 1a4:	012e0300 			; <UNDEFINED> instruction: 0x012e0300
 1a8:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 1ac:	0b3b0b3a 	bleq	ec2e9c <L1_COHERENT+0xeae296>
 1b0:	01111927 	tsteq	r1, r7, lsr #18
 1b4:	18400612 	stmdane	r0, {r1, r4, r9, sl}^
 1b8:	01194297 			; <UNDEFINED> instruction: 0x01194297
 1bc:	04000013 	streq	r0, [r0], #-19	; 0xffffffed
 1c0:	08030005 	stmdaeq	r3, {r0, r2}
 1c4:	0b3b0b3a 	bleq	ec2eb4 <L1_COHERENT+0xeae2ae>
 1c8:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 1cc:	24050000 	strcs	r0, [r5], #-0
 1d0:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 1d4:	000e030b 	andeq	r0, lr, fp, lsl #6
 1d8:	002e0600 	eoreq	r0, lr, r0, lsl #12
 1dc:	0e03193f 			; <UNDEFINED> instruction: 0x0e03193f
 1e0:	0b3b0b3a 	bleq	ec2ed0 <L1_COHERENT+0xeae2ca>
 1e4:	13491927 	movtne	r1, #39207	; 0x9927
 1e8:	06120111 			; <UNDEFINED> instruction: 0x06120111
 1ec:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 1f0:	07000019 	smladeq	r0, r9, r0, r0
 1f4:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 1f8:	0b3b0b3a 	bleq	ec2ee8 <L1_COHERENT+0xeae2e2>
 1fc:	17021349 	strne	r1, [r2, -r9, asr #6]
 200:	89080000 	stmdbhi	r8, {}	; <UNPREDICTABLE>
 204:	11000182 	smlabbne	r0, r2, r1, r0
 208:	00133101 	andseq	r3, r3, r1, lsl #2
 20c:	000f0900 	andeq	r0, pc, r0, lsl #18
 210:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 214:	2e0a0000 	cdpcs	0, 0, cr0, cr10, cr0, {0}
 218:	03193f01 	tsteq	r9, #1, 30
 21c:	3b0b3a0e 	blcc	2cea5c <L1_COHERENT+0x2b9e56>
 220:	1119270b 	tstne	r9, fp, lsl #14
 224:	40061201 	andmi	r1, r6, r1, lsl #4
 228:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 22c:	890b0000 	stmdbhi	fp, {}	; <UNPREDICTABLE>
 230:	11010182 	smlabbne	r1, r2, r1, r0
 234:	00133101 	andseq	r3, r3, r1, lsl #2
 238:	828a0c00 	addhi	r0, sl, #0, 24
 23c:	18020001 	stmdane	r2, {r0}
 240:	00184291 	mulseq	r8, r1, r2
 244:	11010000 	mrsne	r0, (UNDEF: 1)
 248:	130e2501 	movwne	r2, #58625	; 0xe501
 24c:	1b0e030b 	blne	380e80 <L1_COHERENT+0x36c27a>
 250:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 254:	00171006 	andseq	r1, r7, r6
 258:	00240200 	eoreq	r0, r4, r0, lsl #4
 25c:	0b3e0b0b 	bleq	f82e90 <L1_COHERENT+0xf6e28a>
 260:	00000e03 	andeq	r0, r0, r3, lsl #28
 264:	3f012e03 	svccc	0x00012e03
 268:	3a0e0319 	bcc	380ed4 <L1_COHERENT+0x36c2ce>
 26c:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 270:	010b2019 	tsteq	fp, r9, lsl r0
 274:	04000013 	streq	r0, [r0], #-19	; 0xffffffed
 278:	08030005 	stmdaeq	r3, {r0, r2}
 27c:	0b3b0b3a 	bleq	ec2f6c <L1_COHERENT+0xeae366>
 280:	00001349 	andeq	r1, r0, r9, asr #6
 284:	03003405 	movweq	r3, #1029	; 0x405
 288:	3b0b3a0e 	blcc	2ceac8 <L1_COHERENT+0x2b9ec2>
 28c:	0013490b 	andseq	r4, r3, fp, lsl #18
 290:	000f0600 	andeq	r0, pc, r0, lsl #12
 294:	00000b0b 	andeq	r0, r0, fp, lsl #22
 298:	31012e07 	tstcc	r1, r7, lsl #28
 29c:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 2a0:	97184006 	ldrls	r4, [r8, -r6]
 2a4:	13011942 	movwne	r1, #6466	; 0x1942
 2a8:	05080000 	streq	r0, [r8, #-0]
 2ac:	02133100 	andseq	r3, r3, #0, 2
 2b0:	09000017 	stmdbeq	r0, {r0, r1, r2, r4}
 2b4:	13310034 	teqne	r1, #52	; 0x34
 2b8:	0000061c 	andeq	r0, r0, ip, lsl r6
 2bc:	3100340a 	tstcc	r0, sl, lsl #8
 2c0:	00170213 	andseq	r0, r7, r3, lsl r2
 2c4:	00340b00 	eorseq	r0, r4, r0, lsl #22
 2c8:	00001331 	andeq	r1, r0, r1, lsr r3
 2cc:	3f012e0c 	svccc	0x00012e0c
 2d0:	3a0e0319 	bcc	380f3c <L1_COHERENT+0x36c336>
 2d4:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 2d8:	12011119 	andne	r1, r1, #1073741830	; 0x40000006
 2dc:	97184006 	ldrls	r4, [r8, -r6]
 2e0:	13011942 	movwne	r1, #6466	; 0x1942
 2e4:	1d0d0000 	stcne	0, cr0, [sp, #-0]
 2e8:	11133101 	tstne	r3, r1, lsl #2
 2ec:	58061201 	stmdapl	r6, {r0, r9, ip}
 2f0:	010b590b 	tsteq	fp, fp, lsl #18
 2f4:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 2f8:	0111010b 	tsteq	r1, fp, lsl #2
 2fc:	00000612 	andeq	r0, r0, r2, lsl r6
 300:	31011d0f 	tstcc	r1, pc, lsl #26
 304:	12011113 	andne	r1, r1, #-1073741820	; 0xc0000004
 308:	590b5806 	stmdbpl	fp, {r1, r2, fp, ip, lr}
 30c:	1000000b 	andne	r0, r0, fp
 310:	193f002e 	ldmdbne	pc!, {r1, r2, r3, r5}	; <UNPREDICTABLE>
 314:	0b3a0e03 	bleq	e83b28 <L1_COHERENT+0xe6ef22>
 318:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 31c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 320:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 324:	11000019 	tstne	r0, r9, lsl r0
 328:	08030005 	stmdaeq	r3, {r0, r2}
 32c:	0b3b0b3a 	bleq	ec301c <L1_COHERENT+0xeae416>
 330:	17021349 	strne	r1, [r2, -r9, asr #6]
 334:	89120000 	ldmdbhi	r2, {}	; <UNPREDICTABLE>
 338:	11010182 	smlabbne	r1, r2, r1, r0
 33c:	00133101 	andseq	r3, r3, r1, lsl #2
 340:	828a1300 	addhi	r1, sl, #0, 6
 344:	18020001 	stmdane	r2, {r0}
 348:	00184291 	mulseq	r8, r1, r2
 34c:	00261400 	eoreq	r1, r6, r0, lsl #8
 350:	00001349 	andeq	r1, r0, r9, asr #6
 354:	01828915 	orreq	r8, r2, r5, lsl r9
 358:	31011100 	mrscc	r1, (UNDEF: 17)
 35c:	16000013 			; <UNDEFINED> instruction: 0x16000013
 360:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 364:	0b3a0e03 	bleq	e83b78 <L1_COHERENT+0xe6ef72>
 368:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 36c:	06120111 			; <UNDEFINED> instruction: 0x06120111
 370:	42961840 	addsmi	r1, r6, #64, 16	; 0x400000
 374:	00130119 	andseq	r0, r3, r9, lsl r1
 378:	00051700 	andeq	r1, r5, r0, lsl #14
 37c:	0b3a0e03 	bleq	e83b90 <L1_COHERENT+0xe6ef8a>
 380:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 384:	00001702 	andeq	r1, r0, r2, lsl #14
 388:	03003418 	movweq	r3, #1048	; 0x418
 38c:	3b0b3a0e 	blcc	2cebcc <L1_COHERENT+0x2b9fc6>
 390:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 394:	19000018 	stmdbne	r0, {r3, r4}
 398:	08030034 	stmdaeq	r3, {r2, r4, r5}
 39c:	0b3b0b3a 	bleq	ec308c <L1_COHERENT+0xeae486>
 3a0:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 3a4:	341a0000 	ldrcc	r0, [sl], #-0
 3a8:	3a080300 	bcc	200fb0 <L1_COHERENT+0x1ec3aa>
 3ac:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3b0:	00170213 	andseq	r0, r7, r3, lsl r2
 3b4:	00241b00 	eoreq	r1, r4, r0, lsl #22
 3b8:	0b3e0b0b 	bleq	f82fec <L1_COHERENT+0xf6e3e6>
 3bc:	00000803 	andeq	r0, r0, r3, lsl #16
 3c0:	4901011c 	stmdbmi	r1, {r2, r3, r4, r8}
 3c4:	00130113 	andseq	r0, r3, r3, lsl r1
 3c8:	00211d00 	eoreq	r1, r1, r0, lsl #26
 3cc:	0b2f1349 	bleq	bc50f8 <L1_COHERENT+0xbb04f2>
 3d0:	051e0000 	ldreq	r0, [lr, #-0]
 3d4:	3a080300 	bcc	200fdc <L1_COHERENT+0x1ec3d6>
 3d8:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3dc:	00180213 	andseq	r0, r8, r3, lsl r2
 3e0:	00181f00 	andseq	r1, r8, r0, lsl #30
 3e4:	34200000 	strtcc	r0, [r0], #-0
 3e8:	3a0e0300 	bcc	380ff0 <L1_COHERENT+0x36c3ea>
 3ec:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 3f0:	00170213 	andseq	r0, r7, r3, lsl r2
 3f4:	82892100 	addhi	r2, r9, #0, 2
 3f8:	01110101 	tsteq	r1, r1, lsl #2
 3fc:	13011331 	movwne	r1, #4913	; 0x1331
 400:	0f220000 	svceq	0x00220000
 404:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 408:	00000013 	andeq	r0, r0, r3, lsl r0
 40c:	25011101 	strcs	r1, [r1, #-257]	; 0xfffffeff
 410:	030b130e 	movweq	r1, #45838	; 0xb30e
 414:	110e1b0e 	tstne	lr, lr, lsl #22
 418:	10061201 	andne	r1, r6, r1, lsl #4
 41c:	02000017 	andeq	r0, r0, #23
 420:	0b0b0024 	bleq	2c04b8 <L1_COHERENT+0x2ab8b2>
 424:	0e030b3e 	vmoveq.16	d3[0], r0
 428:	16030000 	strne	r0, [r3], -r0
 42c:	3a0e0300 	bcc	381034 <L1_COHERENT+0x36c42e>
 430:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 434:	04000013 	streq	r0, [r0], #-19	; 0xffffffed
 438:	0b0b0024 	bleq	2c04d0 <L1_COHERENT+0x2ab8ca>
 43c:	08030b3e 	stmdaeq	r3, {r1, r2, r3, r4, r5, r8, r9, fp}
 440:	0f050000 	svceq	0x00050000
 444:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 448:	06000013 			; <UNDEFINED> instruction: 0x06000013
 44c:	19270015 	stmdbne	r7!, {r0, r2, r4}
 450:	2e070000 	cdpcs	0, 0, cr0, cr7, cr0, {0}
 454:	03193f01 	tsteq	r9, #1, 30
 458:	3b0b3a0e 	blcc	2cec98 <L1_COHERENT+0x2ba092>
 45c:	1119270b 	tstne	r9, fp, lsl #14
 460:	40061201 	andmi	r1, r6, r1, lsl #4
 464:	19429618 	stmdbne	r2, {r3, r4, r9, sl, ip, pc}^
 468:	00001301 	andeq	r1, r0, r1, lsl #6
 46c:	03003408 	movweq	r3, #1032	; 0x408
 470:	3b0b3a0e 	blcc	2cecb0 <L1_COHERENT+0x2ba0aa>
 474:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 478:	09000017 	stmdbeq	r0, {r0, r1, r2, r4}
 47c:	0111010b 	tsteq	r1, fp, lsl #2
 480:	13010612 	movwne	r0, #5650	; 0x1612
 484:	340a0000 	strcc	r0, [sl], #-0
 488:	3a0e0300 	bcc	381090 <L1_COHERENT+0x36c48a>
 48c:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 490:	00180213 	andseq	r0, r8, r3, lsl r2
 494:	82890b00 	addhi	r0, r9, #0, 22
 498:	01110101 	tsteq	r1, r1, lsl #2
 49c:	00001331 	andeq	r1, r0, r1, lsr r3
 4a0:	01828a0c 	orreq	r8, r2, ip, lsl #20
 4a4:	91180200 	tstls	r8, r0, lsl #4
 4a8:	00001842 	andeq	r1, r0, r2, asr #16
 4ac:	0182890d 	orreq	r8, r2, sp, lsl #18
 4b0:	31011100 	mrscc	r1, (UNDEF: 17)
 4b4:	0e000013 	mcreq	0, 0, r0, cr0, cr3, {0}
 4b8:	193f012e 	ldmdbne	pc!, {r1, r2, r3, r5, r8}	; <UNPREDICTABLE>
 4bc:	0b3a0e03 	bleq	e83cd0 <L1_COHERENT+0xe6f0ca>
 4c0:	19270b3b 	stmdbne	r7!, {r0, r1, r3, r4, r5, r8, r9, fp}
 4c4:	06120111 			; <UNDEFINED> instruction: 0x06120111
 4c8:	42971840 	addsmi	r1, r7, #64, 16	; 0x400000
 4cc:	00130119 	andseq	r0, r3, r9, lsl r1
 4d0:	00050f00 	andeq	r0, r5, r0, lsl #30
 4d4:	0b3a0803 	bleq	e824e8 <L1_COHERENT+0xe6d8e2>
 4d8:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 4dc:	00001702 	andeq	r1, r0, r2, lsl #14
 4e0:	03000510 	movweq	r0, #1296	; 0x510
 4e4:	3b0b3a0e 	blcc	2ced24 <L1_COHERENT+0x2ba11e>
 4e8:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 4ec:	11000017 	tstne	r0, r7, lsl r0
 4f0:	01018289 	smlabbeq	r1, r9, r2, r8
 4f4:	13310111 	teqne	r1, #1073741828	; 0x40000004
 4f8:	00001301 	andeq	r1, r0, r1, lsl #6
 4fc:	03000512 	movweq	r0, #1298	; 0x512
 500:	3b0b3a08 	blcc	2ced28 <L1_COHERENT+0x2ba122>
 504:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
 508:	13000018 	movwne	r0, #24
 50c:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 510:	0b3b0b3a 	bleq	ec3200 <L1_COHERENT+0xeae5fa>
 514:	18021349 	stmdane	r2, {r0, r3, r6, r8, r9, ip}
 518:	2e140000 	cdpcs	0, 1, cr0, cr4, cr0, {0}
 51c:	03193f00 	tsteq	r9, #0, 30
 520:	3b0b3a0e 	blcc	2ced60 <L1_COHERENT+0x2ba15a>
 524:	1119270b 	tstne	r9, fp, lsl #14
 528:	40061201 	andmi	r1, r6, r1, lsl #4
 52c:	19429718 	stmdbne	r2, {r3, r4, r8, r9, sl, ip, pc}^
 530:	01150000 	tsteq	r5, r0
 534:	01134901 	tsteq	r3, r1, lsl #18
 538:	16000013 			; <UNDEFINED> instruction: 0x16000013
 53c:	13490021 	movtne	r0, #36897	; 0x9021
 540:	00000b2f 	andeq	r0, r0, pc, lsr #22
 544:	03003417 	movweq	r3, #1047	; 0x417
 548:	3b0b3a0e 	blcc	2ced88 <L1_COHERENT+0x2ba182>
 54c:	3f13490b 	svccc	0x0013490b
 550:	00180219 	andseq	r0, r8, r9, lsl r2
 554:	00351800 	eorseq	r1, r5, r0, lsl #16
 558:	00001349 	andeq	r1, r0, r9, asr #6
 55c:	3f002e19 	svccc	0x00002e19
 560:	6e193c19 	mrcvs	12, 0, r3, cr9, cr9, {0}
 564:	3a0e030e 	bcc	3811a4 <L1_COHERENT+0x36c59e>
 568:	000b3b0b 	andeq	r3, fp, fp, lsl #22
 56c:	11010000 	mrsne	r0, (UNDEF: 1)
 570:	11061000 	mrsne	r1, (UNDEF: 6)
 574:	03011201 	movweq	r1, #4609	; 0x1201
 578:	25081b08 	strcs	r1, [r8, #-2824]	; 0xfffff4f8
 57c:	00051308 	andeq	r1, r5, r8, lsl #6
 580:	11010000 	mrsne	r0, (UNDEF: 1)
 584:	11061000 	mrsne	r1, (UNDEF: 6)
 588:	03011201 	movweq	r1, #4609	; 0x1201
 58c:	25081b08 	strcs	r1, [r8, #-2824]	; 0xfffff4f8
 590:	00051308 	andeq	r1, r5, r8, lsl #6
	...

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	andeq	r0, r0, ip, lsl r0
   4:	00000002 	andeq	r0, r0, r2
   8:	00040000 	andeq	r0, r4, r0
   c:	00000000 	andeq	r0, r0, r0
  10:	80000940 	andhi	r0, r0, r0, asr #18
  14:	000000a0 	andeq	r0, r0, r0, lsr #1
	...
  20:	0000001c 	andeq	r0, r0, ip, lsl r0
  24:	00720002 	rsbseq	r0, r2, r2
  28:	00040000 	andeq	r0, r4, r0
  2c:	00000000 	andeq	r0, r0, r0
  30:	800009e0 	andhi	r0, r0, r0, ror #19
  34:	000000c0 	andeq	r0, r0, r0, asr #1
	...
  40:	0000001c 	andeq	r0, r0, ip, lsl r0
  44:	04450002 	strbeq	r0, [r5], #-2
  48:	00040000 	andeq	r0, r4, r0
  4c:	00000000 	andeq	r0, r0, r0
  50:	80000aa0 	andhi	r0, r0, r0, lsr #21
  54:	0000007a 	andeq	r0, r0, sl, ror r0
	...
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	05260002 	streq	r0, [r6, #-2]!
  68:	00040000 	andeq	r0, r4, r0
  6c:	00000000 	andeq	r0, r0, r0
  70:	80000b1c 	andhi	r0, r0, ip, lsl fp
  74:	000002a4 	andeq	r0, r0, r4, lsr #5
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	08fb0002 	ldmeq	fp!, {r1}^
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	80000dc0 	andhi	r0, r0, r0, asr #27
  94:	0000008e 	andeq	r0, r0, lr, lsl #1
	...
  a0:	0000001c 	andeq	r0, r0, ip, lsl r0
  a4:	0bd30002 	bleq	ff4c00b4 <__framebuffer_start+0x7eec00b4>
  a8:	00040000 	andeq	r0, r4, r0
  ac:	00000000 	andeq	r0, r0, r0
  b0:	80000e50 	andhi	r0, r0, r0, asr lr
  b4:	00000114 	andeq	r0, r0, r4, lsl r1
	...
  c0:	0000001c 	andeq	r0, r0, ip, lsl r0
  c4:	0cfe0002 	ldcleq	0, cr0, [lr], #8
  c8:	00040000 	andeq	r0, r4, r0
  cc:	00000000 	andeq	r0, r0, r0
  d0:	80000f64 	andhi	r0, r0, r4, ror #30
  d4:	00000004 	andeq	r0, r0, r4
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	0000004d 	andeq	r0, r0, sp, asr #32
   4:	00290002 	eoreq	r0, r9, r2
   8:	01020000 	mrseq	r0, (UNDEF: 2)
   c:	000d0efb 	strdeq	r0, [sp], -fp
  10:	01010101 	tsteq	r1, r1, lsl #2
  14:	01000000 	mrseq	r0, (UNDEF: 0)
  18:	00010000 	andeq	r0, r1, r0
  1c:	656d6974 	strbvs	r6, [sp, #-2420]!	; 0xfffff68c
  20:	6e695f72 	mcrvs	15, 3, r5, cr9, cr2, {3}
  24:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
  28:	73747075 	cmnvc	r4, #117	; 0x75
  2c:	0000632e 	andeq	r6, r0, lr, lsr #6
  30:	00000000 	andeq	r0, r0, r0
  34:	09400205 	stmdbeq	r0, {r0, r2, r9}^
  38:	22038000 	andcs	r8, r3, #0
  3c:	76502101 	ldrbvc	r2, [r0], -r1, lsl #2
  40:	5a755b78 	bpl	1d56e28 <L1_COHERENT+0x1d42222>
  44:	84845b59 	strhi	r5, [r4], #2905	; 0xb59
  48:	3d5b3169 	ldfcce	f3, [fp, #-420]	; 0xfffffe5c
  4c:	01000202 	tsteq	r0, r2, lsl #4
  50:	0000f201 	andeq	pc, r0, r1, lsl #4
  54:	b6000200 	strlt	r0, [r0], -r0, lsl #4
  58:	02000000 	andeq	r0, r0, #0
  5c:	0d0efb01 	vstreq	d15, [lr, #-4]
  60:	01010100 	mrseq	r0, (UNDEF: 17)
  64:	00000001 	andeq	r0, r0, r1
  68:	01000001 	tsteq	r0, r1
  6c:	7273752f 	rsbsvc	r7, r3, #197132288	; 0xbc00000
  70:	636e692f 	cmnvs	lr, #770048	; 0xbc000
  74:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
  78:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
  7c:	2f62696c 	svccs	0x0062696c
  80:	6863616d 	stmdavs	r3!, {r0, r2, r3, r5, r6, r8, sp, lr}^
  84:	00656e69 	rsbeq	r6, r5, r9, ror #28
  88:	7273752f 	rsbsvc	r7, r3, #197132288	; 0xbc00000
  8c:	636e692f 	cmnvs	lr, #770048	; 0xbc000
  90:	6564756c 	strbvs	r7, [r4, #-1388]!	; 0xfffffa94
  94:	77656e2f 	strbvc	r6, [r5, -pc, lsr #28]!
  98:	2f62696c 	svccs	0x0062696c
  9c:	00737973 	rsbseq	r7, r3, r3, ror r9
  a0:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
  a4:	00632e6e 	rsbeq	r2, r3, lr, ror #28
  a8:	5f000000 	svcpl	0x00000000
  ac:	61666564 	cmnvs	r6, r4, ror #10
  b0:	5f746c75 	svcpl	0x00746c75
  b4:	65707974 	ldrbvs	r7, [r0, #-2420]!	; 0xfffff68c
  b8:	00682e73 	rsbeq	r2, r8, r3, ror lr
  bc:	5f000001 	svcpl	0x00000001
  c0:	69647473 	stmdbvs	r4!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
  c4:	682e746e 	stmdavs	lr!, {r1, r2, r3, r5, r6, sl, ip, sp, lr}
  c8:	00000200 	andeq	r0, r0, r0, lsl #4
  cc:	4d5f504d 	ldclmi	0, cr5, [pc, #-308]	; ffffffa0 <__framebuffer_start+0x7f9fffa0>
  d0:	78657475 	stmdavc	r5!, {r0, r2, r4, r5, r6, sl, ip, sp, lr}^
  d4:	682e7365 	stmdavs	lr!, {r0, r2, r5, r6, r8, r9, ip, sp, lr}
  d8:	00000000 	andeq	r0, r0, r0
  dc:	67727365 	ldrbvs	r7, [r2, -r5, ror #6]!
  e0:	746e495f 	strbtvc	r4, [lr], #-2399	; 0xfffff6a1
  e4:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
  e8:	682e7470 	stmdavs	lr!, {r4, r5, r6, sl, ip, sp, lr}
  ec:	00000000 	andeq	r0, r0, r0
  f0:	682e3776 	stmdavs	lr!, {r1, r2, r4, r5, r6, r8, r9, sl, ip, sp}
  f4:	00000000 	andeq	r0, r0, r0
  f8:	535f504d 	cmppl	pc, #77	; 0x4d
  fc:	682e5543 	stmdavs	lr!, {r0, r1, r6, r8, sl, ip, lr}
 100:	00000000 	andeq	r0, r0, r0
 104:	475f504d 	ldrbmi	r5, [pc, -sp, asr #32]
 108:	682e4349 	stmdavs	lr!, {r0, r3, r6, r8, r9, lr}
 10c:	00000000 	andeq	r0, r0, r0
 110:	02050000 	andeq	r0, r5, #0
 114:	800009e0 	andhi	r0, r0, r0, ror #19
 118:	22011003 	andcs	r1, r1, #3
 11c:	25582203 	ldrbcs	r2, [r8, #-515]	; 0xfffffdfd
 120:	3e3e2f2f 	cdpcc	15, 3, cr2, cr14, cr15, {1}
 124:	04020035 	streq	r0, [r2], #-53	; 0xffffffcb
 128:	0d034c01 	stceq	12, cr4, [r3, #-4]
 12c:	2f2f2358 	svccs	0x002f2358
 130:	30660903 	rsbcc	r0, r6, r3, lsl #18
 134:	764d3d3d 			; <UNDEFINED> instruction: 0x764d3d3d
 138:	305d212f 	subscc	r2, sp, pc, lsr #2
 13c:	21425c4d 	cmpcs	r2, sp, asr #24
 140:	07022179 	smlsdxeq	r2, r9, r1, r2
 144:	51010100 	mrspl	r0, (UNDEF: 17)
 148:	02000000 	andeq	r0, r0, #0
 14c:	00001d00 	andeq	r1, r0, r0, lsl #26
 150:	fb010200 	blx	4095a <L1_COHERENT+0x2bd54>
 154:	01000d0e 	tsteq	r0, lr, lsl #26
 158:	00010101 	andeq	r0, r1, r1, lsl #2
 15c:	00010000 	andeq	r0, r1, r0
 160:	75000100 	strvc	r0, [r0, #-256]	; 0xffffff00
 164:	2e747261 	cdpcs	2, 7, cr7, cr4, cr1, {3}
 168:	00000063 	andeq	r0, r0, r3, rrx
 16c:	05000000 	streq	r0, [r0, #-0]
 170:	000aa002 	andeq	sl, sl, r2
 174:	01100380 	tsteq	r0, r0, lsl #7
 178:	0013a113 	andseq	sl, r3, r3, lsl r1
 17c:	06010402 	streq	r0, [r1], -r2, lsl #8
 180:	5b4b063c 	blpl	12c1a78 <L1_COHERENT+0x12ace72>
 184:	04020013 	streq	r0, [r2], #-19	; 0xffffffed
 188:	063c0601 	ldrteq	r0, [ip], -r1, lsl #12
 18c:	2f234b4b 	svccs	0x00234b4b
 190:	2f5c2d3d 	svccs	0x005c2d3d
 194:	024e2d3d 	subeq	r2, lr, #3904	; 0xf40
 198:	01010004 	tsteq	r1, r4
 19c:	000000e0 	andeq	r0, r0, r0, ror #1
 1a0:	00230002 	eoreq	r0, r3, r2
 1a4:	01020000 	mrseq	r0, (UNDEF: 2)
 1a8:	000d0efb 	strdeq	r0, [sp], -fp
 1ac:	01010101 	tsteq	r1, r1, lsl #2
 1b0:	01000000 	mrseq	r0, (UNDEF: 0)
 1b4:	00010000 	andeq	r0, r1, r0
 1b8:	5f63786d 	svcpl	0x0063786d
 1bc:	69726573 	ldmdbvs	r2!, {r0, r1, r4, r5, r6, r8, sl, sp, lr}^
 1c0:	632e6c61 			; <UNDEFINED> instruction: 0x632e6c61
 1c4:	00000000 	andeq	r0, r0, r0
 1c8:	02050000 	andeq	r0, r5, #0
 1cc:	80000b1c 	andhi	r0, r0, ip, lsl fp
 1d0:	5c302315 	ldcpl	3, cr2, [r0], #-84	; 0xffffffac
 1d4:	03222130 			; <UNDEFINED> instruction: 0x03222130
 1d8:	0a034a76 	beq	d2bb8 <L1_COHERENT+0xbdfb2>
 1dc:	0322232e 			; <UNDEFINED> instruction: 0x0322232e
 1e0:	0c034a74 			; <UNDEFINED> instruction: 0x0c034a74
 1e4:	0376232e 	cmneq	r6, #-1207959552	; 0xb8000000
 1e8:	0d035873 	stceq	8, cr5, [r3, #-460]	; 0xfffffe34
 1ec:	0331222e 	teqeq	r1, #-536870910	; 0xe0000002
 1f0:	0a030171 	beq	c07bc <L1_COHERENT+0xabbb6>
 1f4:	90760366 	rsbsls	r0, r6, r6, ror #6
 1f8:	0b036b5d 	bleq	daf74 <L1_COHERENT+0xc636e>
 1fc:	5967139e 	stmdbpl	r7!, {r1, r2, r3, r4, r7, r8, r9, ip}^
 200:	004d2178 	subeq	r2, sp, r8, ror r1
 204:	06010402 	streq	r0, [r1], -r2, lsl #8
 208:	2f4e063c 	svccs	0x004e063c
 20c:	214a0903 	cmpcs	sl, r3, lsl #18
 210:	02004c59 	andeq	r4, r0, #22784	; 0x5900
 214:	3c060104 	stfccs	f0, [r6], {4}
 218:	67674c06 	strbvs	r4, [r7, -r6, lsl #24]!
 21c:	304c5a59 	subcc	r5, ip, r9, asr sl
 220:	00507a68 	subseq	r7, r0, r8, ror #20
 224:	06010402 	streq	r0, [r1], -r2, lsl #8
 228:	0402002e 	streq	r0, [r2], #-46	; 0xffffffd2
 22c:	003d0601 	eorseq	r0, sp, r1, lsl #12
 230:	2d010402 	cfstrscs	mvf0, [r1, #-8]
 234:	00303e23 	eorseq	r3, r0, r3, lsr #28
 238:	06010402 	streq	r0, [r1], -r2, lsl #8
 23c:	04020066 	streq	r0, [r2], #-102	; 0xffffff9a
 240:	769f0601 	ldrvc	r0, [pc], r1, lsl #12
 244:	494b763d 	stmdbmi	fp, {r0, r2, r3, r4, r5, r9, sl, ip, sp, lr}^
 248:	03424d30 	movteq	r4, #11568	; 0x2d30
 24c:	03408211 	movteq	r8, #529	; 0x211
 250:	2f304a6d 	svccs	0x00304a6d
 254:	cb302f22 	blgt	c0bee4 <L1_COHERENT+0xbf72de>
 258:	22912391 	addscs	r2, r1, #1140850690	; 0x44000002
 25c:	02004b4b 	andeq	r4, r0, #76800	; 0x12c00
 260:	003d0204 	eorseq	r0, sp, r4, lsl #4
 264:	2d020402 	cfstrscs	mvf0, [r2, #-8]
 268:	233d3448 	teqcs	sp, #72, 8	; 0x48000000
 26c:	74033d3d 	strvc	r3, [r3], #-3389	; 0xfffff2c3
 270:	04020020 	streq	r0, [r2], #-32	; 0xffffffe0
 274:	206c0302 	rsbcs	r0, ip, r2, lsl #6
 278:	02582303 	subseq	r2, r8, #201326592	; 0xc000000
 27c:	01010004 	tsteq	r1, r4
 280:	000000c6 	andeq	r0, r0, r6, asr #1
 284:	009c0002 	addseq	r0, ip, r2
 288:	01020000 	mrseq	r0, (UNDEF: 2)
 28c:	000d0efb 	strdeq	r0, [sp], -fp
 290:	01010101 	tsteq	r1, r1, lsl #2
 294:	01000000 	mrseq	r0, (UNDEF: 0)
 298:	2f010000 	svccs	0x00010000
 29c:	2f727375 	svccs	0x00727375
 2a0:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 2a4:	2f656475 	svccs	0x00656475
 2a8:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 2ac:	6d2f6269 	sfmvs	f6, 4, [pc, #-420]!	; 110 <UNLOCKED+0x11>
 2b0:	69686361 	stmdbvs	r8!, {r0, r5, r6, r8, r9, sp, lr}^
 2b4:	2f00656e 	svccs	0x0000656e
 2b8:	2f727375 	svccs	0x00727375
 2bc:	6c636e69 	stclvs	14, cr6, [r3], #-420	; 0xfffffe5c
 2c0:	2f656475 	svccs	0x00656475
 2c4:	6c77656e 	cfldr64vs	mvdx6, [r7], #-440	; 0xfffffe48
 2c8:	732f6269 			; <UNDEFINED> instruction: 0x732f6269
 2cc:	00007379 	andeq	r7, r0, r9, ror r3
 2d0:	67727365 	ldrbvs	r7, [r2, -r5, ror #6]!
 2d4:	746e495f 	strbtvc	r4, [lr], #-2399	; 0xfffff6a1
 2d8:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
 2dc:	632e7470 			; <UNDEFINED> instruction: 0x632e7470
 2e0:	00000000 	andeq	r0, r0, r0
 2e4:	6665645f 			; <UNDEFINED> instruction: 0x6665645f
 2e8:	746c7561 	strbtvc	r7, [ip], #-1377	; 0xfffffa9f
 2ec:	7079745f 	rsbsvc	r7, r9, pc, asr r4
 2f0:	682e7365 	stmdavs	lr!, {r0, r2, r5, r6, r8, r9, ip, sp, lr}
 2f4:	00000100 	andeq	r0, r0, r0, lsl #2
 2f8:	6474735f 	ldrbtvs	r7, [r4], #-863	; 0xfffffca1
 2fc:	2e746e69 	cdpcs	14, 7, cr6, cr4, cr9, {3}
 300:	00020068 	andeq	r0, r2, r8, rrx
 304:	72736500 	rsbsvc	r6, r3, #0, 10
 308:	6e495f67 	cdpvs	15, 4, cr5, cr9, cr7, {3}
 30c:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
 310:	2e747075 	mrccs	0, 3, r7, cr4, cr5, {3}
 314:	00000068 	andeq	r0, r0, r8, rrx
 318:	5f504d00 	svcpl	0x00504d00
 31c:	2e434947 	vmlscs.f16	s9, s6, s14	; <UNPREDICTABLE>
 320:	00000068 	andeq	r0, r0, r8, rrx
 324:	05000000 	streq	r0, [r0, #-0]
 328:	000dc002 	andeq	ip, sp, r2
 32c:	010a0380 	smlabbeq	sl, r0, r3, r0
 330:	3f3d3f22 	svccc	0x003d3f22
 334:	676a312f 	strbvs	r3, [sl, -pc, lsr #2]!
 338:	5f772521 	svcpl	0x00772521
 33c:	3d3d3f21 	ldccc	15, cr3, [sp, #-132]!	; 0xffffff7c
 340:	135b4b3d 	cmpne	fp, #62464	; 0xf400
 344:	00010285 	andeq	r0, r1, r5, lsl #5
 348:	00dd0101 	sbcseq	r0, sp, r1, lsl #2
 34c:	00020000 	andeq	r0, r2, r0
 350:	0000009e 	muleq	r0, lr, r0
 354:	0efb0102 	cdpeq	1, 15, cr0, cr11, cr2, {0}
 358:	0101000d 	tsteq	r1, sp
 35c:	00000101 	andeq	r0, r0, r1, lsl #2
 360:	00000100 	andeq	r0, r0, r0, lsl #2
 364:	706f2f01 	rsbvc	r2, pc, r1, lsl #30
 368:	6f6c2f74 	svcvs	0x006c2f74
 36c:	2f6c6163 	svccs	0x006c6163
 370:	2f726176 	svccs	0x00726176
 374:	7063616d 	rsbvc	r6, r3, sp, ror #2
 378:	7374726f 	cmnvc	r4, #-268435450	; 0xf0000006
 37c:	6975622f 	ldmdbvs	r5!, {r0, r1, r2, r3, r5, r9, sp, lr}^
 380:	5f2f646c 	svcpl	0x002f646c
 384:	5f74706f 	svcpl	0x0074706f
 388:	726f706d 	rsbvc	r7, pc, #109	; 0x6d
 38c:	645f7374 	ldrbvs	r7, [pc], #-884	; 394 <UNLOCKED+0x295>
 390:	74726f70 	ldrbtvc	r6, [r2], #-3952	; 0xfffff090
 394:	72635f73 	rsbvc	r5, r3, #460	; 0x1cc
 398:	5f73736f 	svcpl	0x0073736f
 39c:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
 3a0:	656e6f6e 	strbvs	r6, [lr, #-3950]!	; 0xfffff092
 3a4:	6261652d 	rsbvs	r6, r1, #188743680	; 0xb400000
 3a8:	63672d69 	cmnvs	r7, #6720	; 0x1a40
 3ac:	72612f63 	rsbvc	r2, r1, #396	; 0x18c
 3b0:	6f6e2d6d 	svcvs	0x006e2d6d
 3b4:	652d656e 	strvs	r6, [sp, #-1390]!	; 0xfffffa92
 3b8:	2d696261 	sfmcs	f6, 2, [r9, #-388]!	; 0xfffffe7c
 3bc:	2f636367 	svccs	0x00636367
 3c0:	6b726f77 	blvs	1c9c1a4 <L1_COHERENT+0x1c8759e>
 3c4:	6363672f 	cmnvs	r3, #12320768	; 0xbc0000
 3c8:	372e342d 	strcc	r3, [lr, -sp, lsr #8]!
 3cc:	6c2f322e 	sfmvs	f3, 4, [pc], #-184	; 31c <UNLOCKED+0x21d>
 3d0:	63676269 	cmnvs	r7, #-1879048186	; 0x90000006
 3d4:	6f632f63 	svcvs	0x00632f63
 3d8:	6769666e 	strbvs	r6, [r9, -lr, ror #12]!
 3dc:	6d72612f 	ldfvse	f6, [r2, #-188]!	; 0xffffff44
 3e0:	696c0000 	stmdbvs	ip!, {}^	; <UNPREDICTABLE>
 3e4:	75663162 	strbvc	r3, [r6, #-354]!	; 0xfffffe9e
 3e8:	2e73636e 	cdpcs	3, 7, cr6, cr3, cr14, {3}
 3ec:	00010053 	andeq	r0, r1, r3, asr r0
 3f0:	05000000 	streq	r0, [r0, #-0]
 3f4:	000e5002 	andeq	r5, lr, r2
 3f8:	07cc0380 	strbeq	r0, [ip, r0, lsl #7]
 3fc:	2f2f3001 	svccs	0x002f3001
 400:	032f2f2f 			; <UNDEFINED> instruction: 0x032f2f2f
 404:	032e7cfe 			; <UNDEFINED> instruction: 0x032e7cfe
 408:	3e020386 	cdpcc	3, 0, cr0, cr2, cr6, {4}
 40c:	2f312f01 	svccs	0x00312f01
 410:	7db7032f 	ldcvc	3, cr0, [r7, #188]!	; 0xbc
 414:	02cd032e 	sbceq	r0, sp, #-1207959552	; 0xb8000000
 418:	322f9008 	eorcc	r9, pc, #8
 41c:	2f661603 	svccs	0x00661603
 420:	2f2f2f2f 	svccs	0x002f2f2f
 424:	02022f2f 	andeq	r2, r2, #47, 30	; 0xbc
 428:	b4010100 	strlt	r0, [r1], #-256	; 0xffffff00
 42c:	02000000 	andeq	r0, r0, #0
 430:	00009e00 	andeq	r9, r0, r0, lsl #28
 434:	fb010200 	blx	40c3e <L1_COHERENT+0x2c038>
 438:	01000d0e 	tsteq	r0, lr, lsl #26
 43c:	00010101 	andeq	r0, r1, r1, lsl #2
 440:	00010000 	andeq	r0, r1, r0
 444:	6f2f0100 	svcvs	0x002f0100
 448:	6c2f7470 	cfstrsvs	mvf7, [pc], #-448	; 290 <UNLOCKED+0x191>
 44c:	6c61636f 	stclvs	3, cr6, [r1], #-444	; 0xfffffe44
 450:	7261762f 	rsbvc	r7, r1, #49283072	; 0x2f00000
 454:	63616d2f 	cmnvs	r1, #3008	; 0xbc0
 458:	74726f70 	ldrbtvc	r6, [r2], #-3952	; 0xfffff090
 45c:	75622f73 	strbvc	r2, [r2, #-3955]!	; 0xfffff08d
 460:	2f646c69 	svccs	0x00646c69
 464:	74706f5f 	ldrbtvc	r6, [r0], #-3935	; 0xfffff0a1
 468:	6f706d5f 	svcvs	0x00706d5f
 46c:	5f737472 	svcpl	0x00737472
 470:	726f7064 	rsbvc	r7, pc, #100	; 0x64
 474:	635f7374 	cmpvs	pc, #116, 6	; 0xd0000001
 478:	73736f72 	cmnvc	r3, #456	; 0x1c8
 47c:	6d72615f 	ldfvse	f6, [r2, #-380]!	; 0xfffffe84
 480:	6e6f6e2d 	cdpvs	14, 6, cr6, cr15, cr13, {1}
 484:	61652d65 	cmnvs	r5, r5, ror #26
 488:	672d6962 	strvs	r6, [sp, -r2, ror #18]!
 48c:	612f6363 			; <UNDEFINED> instruction: 0x612f6363
 490:	6e2d6d72 	mcrvs	13, 1, r6, cr13, cr2, {3}
 494:	2d656e6f 	stclcs	14, cr6, [r5, #-444]!	; 0xfffffe44
 498:	69626165 	stmdbvs	r2!, {r0, r2, r5, r6, r8, sp, lr}^
 49c:	6363672d 	cmnvs	r3, #11796480	; 0xb40000
 4a0:	726f772f 	rsbvc	r7, pc, #12320768	; 0xbc0000
 4a4:	63672f6b 	cmnvs	r7, #428	; 0x1ac
 4a8:	2e342d63 	cdpcs	13, 3, cr2, cr4, cr3, {3}
 4ac:	2f322e37 	svccs	0x00322e37
 4b0:	6762696c 	strbvs	r6, [r2, -ip, ror #18]!
 4b4:	632f6363 			; <UNDEFINED> instruction: 0x632f6363
 4b8:	69666e6f 	stmdbvs	r6!, {r0, r1, r2, r3, r5, r6, r9, sl, fp, sp, lr}^
 4bc:	72612f67 	rsbvc	r2, r1, #412	; 0x19c
 4c0:	6c00006d 	stcvs	0, cr0, [r0], {109}	; 0x6d
 4c4:	66316269 	ldrtvs	r6, [r1], -r9, ror #4
 4c8:	73636e75 	cmnvc	r3, #1872	; 0x750
 4cc:	0100532e 	tsteq	r0, lr, lsr #6
 4d0:	00000000 	andeq	r0, r0, r0
 4d4:	0f640205 	svceq	0x00640205
 4d8:	93038000 	movwls	r8, #12288	; 0x3000
 4dc:	0202010a 	andeq	r0, r2, #-2147483646	; 0x80000002
 4e0:	Address 0x00000000000004e0 is out of bounds.


Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	74696e69 	strbtvc	r6, [r9], #-3689	; 0xfffff197
   4:	6d69745f 	cfstrdvs	mvd7, [r9, #-380]!	; 0xfffffe84
   8:	47007265 	strmi	r7, [r0, -r5, ror #4]
   c:	4320554e 			; <UNDEFINED> instruction: 0x4320554e
  10:	35203131 	strcc	r3, [r0, #-305]!	; 0xfffffecf
  14:	312e342e 			; <UNDEFINED> instruction: 0x312e342e
  18:	31303220 	teqcc	r0, r0, lsr #4
  1c:	31393036 	teqcc	r9, r6, lsr r0
  20:	6d2d2039 	stcvs	0, cr2, [sp, #-228]!	; 0xffffff1c
  24:	3d757063 	ldclcc	0, cr7, [r5, #-396]!	; 0xfffffe74
  28:	74726f63 	ldrbtvc	r6, [r2], #-3939	; 0xfffff09d
  2c:	612d7865 			; <UNDEFINED> instruction: 0x612d7865
  30:	6d2d2039 	stcvs	0, cr2, [sp, #-228]!	; 0xffffff1c
  34:	616f6c66 	cmnvs	pc, r6, ror #24
  38:	62612d74 	rsbvs	r2, r1, #116, 26	; 0x1d00
  3c:	61683d69 	cmnvs	r8, r9, ror #26
  40:	2d206472 	cfstrscs	mvf6, [r0, #-456]!	; 0xfffffe38
  44:	7570666d 	ldrbvc	r6, [r0, #-1645]!	; 0xfffff993
  48:	7066763d 	rsbvc	r7, r6, sp, lsr r6
  4c:	642d3376 	strtvs	r3, [sp], #-886	; 0xfffffc8a
  50:	2d203631 	stccs	6, cr3, [r0, #-196]!	; 0xffffff3c
  54:	7568746d 	strbvc	r7, [r8, #-1133]!	; 0xfffffb93
  58:	2d20626d 	sfmcs	f6, 4, [r0, #-436]!	; 0xfffffe4c
  5c:	4f2d2067 	svcmi	0x002d2067
  60:	72700031 	rsbsvc	r0, r0, #49	; 0x31
  64:	69726f69 	ldmdbvs	r2!, {r0, r3, r5, r6, r8, r9, sl, fp, sp, lr}^
  68:	74007974 	strvc	r7, [r0], #-2420	; 0xfffff68c
  6c:	72656d69 	rsbvc	r6, r5, #6720	; 0x1a40
  70:	746e695f 	strbtvc	r6, [lr], #-2399	; 0xfffff6a1
  74:	75727265 	ldrbvc	r7, [r2, #-613]!	; 0xfffffd9b
  78:	2e737470 	mrccs	4, 3, r7, cr3, cr0, {3}
  7c:	72690063 	rsbvc	r0, r9, #99	; 0x63
  80:	64695f71 	strbtvs	r5, [r9], #-3953	; 0xfffff08f
  84:	6f682f00 	svcvs	0x00682f00
  88:	612f656d 			; <UNDEFINED> instruction: 0x612f656d
  8c:	7265646e 	rsbvc	r6, r5, #1845493760	; 0x6e000000
  90:	626e6573 	rsbvs	r6, lr, #482344960	; 0x1cc00000
  94:	2f646e6f 	svccs	0x00646e6f
  98:	6b736544 	blvs	1cd95b0 <L1_COHERENT+0x1cc49aa>
  9c:	2f706f74 	svccs	0x00706f74
  a0:	36584d49 	ldrbcc	r4, [r8], -r9, asr #26
  a4:	2f445351 	svccs	0x00445351
  a8:	78455f41 	stmdavc	r5, {r0, r6, r8, r9, sl, fp, ip, lr}^
  ac:	6c706d61 	ldclvs	13, cr6, [r0], #-388	; 0xfffffe7c
  b0:	73642f65 	cmnvc	r4, #404	; 0x194
  b4:	6178455f 	cmnvs	r8, pc, asr r5
  b8:	656c706d 	strbvs	r7, [ip, #-109]!	; 0xffffff93
  bc:	7269662f 	rsbvc	r6, r9, #49283072	; 0x2f00000
  c0:	726f7765 	rsbvc	r7, pc, #26476544	; 0x1940000
  c4:	415f736b 	cmpmi	pc, fp, ror #6
  c8:	56462d39 			; <UNDEFINED> instruction: 0x56462d39
  cc:	43475f50 	movtmi	r5, #32592	; 0x7f50
  d0:	72732f43 	rsbsvc	r2, r3, #268	; 0x10c
  d4:	756d0063 	strbvc	r0, [sp, #-99]!	; 0xffffff9d
  d8:	5f786574 	svcpl	0x00786574
  dc:	65730074 	ldrbvs	r0, [r3, #-116]!	; 0xffffff8c
  e0:	4753646e 	ldrbmi	r6, [r3, -lr, ror #8]
  e4:	5f5f0049 	svcpl	0x005f0049
  e8:	6c6c616d 	stfvse	f6, [ip], #-436	; 0xfffffe4c
  ec:	6c5f636f 	mrrcvs	3, 6, r6, pc, cr15	; <UNPREDICTABLE>
  f0:	006b636f 	rsbeq	r6, fp, pc, ror #6
  f4:	62616e65 	rsbvs	r6, r1, #1616	; 0x650
  f8:	6143656c 	cmpvs	r3, ip, ror #10
  fc:	73656863 	cmnvc	r5, #6488064	; 0x630000
 100:	6f687300 	svcvs	0x00687300
 104:	69207472 	stmdbvs	r0!, {r1, r4, r5, r6, sl, ip, sp, lr}
 108:	6500746e 	strvs	r7, [r0, #-1134]	; 0xfffffb92
 10c:	6c62616e 	stfvse	f6, [r2], #-440	; 0xfffffe48
 110:	746e4965 	strbtvc	r4, [lr], #-2405	; 0xfffff69b
 114:	6d004449 	cfstrsvs	mvf4, [r0, #-292]	; 0xfffffedc
 118:	5f6e6961 	svcpl	0x006e6961
 11c:	00707061 	rsbseq	r7, r0, r1, rrx
 120:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
 124:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
 128:	6e750074 	mrcvs	0, 3, r0, cr5, cr4, {3}
 12c:	6e676973 			; <UNDEFINED> instruction: 0x6e676973
 130:	63206465 			; <UNDEFINED> instruction: 0x63206465
 134:	00726168 	rsbseq	r6, r2, r8, ror #2
 138:	6f6c6e75 	svcvs	0x006c6e75
 13c:	754d6b63 	strbvc	r6, [sp, #-2915]	; 0xfffff49d
 140:	00786574 	rsbseq	r6, r8, r4, ror r5
 144:	67727365 	ldrbvs	r7, [r2, -r5, ror #6]!
 148:	6765525f 			; <UNDEFINED> instruction: 0x6765525f
 14c:	65747369 	ldrbvs	r7, [r4, #-873]!	; 0xfffffc97
 150:	52495f72 	subpl	r5, r9, #456	; 0x1c8
 154:	68730053 	ldmdavs	r3!, {r0, r1, r4, r6}^
 158:	2074726f 	rsbscs	r7, r4, pc, ror #4
 15c:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
 160:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xfffff199
 164:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
 168:	6d5f5f00 	ldclvs	15, cr5, [pc, #-0]	; 170 <UNLOCKED+0x71>
 16c:	6f6c6c61 	svcvs	0x006c6c61
 170:	6e755f63 	cdpvs	15, 7, cr5, cr5, cr3, {3}
 174:	6b636f6c 	blvs	18dbf2c <L1_COHERENT+0x18c7326>
 178:	755f5f00 	ldrbvc	r5, [pc, #-3840]	; fffff280 <__framebuffer_start+0x7f9ff280>
 17c:	33746e69 	cmncc	r4, #1680	; 0x690
 180:	00745f32 	rsbseq	r5, r4, r2, lsr pc
 184:	74726175 	ldrbtvc	r6, [r2], #-373	; 0xfffffe8b
 188:	7475705f 	ldrbtvc	r7, [r5], #-95	; 0xffffffa1
 18c:	6f705f63 	svcvs	0x00705f63
 190:	64656c6c 	strbtvs	r6, [r5], #-3180	; 0xfffff394
 194:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
 198:	6573006e 	ldrbvs	r0, [r3, #-110]!	; 0xffffff92
 19c:	746e4974 	strbtvc	r4, [lr], #-2420	; 0xfffff68c
 1a0:	6f697250 	svcvs	0x00697250
 1a4:	79746972 	ldmdbvc	r4!, {r1, r4, r5, r6, r8, fp, sp, lr}^
 1a8:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
 1ac:	49555043 	ldmdbmi	r5, {r0, r1, r6, ip, lr}^
 1b0:	6e650044 	cdpvs	0, 6, cr0, cr5, cr4, {2}
 1b4:	656c6261 	strbvs	r6, [ip, #-609]!	; 0xfffffd9f
 1b8:	6e617242 	cdpvs	2, 6, cr7, cr1, cr2, {2}
 1bc:	72506863 	subsvc	r6, r0, #6488064	; 0x630000
 1c0:	63696465 	cmnvs	r9, #1694498816	; 0x65000000
 1c4:	6e6f6974 			; <UNDEFINED> instruction: 0x6e6f6974
 1c8:	6e6f6c00 	cdpvs	12, 6, cr6, cr15, cr0, {0}
 1cc:	6f6c2067 	svcvs	0x006c2067
 1d0:	7520676e 	strvc	r6, [r0, #-1902]!	; 0xfffff892
 1d4:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
 1d8:	2064656e 	rsbcs	r6, r4, lr, ror #10
 1dc:	00746e69 	rsbseq	r6, r4, r9, ror #28
 1e0:	74696e69 	strbtvc	r6, [r9], #-3689	; 0xfffff197
 1e4:	6574754d 	ldrbvs	r7, [r4, #-1357]!	; 0xfffffab3
 1e8:	69730078 	ldmdbvs	r3!, {r3, r4, r5, r6}^
 1ec:	7974657a 	ldmdbvc	r4!, {r1, r3, r4, r5, r6, r8, sl, sp, lr}^
 1f0:	6c006570 	cfstr32vs	mvfx6, [r0], {112}	; 0x70
 1f4:	20676e6f 	rsbcs	r6, r7, pc, ror #28
 1f8:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
 1fc:	746e6920 	strbtvc	r6, [lr], #-2336	; 0xfffff6e0
 200:	72736500 	rsbsvc	r6, r3, #0, 10
 204:	53495f67 	movtpl	r5, #40807	; 0x9f67
 208:	65565f52 	ldrbvs	r5, [r6, #-3922]	; 0xfffff0ae
 20c:	726f7463 	rsbvc	r7, pc, #1660944384	; 0x63000000
 210:	69616d00 	stmdbvs	r1!, {r8, sl, fp, sp, lr}^
 214:	00632e6e 	rsbeq	r2, r3, lr, ror #28
 218:	5f494753 	svcpl	0x00494753
 21c:	646e6148 	strbtvs	r6, [lr], #-328	; 0xfffffeb8
 220:	0072656c 	rsbseq	r6, r2, ip, ror #10
 224:	62616e65 	rsbvs	r6, r1, #1616	; 0x650
 228:	4947656c 	stmdbmi	r7, {r2, r3, r5, r6, r8, sl, sp, lr}^
 22c:	6f6c0043 	svcvs	0x006c0043
 230:	6420676e 	strtvs	r6, [r0], #-1902	; 0xfffff892
 234:	6c62756f 	cfstr64vs	mvdx7, [r2], #-444	; 0xfffffe44
 238:	73650065 	cmnvc	r5, #101	; 0x65
 23c:	495f6772 	ldmdbmi	pc, {r1, r4, r5, r6, r8, r9, sl, sp, lr}^	; <UNPREDICTABLE>
 240:	485f5152 	ldmdami	pc, {r1, r4, r6, r8, ip, lr}^	; <UNPREDICTABLE>
 244:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
 248:	505f7265 	subspl	r7, pc, r5, ror #4
 24c:	67007274 	smlsdxvs	r0, r4, r2, r7
 250:	6365765f 	cmnvs	r5, #99614720	; 0x5f00000
 254:	6d754e74 	ldclvs	14, cr4, [r5, #-464]!	; 0xfffffe30
 258:	74656700 	strbtvc	r6, [r5], #-1792	; 0xfffff900
 25c:	436d754e 	cmnmi	sp, #327155712	; 0x13800000
 260:	00735550 	rsbseq	r5, r3, r0, asr r5
 264:	67727365 	ldrbvs	r7, [r2, -r5, ror #6]!
 268:	7261555f 	rsbvc	r5, r1, #398458880	; 0x17c00000
 26c:	69725074 	ldmdbvs	r2!, {r2, r4, r5, r6, ip, lr}^
 270:	7300746e 	movwvc	r7, #1134	; 0x46e
 274:	6e697274 	mcrvs	2, 3, r7, cr9, cr4, {3}
 278:	61750067 	cmnvs	r5, r7, rrx
 27c:	675f7472 			; <UNDEFINED> instruction: 0x675f7472
 280:	68637465 	stmdavs	r3!, {r0, r2, r5, r6, sl, ip, sp, lr}^
 284:	705f7261 	subsvc	r7, pc, r1, ror #4
 288:	656c6c6f 	strbvs	r6, [ip, #-3183]!	; 0xfffff391
 28c:	73650064 	cmnvc	r5, #100	; 0x64
 290:	555f6772 	ldrbpl	r6, [pc, #-1906]	; fffffb26 <__framebuffer_start+0x7f9ffb26>
 294:	50747261 	rsbspl	r7, r4, r1, ror #4
 298:	746e6972 	strbtvc	r6, [lr], #-2418	; 0xfffff68e
 29c:	75006e6c 	strvc	r6, [r0, #-3692]	; 0xfffff194
 2a0:	2e747261 	cdpcs	2, 7, cr7, cr4, cr1, {3}
 2a4:	65730063 	ldrbvs	r0, [r3, #-99]!	; 0xffffff9d
 2a8:	6e695f6c 	cdpvs	15, 6, cr5, cr9, cr12, {3}
 2ac:	00747570 	rsbseq	r7, r4, r0, ror r5
 2b0:	5f6c6573 	svcpl	0x006c6573
 2b4:	75706e69 	ldrbvc	r6, [r0, #-3689]!	; 0xfffff197
 2b8:	666f5f74 	uqsub16vs	r5, pc, r4	; <UNPREDICTABLE>
 2bc:	786d0073 	stmdavc	sp!, {r0, r1, r4, r5, r6}^
 2c0:	65735f63 	ldrbvs	r5, [r3, #-3939]!	; 0xfffff09d
 2c4:	6c616972 			; <UNDEFINED> instruction: 0x6c616972
 2c8:	7475705f 	ldrbtvc	r7, [r5], #-95	; 0xffffffa1
 2cc:	756d0063 	strbvc	r0, [sp, #-99]!	; 0xffffff9d
 2d0:	74635f78 	strbtvc	r5, [r3], #-3960	; 0xfffff088
 2d4:	6f5f6c72 	svcvs	0x005f6c72
 2d8:	62007366 	andvs	r7, r0, #-1744830463	; 0x98000001
 2dc:	00657361 	rsbeq	r7, r5, r1, ror #6
 2e0:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
 2e4:	746e6974 	strbtvc	r6, [lr], #-2420	; 0xfffff68c
 2e8:	72706300 	rsbsvc	r6, r0, #0, 6
 2ec:	66746e69 	ldrbtvs	r6, [r4], -r9, ror #28
 2f0:	63786d00 	cmnvs	r8, #0, 26
 2f4:	7265735f 	rsbvc	r7, r5, #2080374785	; 0x7c000001
 2f8:	2e6c6169 	powcsez	f6, f4, #1.0
 2fc:	756d0063 	strbvc	r0, [sp, #-99]!	; 0xffffff9d
 300:	6f6d5f78 	svcvs	0x006d5f78
 304:	69006564 	stmdbvs	r0, {r2, r5, r6, r8, sl, sp, lr}
 308:	695f786d 	ldmdbvs	pc, {r0, r2, r3, r5, r6, fp, ip, sp, lr}^	; <UNPREDICTABLE>
 30c:	78756d6f 	ldmdavc	r5!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp, lr}^
 310:	696e695f 	stmdbvs	lr!, {r0, r1, r2, r3, r4, r6, r8, fp, sp, lr}^
 314:	69730074 	ldmdbvs	r3!, {r2, r4, r5, r6}^
 318:	6d006e67 	stcvs	14, cr6, [r0, #-412]	; 0xfffffe64
 31c:	735f6378 	cmpvc	pc, #120, 6	; 0xe0000001
 320:	61697265 	cmnvs	r9, r5, ror #4
 324:	6e695f6c 	cdpvs	15, 6, cr5, cr9, cr12, {3}
 328:	69007469 	stmdbvs	r0, {r0, r3, r5, r6, sl, ip, sp, lr}
 32c:	695f786d 	ldmdbvs	pc, {r0, r2, r3, r5, r6, fp, ip, sp, lr}^	; <UNPREDICTABLE>
 330:	78756d6f 	ldmdavc	r5!, {r0, r1, r2, r3, r5, r6, r8, sl, fp, sp, lr}^
 334:	5f33765f 	svcpl	0x0033765f
 338:	75746573 	ldrbvc	r6, [r4, #-1395]!	; 0xfffffa8d
 33c:	61705f70 	cmnvs	r0, r0, ror pc
 340:	61700064 	cmnvs	r0, r4, rrx
 344:	74635f64 	strbtvc	r5, [r3], #-3940	; 0xfffff09c
 348:	6f5f6c72 	svcvs	0x005f6c72
 34c:	64007366 	strvs	r7, [r0], #-870	; 0xfffffc9a
 350:	74696769 	strbtvc	r6, [r9], #-1897	; 0xfffff897
 354:	786d0073 	stmdavc	sp!, {r0, r1, r4, r5, r6}^
 358:	65735f63 	ldrbvs	r5, [r3, #-3939]!	; 0xfffff09d
 35c:	6c616972 			; <UNDEFINED> instruction: 0x6c616972
 360:	7465735f 	strbtvc	r7, [r5], #-863	; 0xfffffca1
 364:	00677262 	rsbeq	r7, r7, r2, ror #4
 368:	70677261 	rsbvc	r7, r7, r1, ror #4
 36c:	64617000 	strbtvs	r7, [r1], #-0
 370:	7274635f 	rsbsvc	r6, r4, #2080374785	; 0x7c000001
 374:	7365006c 	cmnvc	r5, #108	; 0x6c
 378:	455f6772 	ldrbmi	r6, [pc, #-1906]	; fffffc0e <__framebuffer_start+0x7f9ffc0e>
 37c:	6c62616e 	stfvse	f6, [r2], #-440	; 0xfffffe48
 380:	6e495f65 	cdpvs	15, 4, cr5, cr9, cr5, {3}
 384:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
 388:	00747075 	rsbseq	r7, r4, r5, ror r0
 38c:	5f717269 	svcpl	0x00717269
 390:	77004449 	strvc	r4, [r0, -r9, asr #8]
 394:	65746972 	ldrbvs	r6, [r4, #-2418]!	; 0xfffff68e
 398:	00494f45 	subeq	r4, r9, r5, asr #30
 39c:	61736964 	cmnvs	r3, r4, ror #18
 3a0:	49656c62 	stmdbmi	r5!, {r1, r5, r6, sl, fp, sp, lr}^
 3a4:	4449746e 	strbmi	r7, [r9], #-1134	; 0xfffffb92
 3a8:	6d655400 	cfstrdvs	mvd5, [r5, #-0]
 3ac:	73695f70 	cmnvc	r9, #112, 30	; 0x1c0
 3b0:	70630072 	rsbvc	r0, r3, r2, ror r0
 3b4:	44495f75 	strbmi	r5, [r9], #-3957	; 0xfffff08b
 3b8:	6d655400 	cfstrdvs	mvd5, [r5, #-0]
 3bc:	73650070 	cmnvc	r5, #112	; 0x70
 3c0:	495f6772 	ldmdbmi	pc, {r1, r4, r5, r6, r8, r9, sl, sp, lr}^	; <UNPREDICTABLE>
 3c4:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 3c8:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
 3cc:	6d00632e 	stcvs	3, cr6, [r0, #-184]	; 0xffffff48
 3d0:	49656b61 	stmdbmi	r5!, {r0, r5, r6, r8, r9, fp, sp, lr}^
 3d4:	6f4e746e 	svcvs	0x004e746e
 3d8:	6365536e 	cmnvs	r5, #-1207959551	; 0xb8000001
 3dc:	00657275 	rsbeq	r7, r5, r5, ror r2
 3e0:	5f555043 	svcpl	0x00555043
 3e4:	72004449 	andvc	r4, r0, #1224736768	; 0x49000000
 3e8:	49646165 	stmdbmi	r4!, {r0, r2, r5, r6, r8, sp, lr}^
 3ec:	6341746e 	movtvs	r7, #5230	; 0x146e
 3f0:	7365006b 	cmnvc	r5, #107	; 0x6b
 3f4:	495f6772 	ldmdbmi	pc, {r1, r4, r5, r6, r8, r9, sl, sp, lr}^	; <UNPREDICTABLE>
 3f8:	7265746e 	rsbvc	r7, r5, #1845493760	; 0x6e000000
 3fc:	74707572 	ldrbtvc	r7, [r0], #-1394	; 0xfffffa8e
 400:	6e61485f 	mcrvs	8, 3, r4, cr1, cr15, {2}
 404:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
 408:	72736500 	rsbsvc	r6, r3, #0, 10
 40c:	69445f67 	stmdbvs	r4, {r0, r1, r2, r5, r6, r8, r9, sl, fp, ip, lr}^
 410:	6c626173 	stfvse	f6, [r2], #-460	; 0xfffffe34
 414:	6e495f65 	cdpvs	15, 4, cr5, cr9, cr5, {3}
 418:	72726574 	rsbsvc	r6, r2, #116, 10	; 0x1d000000
 41c:	00747075 	rsbseq	r7, r4, r5, ror r0
 420:	67727365 	ldrbvs	r7, [r2, -r5, ror #6]!
 424:	6665445f 			; <UNDEFINED> instruction: 0x6665445f
 428:	746c7561 	strbtvc	r7, [ip], #-1377	; 0xfffffa9f
 42c:	5253495f 	subspl	r4, r3, #1556480	; 0x17c000
 430:	74657300 	strbtvc	r7, [r5], #-768	; 0xfffffd00
 434:	54746e49 	ldrbtpl	r6, [r4], #-3657	; 0xfffff1b7
 438:	65677261 	strbvs	r7, [r7, #-609]!	; 0xfffffd9f
 43c:	Address 0x000000000000043c is out of bounds.


Disassembly of section .debug_loc:

00000000 <.debug_loc>:
   0:	00000022 	andeq	r0, r0, r2, lsr #32
   4:	00000025 	andeq	r0, r0, r5, lsr #32
   8:	25500001 	ldrbcs	r0, [r0, #-1]
   c:	38000000 	stmdacc	r0, {}	; <UNPREDICTABLE>
  10:	01000000 	mrseq	r0, (UNDEF: 0)
  14:	00005400 	andeq	r5, r0, r0, lsl #8
  18:	00000000 	andeq	r0, r0, r0
  1c:	00440000 	subeq	r0, r4, r0
  20:	004a0000 	subeq	r0, sl, r0
  24:	00010000 	andeq	r0, r1, r0
  28:	00004a50 	andeq	r4, r0, r0, asr sl
  2c:	00005a00 	andeq	r5, r0, r0, lsl #20
  30:	54000100 	strpl	r0, [r0], #-256	; 0xffffff00
	...
  3c:	0000005c 	andeq	r0, r0, ip, asr r0
  40:	00000062 	andeq	r0, r0, r2, rrx
  44:	62500001 	subsvs	r0, r0, #1
  48:	6e000000 	cdpvs	0, 0, cr0, cr0, cr0, {0}
  4c:	01000000 	mrseq	r0, (UNDEF: 0)
  50:	006e5400 	rsbeq	r5, lr, r0, lsl #8
  54:	00720000 	rsbseq	r0, r2, r0
  58:	00030000 	andeq	r0, r3, r0
  5c:	009f7f74 	addseq	r7, pc, r4, ror pc	; <UNPREDICTABLE>
	...
  68:	14000000 	strne	r0, [r0], #-0
  6c:	06000000 	streq	r0, [r0], -r0
  70:	04935000 	ldreq	r5, [r3], #0
  74:	14049351 	strne	r9, [r4], #-849	; 0xfffffcaf
  78:	58000000 	stmdapl	r0, {}	; <UNPREDICTABLE>
  7c:	06000000 	streq	r0, [r0], -r0
  80:	f503f300 			; <UNDEFINED> instruction: 0xf503f300
  84:	009f2500 	addseq	r2, pc, r0, lsl #10
  88:	00000000 	andeq	r0, r0, r0
  8c:	06000000 	streq	r0, [r0], -r0
  90:	1c000000 	stcne	0, cr0, [r0], {-0}
  94:	01000000 	mrseq	r0, (UNDEF: 0)
  98:	001c5200 	andseq	r5, ip, r0, lsl #4
  9c:	00200000 	eoreq	r0, r0, r0
  a0:	00060000 	andeq	r0, r6, r0
  a4:	d0808072 	addle	r8, r0, r2, ror r0
  a8:	00209f6f 	eoreq	r9, r0, pc, ror #30
  ac:	00260000 	eoreq	r0, r6, r0
  b0:	00060000 	andeq	r0, r6, r0
  b4:	c8808072 	stmgt	r0, {r1, r4, r5, r6, pc}
  b8:	00009f6f 	andeq	r9, r0, pc, ror #30
  bc:	00000000 	andeq	r0, r0, r0
  c0:	00100000 	andseq	r0, r0, r0
  c4:	002c0000 	eoreq	r0, ip, r0
  c8:	00010000 	andeq	r0, r1, r0
  cc:	00002c53 	andeq	r2, r0, r3, asr ip
  d0:	00003000 	andeq	r3, r0, r0
  d4:	73000600 	movwvc	r0, #1536	; 0x600
  d8:	6fd08080 	svcvs	0x00d08080
  dc:	0000309f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
  e0:	00003600 	andeq	r3, r0, r0, lsl #12
  e4:	73000600 	movwvc	r0, #1536	; 0x600
  e8:	6fc88080 	svcvs	0x00c88080
  ec:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
  f0:	00000000 	andeq	r0, r0, r0
  f4:	00001400 	andeq	r1, r0, r0, lsl #8
  f8:	00004a00 	andeq	r4, r0, r0, lsl #20
  fc:	50000100 	andpl	r0, r0, r0, lsl #2
	...
 108:	00000016 	andeq	r0, r0, r6, lsl r0
 10c:	00000052 	andeq	r0, r0, r2, asr r0
 110:	00740009 	rsbseq	r0, r4, r9
 114:	03ffff0c 	mvnseq	pc, #12, 30	; 0x30
 118:	009f1a00 	addseq	r1, pc, r0, lsl #20
 11c:	00000000 	andeq	r0, r0, r0
 120:	58000000 	stmdapl	r0, {}	; <UNPREDICTABLE>
 124:	76000000 	strvc	r0, [r0], -r0
 128:	0a000000 	beq	130 <UNLOCKED+0x31>
 12c:	80089e00 	andhi	r9, r8, r0, lsl #28
 130:	30006502 	andcc	r6, r0, r2, lsl #10
 134:	00036162 	andeq	r6, r3, r2, ror #2
 138:	00000000 	andeq	r0, r0, r0
 13c:	58000000 	stmdapl	r0, {}	; <UNPREDICTABLE>
 140:	76000000 	strvc	r0, [r0], -r0
 144:	04000000 	streq	r0, [r0], #-0
 148:	02800a00 	addeq	r0, r0, #0, 20
 14c:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
 150:	00000000 	andeq	r0, r0, r0
 154:	00005800 	andeq	r5, r0, r0, lsl #16
 158:	00007600 	andeq	r7, r0, r0, lsl #12
 15c:	33000200 	movwcc	r0, #512	; 0x200
 160:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
 164:	00000000 	andeq	r0, r0, r0
 168:	00005800 	andeq	r5, r0, r0, lsl #16
 16c:	00007600 	andeq	r7, r0, r0, lsl #12
 170:	30000200 	andcc	r0, r0, r0, lsl #4
 174:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
 178:	00000000 	andeq	r0, r0, r0
 17c:	00005800 	andeq	r5, r0, r0, lsl #16
 180:	00007600 	andeq	r7, r0, r0, lsl #12
 184:	0a000400 	beq	118c <L1_NONCOHERENT+0x56e>
 188:	009f0650 	addseq	r0, pc, r0, asr r6	; <UNPREDICTABLE>
 18c:	00000000 	andeq	r0, r0, r0
 190:	58000000 	stmdapl	r0, {}	; <UNPREDICTABLE>
 194:	76000000 	strvc	r0, [r0], -r0
 198:	06000000 	streq	r0, [r0], -r0
 19c:	b0b10c00 	adcslt	r0, r1, r0, lsl #24
 1a0:	009f0001 	addseq	r0, pc, r1
 1a4:	00000000 	andeq	r0, r0, r0
 1a8:	76000000 	strvc	r0, [r0], -r0
 1ac:	9e000000 	cdpls	0, 0, cr0, cr0, cr0, {0}
 1b0:	0a000000 	beq	1b8 <UNLOCKED+0xb9>
 1b4:	84089e00 	strhi	r9, [r8], #-3584	; 0xfffff200
 1b8:	39206542 	stmdbcc	r0!, {r1, r6, r8, sl, sp, lr}
 1bc:	000b6162 	andeq	r6, fp, r2, ror #2
 1c0:	00000000 	andeq	r0, r0, r0
 1c4:	76000000 	strvc	r0, [r0], -r0
 1c8:	9e000000 	cdpls	0, 0, cr0, cr0, cr0, {0}
 1cc:	04000000 	streq	r0, [r0], #-0
 1d0:	02840a00 	addeq	r0, r4, #0, 20
 1d4:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
 1d8:	00000000 	andeq	r0, r0, r0
 1dc:	00007600 	andeq	r7, r0, r0, lsl #12
 1e0:	00009e00 	andeq	r9, r0, r0, lsl #28
 1e4:	33000200 	movwcc	r0, #512	; 0x200
 1e8:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
 1ec:	00000000 	andeq	r0, r0, r0
 1f0:	00007600 	andeq	r7, r0, r0, lsl #12
 1f4:	00009e00 	andeq	r9, r0, r0, lsl #28
 1f8:	0a000400 	beq	1200 <L1_NONCOHERENT+0x5e2>
 1fc:	009f0920 	addseq	r0, pc, r0, lsr #18
 200:	00000000 	andeq	r0, r0, r0
 204:	76000000 	strvc	r0, [r0], -r0
 208:	9e000000 	cdpls	0, 0, cr0, cr0, cr0, {0}
 20c:	02000000 	andeq	r0, r0, #0
 210:	009f3100 	addseq	r3, pc, r0, lsl #2
 214:	00000000 	andeq	r0, r0, r0
 218:	76000000 	strvc	r0, [r0], -r0
 21c:	9e000000 	cdpls	0, 0, cr0, cr0, cr0, {0}
 220:	04000000 	streq	r0, [r0], #-0
 224:	06540a00 	ldrbeq	r0, [r4], -r0, lsl #20
 228:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
 22c:	00000000 	andeq	r0, r0, r0
 230:	00007600 	andeq	r7, r0, r0, lsl #12
 234:	00009e00 	andeq	r9, r0, r0, lsl #28
 238:	0c000600 	stceq	6, cr0, [r0], {-0}
 23c:	0001b0b1 	strheq	fp, [r1], -r1
 240:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
 244:	00000000 	andeq	r0, r0, r0
 248:	0000c400 	andeq	ip, r0, r0, lsl #8
 24c:	0000e200 	andeq	lr, r0, r0, lsl #4
 250:	50000100 	andpl	r0, r0, r0, lsl #2
 254:	000000e2 	andeq	r0, r0, r2, ror #1
 258:	000000e8 	andeq	r0, r0, r8, ror #1
 25c:	01f30004 	mvnseq	r0, r4
 260:	00009f50 	andeq	r9, r0, r0, asr pc
 264:	00000000 	andeq	r0, r0, r0
 268:	015c0000 	cmpeq	ip, r0
 26c:	01880000 	orreq	r0, r8, r0
 270:	00010000 	andeq	r0, r1, r0
 274:	00018850 	andeq	r8, r1, r0, asr r8
 278:	0001da00 	andeq	sp, r1, r0, lsl #20
 27c:	f3000400 	vshl.u8	d0, d0, d0
 280:	009f5001 	addseq	r5, pc, r1
 284:	00000000 	andeq	r0, r0, r0
 288:	5c000000 	stcpl	0, cr0, [r0], {-0}
 28c:	88000001 	stmdahi	r0, {r0}
 290:	01000001 	tsteq	r0, r1
 294:	01885100 	orreq	r5, r8, r0, lsl #2
 298:	01da0000 	bicseq	r0, sl, r0
 29c:	00010000 	andeq	r0, r1, r0
 2a0:	00000057 	andeq	r0, r0, r7, asr r0
 2a4:	00000000 	andeq	r0, r0, r0
 2a8:	00015c00 	andeq	r5, r1, r0, lsl #24
 2ac:	00016c00 	andeq	r6, r1, r0, lsl #24
 2b0:	52000100 	andpl	r0, r0, #0, 2
 2b4:	0000016c 	andeq	r0, r0, ip, ror #2
 2b8:	000001da 	ldrdeq	r0, [r0], -sl
 2bc:	00590001 	subseq	r0, r9, r1
 2c0:	00000000 	andeq	r0, r0, r0
 2c4:	76000000 	strvc	r0, [r0], -r0
 2c8:	88000001 	stmdahi	r0, {r0}
 2cc:	02000001 	andeq	r0, r0, #1
 2d0:	889f3000 	ldmhi	pc, {ip, sp}	; <UNPREDICTABLE>
 2d4:	8a000001 	bhi	2e0 <UNLOCKED+0x1e1>
 2d8:	01000001 	tsteq	r0, r1
 2dc:	018a5400 	orreq	r5, sl, r0, lsl #8
 2e0:	018e0000 	orreq	r0, lr, r0
 2e4:	00010000 	andeq	r0, r1, r0
 2e8:	00018e58 	andeq	r8, r1, r8, asr lr
 2ec:	0001b200 	andeq	fp, r1, r0, lsl #4
 2f0:	54000100 	strpl	r0, [r0], #-256	; 0xffffff00
 2f4:	000001b2 			; <UNDEFINED> instruction: 0x000001b2
 2f8:	000001c0 	andeq	r0, r0, r0, asr #3
 2fc:	02780003 	rsbseq	r0, r8, #3
 300:	0001c09f 	muleq	r1, pc, r0	; <UNPREDICTABLE>
 304:	0001c800 	andeq	ip, r1, r0, lsl #16
 308:	74000300 	strvc	r0, [r0], #-768	; 0xfffffd00
 30c:	01c89f7f 	biceq	r9, r8, pc, ror pc
 310:	01cc0000 	biceq	r0, ip, r0
 314:	00080000 	andeq	r0, r8, r0
 318:	00910074 	addseq	r0, r1, r4, ror r0
 31c:	9f2f231c 	svcls	0x002f231c
 320:	000001cc 	andeq	r0, r0, ip, asr #3
 324:	000001d0 	ldrdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 328:	00740008 	rsbseq	r0, r4, r8
 32c:	231c0091 	tstcs	ip, #145	; 0x91
 330:	01d09f30 	bicseq	r9, r0, r0, lsr pc
 334:	01d40000 	bicseq	r0, r4, r0
 338:	00080000 	andeq	r0, r8, r0
 33c:	00910074 	addseq	r0, r1, r4, ror r0
 340:	9f2f231c 	svcls	0x002f231c
	...
 34c:	00000176 	andeq	r0, r0, r6, ror r1
 350:	00000188 	andeq	r0, r0, r8, lsl #3
 354:	88550001 	ldmdahi	r5, {r0}^
 358:	8a000001 	bhi	364 <UNLOCKED+0x265>
 35c:	01000001 	tsteq	r0, r1
 360:	018a5000 	orreq	r5, sl, r0
 364:	01a60000 			; <UNDEFINED> instruction: 0x01a60000
 368:	00010000 	andeq	r0, r1, r0
 36c:	0001a655 	andeq	sl, r1, r5, asr r6
 370:	0001c800 	andeq	ip, r1, r0, lsl #16
 374:	50000100 	andpl	r0, r0, r0, lsl #2
	...
 380:	000001e2 	andeq	r0, r0, r2, ror #3
 384:	00000200 	andeq	r0, r0, r0, lsl #4
 388:	9f300002 	svcls	0x00300002
 38c:	00000200 	andeq	r0, r0, r0, lsl #4
 390:	0000029c 	muleq	r0, ip, r2
 394:	00540001 	subseq	r0, r4, r1
 398:	00000000 	andeq	r0, r0, r0
 39c:	e6000000 	str	r0, [r0], -r0
 3a0:	07000001 	streq	r0, [r0, -r1]
 3a4:	01000002 	tsteq	r0, r2
 3a8:	020a5000 	andeq	r5, sl, #0
 3ac:	020e0000 	andeq	r0, lr, #0
 3b0:	00010000 	andeq	r0, r1, r0
 3b4:	00020e50 	andeq	r0, r2, r0, asr lr
 3b8:	00023000 	andeq	r3, r2, r0
 3bc:	75000600 	strvc	r0, [r0, #-1536]	; 0xfffffa00
 3c0:	1aff0800 	bne	fffc23c8 <__framebuffer_start+0x7f9c23c8>
 3c4:	0002309f 	muleq	r2, pc, r0	; <UNPREDICTABLE>
 3c8:	00023b00 	andeq	r3, r2, r0, lsl #22
 3cc:	76000b00 	strvc	r0, [r0], -r0, lsl #22
 3d0:	22007400 	andcs	r7, r0, #0, 8
 3d4:	ff080194 			; <UNDEFINED> instruction: 0xff080194
 3d8:	02409f1a 	subeq	r9, r0, #26, 30	; 0x68
 3dc:	02440000 	subeq	r0, r4, #0
 3e0:	00060000 	andeq	r0, r6, r0
 3e4:	ff080075 			; <UNDEFINED> instruction: 0xff080075
 3e8:	02449f1a 	subeq	r9, r4, #26, 30	; 0x68
 3ec:	024f0000 	subeq	r0, pc, #0
 3f0:	000b0000 	andeq	r0, fp, r0
 3f4:	00740076 	rsbseq	r0, r4, r6, ror r0
 3f8:	08019422 	stmdaeq	r1, {r1, r5, sl, ip, pc}
 3fc:	549f1aff 	ldrpl	r1, [pc], #2815	; 404 <UNLOCKED+0x305>
 400:	58000002 	stmdapl	r0, {r1}
 404:	06000002 	streq	r0, [r0], -r2
 408:	08007500 	stmdaeq	r0, {r8, sl, ip, sp, lr}
 40c:	589f1aff 	ldmpl	pc, {r0, r1, r2, r3, r4, r5, r6, r7, r9, fp, ip}	; <UNPREDICTABLE>
 410:	6a000002 	bvs	420 <UNLOCKED+0x321>
 414:	0b000002 	bleq	424 <UNLOCKED+0x325>
 418:	74007600 	strvc	r7, [r0], #-1536	; 0xfffffa00
 41c:	01942200 	orrseq	r2, r4, r0, lsl #4
 420:	9f1aff08 	svcls	0x001aff08
 424:	0000027a 	andeq	r0, r0, sl, ror r2
 428:	00000290 	muleq	r0, r0, r2
 42c:	00750006 	rsbseq	r0, r5, r6
 430:	9f1aff08 	svcls	0x001aff08
 434:	00000290 	muleq	r0, r0, r2
 438:	00000292 	muleq	r0, r2, r2
 43c:	0076000b 	rsbseq	r0, r6, fp
 440:	94220074 	strtls	r0, [r2], #-116	; 0xffffff8c
 444:	1aff0801 	bne	fffc2450 <__framebuffer_start+0x7f9c2450>
 448:	0002989f 	muleq	r2, pc, r8	; <UNPREDICTABLE>
 44c:	00029c00 	andeq	r9, r2, r0, lsl #24
 450:	50000100 	andpl	r0, r0, r0, lsl #2
	...
 45c:	000001e2 	andeq	r0, r0, r2, ror #3
 460:	000001f0 	strdeq	r0, [r0], -r0	; <UNPREDICTABLE>
 464:	54910003 	ldrpl	r0, [r1], #3
 468:	0001f09f 	muleq	r1, pc, r0	; <UNPREDICTABLE>
 46c:	00023000 	andeq	r3, r2, r0
 470:	5a000100 	bpl	878 <UNLOCKED+0x779>
 474:	00000230 	andeq	r0, r0, r0, lsr r2
 478:	00000240 	andeq	r0, r0, r0, asr #4
 47c:	40550001 	subsmi	r0, r5, r1
 480:	44000002 	strmi	r0, [r0], #-2
 484:	01000002 	tsteq	r0, r2
 488:	02445a00 	subeq	r5, r4, #0, 20
 48c:	02540000 	subseq	r0, r4, #0
 490:	00010000 	andeq	r0, r1, r0
 494:	00025455 	andeq	r5, r2, r5, asr r4
 498:	00025800 	andeq	r5, r2, r0, lsl #16
 49c:	5a000100 	bpl	8a4 <UNLOCKED+0x7a5>
 4a0:	00000258 	andeq	r0, r0, r8, asr r2
 4a4:	0000027a 	andeq	r0, r0, sl, ror r2
 4a8:	7a550001 	bvc	15404b4 <L1_COHERENT+0x152b8ae>
 4ac:	90000002 	andls	r0, r0, r2
 4b0:	01000002 	tsteq	r0, r2
 4b4:	02905a00 	addseq	r5, r0, #0, 20
 4b8:	02920000 	addseq	r0, r2, #0
 4bc:	00010000 	andeq	r0, r1, r0
 4c0:	00029255 	andeq	r9, r2, r5, asr r2
 4c4:	00029c00 	andeq	r9, r2, r0, lsl #24
 4c8:	5a000100 	bpl	8d0 <UNLOCKED+0x7d1>
	...
 4d4:	0000025c 	andeq	r0, r0, ip, asr r2
 4d8:	00000272 	andeq	r0, r0, r2, ror r2
 4dc:	725a0001 	subsvc	r0, sl, #1
 4e0:	78000002 	stmdavc	r0, {r1}
 4e4:	03000002 	movweq	r0, #2
 4e8:	9f7f7a00 	svcls	0x007f7a00
 4ec:	00000290 	muleq	r0, r0, r2
 4f0:	00000292 	muleq	r0, r2, r2
 4f4:	005a0001 	subseq	r0, sl, r1
 4f8:	00000000 	andeq	r0, r0, r0
 4fc:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
 500:	11000000 	mrsne	r0, (UNDEF: 0)
 504:	01000000 	mrseq	r0, (UNDEF: 0)
 508:	00115000 	andseq	r5, r1, r0
 50c:	00140000 	andseq	r0, r4, r0
 510:	00010000 	andeq	r0, r1, r0
 514:	00001454 	andeq	r1, r0, r4, asr r4
 518:	00003700 	andeq	r3, r0, r0, lsl #14
 51c:	50000100 	andpl	r0, r0, r0, lsl #2
 520:	00000037 	andeq	r0, r0, r7, lsr r0
 524:	0000004e 	andeq	r0, r0, lr, asr #32
 528:	00540001 	subseq	r0, r4, r1
 52c:	00000000 	andeq	r0, r0, r0
 530:	34000000 	strcc	r0, [r0], #-0
 534:	37000000 	strcc	r0, [r0, -r0]
 538:	01000000 	mrseq	r0, (UNDEF: 0)
 53c:	00005300 	andeq	r5, r0, r0, lsl #6
 540:	00000000 	andeq	r0, r0, r0
 544:	00500000 	subseq	r0, r0, r0
 548:	00550000 	subseq	r0, r5, r0
 54c:	00010000 	andeq	r0, r1, r0
 550:	00005550 	andeq	r5, r0, r0, asr r5
 554:	00005800 	andeq	r5, r0, r0, lsl #16
 558:	f3000400 	vshl.u8	d0, d0, d0
 55c:	009f5001 	addseq	r5, pc, r1
 560:	00000000 	andeq	r0, r0, r0
 564:	50000000 	andpl	r0, r0, r0
 568:	55000000 	strpl	r0, [r0, #-0]
 56c:	01000000 	mrseq	r0, (UNDEF: 0)
 570:	00555100 	subseq	r5, r5, r0, lsl #2
 574:	00580000 	subseq	r0, r8, r0
 578:	00040000 	andeq	r0, r4, r0
 57c:	9f5101f3 	svcls	0x005101f3
	...
 588:	00000058 	andeq	r0, r0, r8, asr r0
 58c:	00000063 	andeq	r0, r0, r3, rrx
 590:	63500001 	cmpvs	r0, #1
 594:	7a000000 	bvc	59c <UNLOCKED+0x49d>
 598:	01000000 	mrseq	r0, (UNDEF: 0)
 59c:	00005400 	andeq	r5, r0, r0, lsl #8
 5a0:	00000000 	andeq	r0, r0, r0
 5a4:	00580000 	subseq	r0, r8, r0
 5a8:	00600000 	rsbeq	r0, r0, r0
 5ac:	00010000 	andeq	r0, r1, r0
 5b0:	00006051 	andeq	r6, r0, r1, asr r0
 5b4:	00007a00 	andeq	r7, r0, r0, lsl #20
 5b8:	55000100 	strpl	r0, [r0, #-256]	; 0xffffff00
	...
 5c4:	00000058 	andeq	r0, r0, r8, asr r0
 5c8:	00000063 	andeq	r0, r0, r3, rrx
 5cc:	63520001 	cmpvs	r2, #1
 5d0:	7a000000 	bvc	5d8 <UNLOCKED+0x4d9>
 5d4:	04000000 	streq	r0, [r0], #-0
 5d8:	5201f300 	andpl	pc, r1, #0, 6
 5dc:	0000009f 	muleq	r0, pc, r0	; <UNPREDICTABLE>
 5e0:	00000000 	andeq	r0, r0, r0
	...
