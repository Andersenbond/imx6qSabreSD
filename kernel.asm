
kernel.elf:     file format elf32-littlearm


Disassembly of section .text:

00920000 <ivt_header-0x400>:
  920000:	ea000109 	b	92042c <Reset_Handler>
	...

00920400 <ivt_header>:
  920400:	402000d1 	ldrdmi	r0, [r0], -r1	; <UNPREDICTABLE>

00920404 <app_code_jump_vector>:
  920404:	0092042c 	addseq	r0, r2, ip, lsr #8
  920408:	00000000 	andeq	r0, r0, r0

0092040c <dcd_ptr>:
  92040c:	00000000 	andeq	r0, r0, r0

00920410 <boot_data_ptr>:
  920410:	00920420 	addseq	r0, r2, r0, lsr #8

00920414 <self_ptr>:
  920414:	00920400 	addseq	r0, r2, r0, lsl #8
	...

00920420 <boot_data>:
  920420:	00920000 	addseq	r0, r2, r0

00920424 <image_len>:
  920424:	00018000 	andeq	r8, r1, r0

00920428 <plugin>:
  920428:	00000000 	andeq	r0, r0, r0

0092042c <Reset_Handler>:
  92042c:	e1a04000 	mov	r4, r0
  920430:	e3a0b000 	mov	fp, #0
  920434:	e3a0c000 	mov	ip, #0
  920438:	e3a0e000 	mov	lr, #0
  92043c:	e59f03dc 	ldr	r0, [pc, #988]	; 920820 <finished+0x74>
  920440:	e3a01b01 	mov	r1, #1024	; 0x400
  920444:	ee102fb0 	mrc	15, 0, r2, cr0, cr0, {5}
  920448:	e2022003 	and	r2, r2, #3
  92044c:	e1a05002 	mov	r5, r2
  920450:	e0030192 	mul	r3, r2, r1
  920454:	e0400003 	sub	r0, r0, r3
  920458:	e1a01101 	lsl	r1, r1, #2
  92045c:	e321f0d1 	msr	CPSR_c, #209	; 0xd1
  920460:	e1a0d000 	mov	sp, r0
  920464:	e0400001 	sub	r0, r0, r1
  920468:	e321f0d2 	msr	CPSR_c, #210	; 0xd2
  92046c:	e1a0d000 	mov	sp, r0
  920470:	e0400001 	sub	r0, r0, r1
  920474:	e321f0d7 	msr	CPSR_c, #215	; 0xd7
  920478:	e1a0d000 	mov	sp, r0
  92047c:	e0400001 	sub	r0, r0, r1
  920480:	e321f0db 	msr	CPSR_c, #219	; 0xdb
  920484:	e1a0d000 	mov	sp, r0
  920488:	e0400001 	sub	r0, r0, r1
  92048c:	e321f0df 	msr	CPSR_c, #223	; 0xdf
  920490:	e1a0d000 	mov	sp, r0
  920494:	e0400001 	sub	r0, r0, r1
  920498:	e321f0d3 	msr	CPSR_c, #211	; 0xd3
  92049c:	e1a0d000 	mov	sp, r0
  9204a0:	e0400001 	sub	r0, r0, r1
  9204a4:	e59f1378 	ldr	r1, [pc, #888]	; 920824 <finished+0x78>
  9204a8:	e59f2378 	ldr	r2, [pc, #888]	; 920828 <finished+0x7c>
  9204ac:	e3a03000 	mov	r3, #0
  9204b0:	e1510002 	cmp	r1, r2
  9204b4:	b8a10008 	stmialt	r1!, {r3}
  9204b8:	bafffffc 	blt	9204b0 <Reset_Handler+0x84>
  9204bc:	e3550000 	cmp	r5, #0
  9204c0:	0a000002 	beq	9204d0 <primary_cpu_init>
  9204c4:	e12fff14 	bx	r4
  9204c8:	eaffffff 	b	9204cc <startup_exit>

009204cc <startup_exit>:
  9204cc:	eafffffe 	b	9204cc <startup_exit>

009204d0 <primary_cpu_init>:
  9204d0:	eb000068 	bl	920678 <Disable_MMU_L1cache>
  9204d4:	eb000091 	bl	920720 <Flush_cache>
  9204d8:	eb00002f 	bl	92059c <Page_Table_setup>
  9204dc:	eb00005e 	bl	92065c <Enable_MMU_L1cache>
  9204e0:	eb000071 	bl	9206ac <Enable_L2_cache>
  9204e4:	e3a0060f 	mov	r0, #15728640	; 0xf00000
  9204e8:	ee010f50 	mcr	15, 0, r0, cr1, cr0, {2}
  9204ec:	f57ff06f 	isb	sy
  9204f0:	eef80a10 	vmrs	r0, fpexc
  9204f4:	e3800101 	orr	r0, r0, #1073741824	; 0x40000000
  9204f8:	eee80a10 	vmsr	fpexc, r0
  9204fc:	eef10a10 	vmrs	r0, fpscr
  920500:	e3800403 	orr	r0, r0, #50331648	; 0x3000000
  920504:	eee10a10 	vmsr	fpscr, r0
  920508:	e59f031c 	ldr	r0, [pc, #796]	; 92082c <finished+0x80>
  92050c:	e59f131c 	ldr	r1, [pc, #796]	; 920830 <finished+0x84>
  920510:	e5801000 	str	r1, [r0]
  920514:	e5801004 	str	r1, [r0, #4]
  920518:	e3a01000 	mov	r1, #0
  92051c:	e5801040 	str	r1, [r0, #64]	; 0x40
  920520:	e5801044 	str	r1, [r0, #68]	; 0x44
  920524:	e5801048 	str	r1, [r0, #72]	; 0x48
  920528:	e580104c 	str	r1, [r0, #76]	; 0x4c
  92052c:	e5801050 	str	r1, [r0, #80]	; 0x50
  920530:	e59f02fc 	ldr	r0, [pc, #764]	; 920834 <finished+0x88>
  920534:	e59f12f4 	ldr	r1, [pc, #756]	; 920830 <finished+0x84>
  920538:	e5801000 	str	r1, [r0]
  92053c:	e5801004 	str	r1, [r0, #4]
  920540:	e3a01000 	mov	r1, #0
  920544:	e5801040 	str	r1, [r0, #64]	; 0x40
  920548:	e5801044 	str	r1, [r0, #68]	; 0x44
  92054c:	e5801048 	str	r1, [r0, #72]	; 0x48
  920550:	e580104c 	str	r1, [r0, #76]	; 0x4c
  920554:	e5801050 	str	r1, [r0, #80]	; 0x50
  920558:	e59f02d8 	ldr	r0, [pc, #728]	; 920838 <finished+0x8c>
  92055c:	e3e01000 	mvn	r1, #0
  920560:	e5801000 	str	r1, [r0]
  920564:	e59f02d0 	ldr	r0, [pc, #720]	; 92083c <finished+0x90>
  920568:	e5801000 	str	r1, [r0]
  92056c:	e59f02cc 	ldr	r0, [pc, #716]	; 920840 <finished+0x94>
  920570:	e5801000 	str	r1, [r0]
  920574:	e59f02c8 	ldr	r0, [pc, #712]	; 920844 <finished+0x98>
  920578:	e5801000 	str	r1, [r0]
  92057c:	e59f02c4 	ldr	r0, [pc, #708]	; 920848 <finished+0x9c>
  920580:	e5801000 	str	r1, [r0]
  920584:	e59f02c0 	ldr	r0, [pc, #704]	; 92084c <finished+0xa0>
  920588:	e5801000 	str	r1, [r0]
  92058c:	e59f02bc 	ldr	r0, [pc, #700]	; 920850 <finished+0xa4>
  920590:	e5801000 	str	r1, [r0]
  920594:	e59fc2b8 	ldr	ip, [pc, #696]	; 920854 <finished+0xa8>
  920598:	e12fff1c 	bx	ip

0092059c <Page_Table_setup>:
  92059c:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
  9205a0:	e3a01502 	mov	r1, #8388608	; 0x800000
  9205a4:	e1800001 	orr	r0, r0, r1
  9205a8:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
  9205ac:	e3a00000 	mov	r0, #0
  9205b0:	ee020f50 	mcr	15, 0, r0, cr2, cr0, {2}
  9205b4:	e3a00000 	mov	r0, #0
  9205b8:	ee080f17 	mcr	15, 0, r0, cr8, cr7, {0}
  9205bc:	e59f7294 	ldr	r7, [pc, #660]	; 920858 <finished+0xac>
  9205c0:	e3877008 	orr	r7, r7, #8
  9205c4:	e3877040 	orr	r7, r7, #64	; 0x40
  9205c8:	ee027f10 	mcr	15, 0, r7, cr2, cr0, {0}
  9205cc:	e59f0288 	ldr	r0, [pc, #648]	; 92085c <finished+0xb0>
  9205d0:	ee030f10 	mcr	15, 0, r0, cr3, cr0, {0}
  9205d4:	e59f727c 	ldr	r7, [pc, #636]	; 920858 <finished+0xac>
  9205d8:	e3a01000 	mov	r1, #0
  9205dc:	e3a03024 	mov	r3, #36	; 0x24
  9205e0:	e59f2278 	ldr	r2, [pc, #632]	; 920860 <finished+0xb4>

009205e4 <countloop1>:
  9205e4:	e0878001 	add	r8, r7, r1
  9205e8:	e5882000 	str	r2, [r8]
  9205ec:	e2811004 	add	r1, r1, #4
  9205f0:	e2822601 	add	r2, r2, #1048576	; 0x100000
  9205f4:	e1510003 	cmp	r1, r3
  9205f8:	1afffff9 	bne	9205e4 <countloop1>
  9205fc:	e3a01024 	mov	r1, #36	; 0x24
  920600:	e0878001 	add	r8, r7, r1
  920604:	e59f2258 	ldr	r2, [pc, #600]	; 920864 <finished+0xb8>
  920608:	e5882000 	str	r2, [r8]
  92060c:	e3a01028 	mov	r1, #40	; 0x28
  920610:	e3a03b01 	mov	r3, #1024	; 0x400
  920614:	e59f224c 	ldr	r2, [pc, #588]	; 920868 <finished+0xbc>

00920618 <countloop2>:
  920618:	e0878001 	add	r8, r7, r1
  92061c:	e5882000 	str	r2, [r8]
  920620:	e2811004 	add	r1, r1, #4
  920624:	e2822601 	add	r2, r2, #1048576	; 0x100000
  920628:	e1510003 	cmp	r1, r3
  92062c:	1afffff9 	bne	920618 <countloop2>
  920630:	e3a01b01 	mov	r1, #1024	; 0x400
  920634:	e3a03901 	mov	r3, #16384	; 0x4000
  920638:	e3a02000 	mov	r2, #0

0092063c <countloop3>:
  92063c:	e0878001 	add	r8, r7, r1
  920640:	e5882000 	str	r2, [r8]
  920644:	e2811004 	add	r1, r1, #4
  920648:	e1510003 	cmp	r1, r3
  92064c:	1afffffa 	bne	92063c <countloop3>
  920650:	e3a00000 	mov	r0, #0
  920654:	ee080f17 	mcr	15, 0, r0, cr8, cr7, {0}
  920658:	e12fff1e 	bx	lr

0092065c <Enable_MMU_L1cache>:
  92065c:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
  920660:	e3800a01 	orr	r0, r0, #4096	; 0x1000
  920664:	e3800b02 	orr	r0, r0, #2048	; 0x800
  920668:	e3800004 	orr	r0, r0, #4
  92066c:	e3800001 	orr	r0, r0, #1
  920670:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
  920674:	e12fff1e 	bx	lr

00920678 <Disable_MMU_L1cache>:
  920678:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
  92067c:	e3c00a01 	bic	r0, r0, #4096	; 0x1000
  920680:	e3c00004 	bic	r0, r0, #4
  920684:	e3c00001 	bic	r0, r0, #1
  920688:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
  92068c:	e59f01d8 	ldr	r0, [pc, #472]	; 92086c <finished+0xc0>
  920690:	e3a01000 	mov	r1, #0
  920694:	e5801000 	str	r1, [r0]
  920698:	e12fff1e 	bx	lr

0092069c <Disable_D_cache>:
  92069c:	ee110f10 	mrc	15, 0, r0, cr1, cr0, {0}
  9206a0:	e3c00004 	bic	r0, r0, #4
  9206a4:	ee010f10 	mcr	15, 0, r0, cr1, cr0, {0}
  9206a8:	e12fff1e 	bx	lr

009206ac <Enable_L2_cache>:
  9206ac:	e59f11bc 	ldr	r1, [pc, #444]	; 920870 <finished+0xc4>
  9206b0:	e59f01bc 	ldr	r0, [pc, #444]	; 920874 <finished+0xc8>
  9206b4:	e5810000 	str	r0, [r1]
  9206b8:	e59f11b8 	ldr	r1, [pc, #440]	; 920878 <finished+0xcc>
  9206bc:	e59f01b0 	ldr	r0, [pc, #432]	; 920874 <finished+0xc8>
  9206c0:	e5810000 	str	r0, [r1]
  9206c4:	e59f11b0 	ldr	r1, [pc, #432]	; 92087c <finished+0xd0>
  9206c8:	e59f01b0 	ldr	r0, [pc, #432]	; 920880 <finished+0xd4>
  9206cc:	e5810000 	str	r0, [r1]

009206d0 <l2_inv_loop>:
  9206d0:	e5912000 	ldr	r2, [r1]
  9206d4:	e3a00000 	mov	r0, #0
  9206d8:	e1520000 	cmp	r2, r0
  9206dc:	1afffffb 	bne	9206d0 <l2_inv_loop>
  9206e0:	e59f119c 	ldr	r1, [pc, #412]	; 920884 <finished+0xd8>
  9206e4:	e59f019c 	ldr	r0, [pc, #412]	; 920888 <finished+0xdc>
  9206e8:	e5810000 	str	r0, [r1]
  9206ec:	e59f1178 	ldr	r1, [pc, #376]	; 92086c <finished+0xc0>
  9206f0:	e3a00001 	mov	r0, #1
  9206f4:	e5810000 	str	r0, [r1]
  9206f8:	ee111f30 	mrc	15, 0, r1, cr1, cr0, {1}
  9206fc:	e3811001 	orr	r1, r1, #1
  920700:	e3c11002 	bic	r1, r1, #2
  920704:	e3c11004 	bic	r1, r1, #4
  920708:	ee011f30 	mcr	15, 0, r1, cr1, cr0, {1}
  92070c:	e12fff1e 	bx	lr

00920710 <Disable_L2_cache>:
  920710:	e59f0154 	ldr	r0, [pc, #340]	; 92086c <finished+0xc0>
  920714:	e3a01000 	mov	r1, #0
  920718:	e5801000 	str	r1, [r0]
  92071c:	e12fff1e 	bx	lr

00920720 <Flush_cache>:
  920720:	e3a00000 	mov	r0, #0
  920724:	ee070f15 	mcr	15, 0, r0, cr7, cr5, {0}
  920728:	ee080f17 	mcr	15, 0, r0, cr8, cr7, {0}
  92072c:	ee300f30 	mrc	15, 1, r0, cr0, cr0, {1}
  920730:	e2103407 	ands	r3, r0, #117440512	; 0x7000000
  920734:	e1a03ba3 	lsr	r3, r3, #23
  920738:	0a00001b 	beq	9207ac <finished>
  92073c:	e3a0a000 	mov	sl, #0

00920740 <loop1>:
  920740:	e08a20aa 	add	r2, sl, sl, lsr #1
  920744:	e1a01230 	lsr	r1, r0, r2
  920748:	e2011007 	and	r1, r1, #7
  92074c:	e3510002 	cmp	r1, #2
  920750:	ba000012 	blt	9207a0 <skip>
  920754:	ee40af10 	mcr	15, 2, sl, cr0, cr0, {0}
  920758:	e3a01000 	mov	r1, #0
  92075c:	f57ff06f 	isb	sy
  920760:	ee301f10 	mrc	15, 1, r1, cr0, cr0, {0}
  920764:	e2012007 	and	r2, r1, #7
  920768:	e2822004 	add	r2, r2, #4
  92076c:	e59f4118 	ldr	r4, [pc, #280]	; 92088c <finished+0xe0>
  920770:	e01441a1 	ands	r4, r4, r1, lsr #3
  920774:	e16f5f14 	clz	r5, r4
  920778:	e59f7110 	ldr	r7, [pc, #272]	; 920890 <finished+0xe4>
  92077c:	e01776a1 	ands	r7, r7, r1, lsr #13

00920780 <loop2>:
  920780:	e1a09004 	mov	r9, r4

00920784 <loop3>:
  920784:	e18ab519 	orr	fp, sl, r9, lsl r5
  920788:	e18bb217 	orr	fp, fp, r7, lsl r2
  92078c:	ee07bf56 	mcr	15, 0, fp, cr7, cr6, {2}
  920790:	e2599001 	subs	r9, r9, #1
  920794:	aafffffa 	bge	920784 <loop3>
  920798:	e2577001 	subs	r7, r7, #1
  92079c:	aafffff7 	bge	920780 <loop2>

009207a0 <skip>:
  9207a0:	e28aa002 	add	sl, sl, #2
  9207a4:	e153000a 	cmp	r3, sl
  9207a8:	caffffe4 	bgt	920740 <loop1>

009207ac <finished>:
  9207ac:	f57ff04f 	dsb	sy
  9207b0:	e12fff1e 	bx	lr
  9207b4:	e3a00000 	mov	r0, #0
  9207b8:	ee080f17 	mcr	15, 0, r0, cr8, cr7, {0}
  9207bc:	ee020f50 	mcr	15, 0, r0, cr2, cr0, {2}
  9207c0:	e3a00000 	mov	r0, #0
  9207c4:	ee400f10 	mcr	15, 2, r0, cr0, cr0, {0}
  9207c8:	ee300f10 	mrc	15, 1, r0, cr0, cr0, {0}
  9207cc:	e59f10bc 	ldr	r1, [pc, #188]	; 920890 <finished+0xe4>
  9207d0:	e00126a0 	and	r2, r1, r0, lsr #13
  9207d4:	e59f10b0 	ldr	r1, [pc, #176]	; 92088c <finished+0xe0>
  9207d8:	e00131a0 	and	r3, r1, r0, lsr #3
  9207dc:	e2822001 	add	r2, r2, #1
  9207e0:	e2000007 	and	r0, r0, #7
  9207e4:	e2800004 	add	r0, r0, #4
  9207e8:	e16f1f13 	clz	r1, r3
  9207ec:	e2834001 	add	r4, r3, #1
  9207f0:	e2422001 	sub	r2, r2, #1
  9207f4:	e1a03004 	mov	r3, r4
  9207f8:	e2533001 	subs	r3, r3, #1
  9207fc:	e1a05113 	lsl	r5, r3, r1
  920800:	e1a06012 	lsl	r6, r2, r0
  920804:	e1855006 	orr	r5, r5, r6
  920808:	ee075f56 	mcr	15, 0, r5, cr7, cr6, {2}
  92080c:	cafffff9 	bgt	9207f8 <finished+0x4c>
  920810:	e3520000 	cmp	r2, #0
  920814:	cafffff5 	bgt	9207f0 <finished+0x44>
  920818:	f57ff04f 	dsb	sy
  92081c:	f57ff06f 	isb	sy
  920820:	0092d098 	umullseq	sp, r2, r8, r0
  920824:	00921090 	umullseq	r1, r2, r0, r0
  920828:	00921090 	umullseq	r1, r2, r0, r0
  92082c:	0207c000 	andeq	ip, r7, #0
  920830:	77777777 			; <UNDEFINED> instruction: 0x77777777
  920834:	0217c000 	andseq	ip, r7, #0
  920838:	020c4068 	andeq	r4, ip, #104	; 0x68
  92083c:	020c406c 	andeq	r4, ip, #108	; 0x6c
  920840:	020c4070 	andeq	r4, ip, #112	; 0x70
  920844:	020c4074 	andeq	r4, ip, #116	; 0x74
  920848:	020c4078 	andeq	r4, ip, #120	; 0x78
  92084c:	020c407c 	andeq	r4, ip, #124	; 0x7c
  920850:	020c4080 	andeq	r4, ip, #128	; 0x80
  920854:	00920f3c 	addseq	r0, r2, ip, lsr pc
  920858:	00938000 	addseq	r8, r3, r0
  92085c:	55555555 	ldrbpl	r5, [r5, #-1365]	; 0xfffffaab
  920860:	00002c02 	andeq	r2, r0, r2, lsl #24
  920864:	0090040e 	addseq	r0, r0, lr, lsl #8
  920868:	00a02c02 	adceq	r2, r0, r2, lsl #24
  92086c:	00a02100 	adceq	r2, r0, r0, lsl #2
  920870:	00a02108 	adceq	r2, r0, r8, lsl #2
  920874:	00000132 	andeq	r0, r0, r2, lsr r1
  920878:	00a0210c 	adceq	r2, r0, ip, lsl #2
  92087c:	00a0277c 	adceq	r2, r0, ip, ror r7
  920880:	0000ffff 	strdeq	pc, [r0], -pc	; <UNPREDICTABLE>
  920884:	00a02f60 	adceq	r2, r0, r0, ror #30
  920888:	40800000 	addmi	r0, r0, r0
  92088c:	000003ff 	strdeq	r0, [r0], -pc	; <UNPREDICTABLE>
  920890:	00007fff 	strdeq	r7, [r0], -pc	; <UNPREDICTABLE>
  920894:	00000000 	andeq	r0, r0, r0

00920898 <imx_iomux_v3_setup_pad>:
  920898:	e92d0bf0 	push	{r4, r5, r6, r7, r8, r9, fp}
  92089c:	e28db018 	add	fp, sp, #24
  9208a0:	e24dd034 	sub	sp, sp, #52	; 0x34
  9208a4:	e14b04f4 	strd	r0, [fp, #-68]	; 0xffffffbc
  9208a8:	e3a01000 	mov	r1, #0
  9208ac:	e340120e 	movt	r1, #526	; 0x20e
  9208b0:	e50b1020 	str	r1, [fp, #-32]	; 0xffffffe0
  9208b4:	e51b1044 	ldr	r1, [fp, #-68]	; 0xffffffbc
  9208b8:	e7eb1051 	ubfx	r1, r1, #0, #12
  9208bc:	e50b1024 	str	r1, [fp, #-36]	; 0xffffffdc
  9208c0:	e14b04d4 	ldrd	r0, [fp, #-68]	; 0xffffffbc
  9208c4:	e1a01221 	lsr	r1, r1, #4
  9208c8:	e50b104c 	str	r1, [fp, #-76]	; 0xffffffb4
  9208cc:	e3a01000 	mov	r1, #0
  9208d0:	e50b1048 	str	r1, [fp, #-72]	; 0xffffffb8
  9208d4:	e51b104c 	ldr	r1, [fp, #-76]	; 0xffffffb4
  9208d8:	e201101f 	and	r1, r1, #31
  9208dc:	e50b1028 	str	r1, [fp, #-40]	; 0xffffffd8
  9208e0:	e14b04d4 	ldrd	r0, [fp, #-68]	; 0xffffffbc
  9208e4:	e1a04c20 	lsr	r4, r0, #24
  9208e8:	e1844401 	orr	r4, r4, r1, lsl #8
  9208ec:	e1a05c21 	lsr	r5, r1, #24
  9208f0:	e1a01004 	mov	r1, r4
  9208f4:	e7eb1051 	ubfx	r1, r1, #0, #12
  9208f8:	e50b102c 	str	r1, [fp, #-44]	; 0xffffffd4
  9208fc:	e14b04d4 	ldrd	r0, [fp, #-68]	; 0xffffffbc
  920900:	e1a08da1 	lsr	r8, r1, #27
  920904:	e3a09000 	mov	r9, #0
  920908:	e1a01008 	mov	r1, r8
  92090c:	e201100f 	and	r1, r1, #15
  920910:	e50b1030 	str	r1, [fp, #-48]	; 0xffffffd0
  920914:	e14b04d4 	ldrd	r0, [fp, #-68]	; 0xffffffbc
  920918:	e1a02620 	lsr	r2, r0, #12
  92091c:	e1822a01 	orr	r2, r2, r1, lsl #20
  920920:	e1a03621 	lsr	r3, r1, #12
  920924:	e1a03002 	mov	r3, r2
  920928:	e7eb3053 	ubfx	r3, r3, #0, #12
  92092c:	e50b3034 	str	r3, [fp, #-52]	; 0xffffffcc
  920930:	e14b24d4 	ldrd	r2, [fp, #-68]	; 0xffffffbc
  920934:	e1a064a3 	lsr	r6, r3, #9
  920938:	e3a07000 	mov	r7, #0
  92093c:	e1a03006 	mov	r3, r6
  920940:	e7f13053 	ubfx	r3, r3, #0, #18
  920944:	e50b3038 	str	r3, [fp, #-56]	; 0xffffffc8
  920948:	e51b3024 	ldr	r3, [fp, #-36]	; 0xffffffdc
  92094c:	e3530000 	cmp	r3, #0
  920950:	0a000004 	beq	920968 <imx_iomux_v3_setup_pad+0xd0>
  920954:	e51b2020 	ldr	r2, [fp, #-32]	; 0xffffffe0
  920958:	e51b3024 	ldr	r3, [fp, #-36]	; 0xffffffdc
  92095c:	e0823003 	add	r3, r2, r3
  920960:	e51b2028 	ldr	r2, [fp, #-40]	; 0xffffffd8
  920964:	e5832000 	str	r2, [r3]
  920968:	e51b302c 	ldr	r3, [fp, #-44]	; 0xffffffd4
  92096c:	e3530000 	cmp	r3, #0
  920970:	0a000004 	beq	920988 <imx_iomux_v3_setup_pad+0xf0>
  920974:	e51b2020 	ldr	r2, [fp, #-32]	; 0xffffffe0
  920978:	e51b302c 	ldr	r3, [fp, #-44]	; 0xffffffd4
  92097c:	e0823003 	add	r3, r2, r3
  920980:	e51b2030 	ldr	r2, [fp, #-48]	; 0xffffffd0
  920984:	e5832000 	str	r2, [r3]
  920988:	e51b3038 	ldr	r3, [fp, #-56]	; 0xffffffc8
  92098c:	e2033802 	and	r3, r3, #131072	; 0x20000
  920990:	e3530000 	cmp	r3, #0
  920994:	1a000007 	bne	9209b8 <imx_iomux_v3_setup_pad+0x120>
  920998:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
  92099c:	e3530000 	cmp	r3, #0
  9209a0:	0a000004 	beq	9209b8 <imx_iomux_v3_setup_pad+0x120>
  9209a4:	e51b2020 	ldr	r2, [fp, #-32]	; 0xffffffe0
  9209a8:	e51b3034 	ldr	r3, [fp, #-52]	; 0xffffffcc
  9209ac:	e0823003 	add	r3, r2, r3
  9209b0:	e51b2038 	ldr	r2, [fp, #-56]	; 0xffffffc8
  9209b4:	e5832000 	str	r2, [r3]
  9209b8:	e1a00000 	nop			; (mov r0, r0)
  9209bc:	e24bd018 	sub	sp, fp, #24
  9209c0:	e8bd0bf0 	pop	{r4, r5, r6, r7, r8, r9, fp}
  9209c4:	e12fff1e 	bx	lr

009209c8 <mxc_serial_setbrg>:
  9209c8:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
  9209cc:	e28db000 	add	fp, sp, #0
  9209d0:	e3a03090 	mov	r3, #144	; 0x90
  9209d4:	e3403202 	movt	r3, #514	; 0x202
  9209d8:	e3a02c02 	mov	r2, #512	; 0x200
  9209dc:	e5832000 	str	r2, [r3]
  9209e0:	e3a030a4 	mov	r3, #164	; 0xa4
  9209e4:	e3403202 	movt	r3, #514	; 0x202
  9209e8:	e3a0200f 	mov	r2, #15
  9209ec:	e5832000 	str	r2, [r3]
  9209f0:	e3a030a8 	mov	r3, #168	; 0xa8
  9209f4:	e3403202 	movt	r3, #514	; 0x202
  9209f8:	e300215b 	movw	r2, #347	; 0x15b
  9209fc:	e5832000 	str	r2, [r3]
  920a00:	e1a00000 	nop			; (mov r0, r0)
  920a04:	e24bd000 	sub	sp, fp, #0
  920a08:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
  920a0c:	e12fff1e 	bx	lr

00920a10 <mxc_serial_putc>:
  920a10:	e92d4800 	push	{fp, lr}
  920a14:	e28db004 	add	fp, sp, #4
  920a18:	e24dd008 	sub	sp, sp, #8
  920a1c:	e1a03000 	mov	r3, r0
  920a20:	e54b3005 	strb	r3, [fp, #-5]
  920a24:	e3a03040 	mov	r3, #64	; 0x40
  920a28:	e3403202 	movt	r3, #514	; 0x202
  920a2c:	e55b2005 	ldrb	r2, [fp, #-5]
  920a30:	e5832000 	str	r2, [r3]
  920a34:	e1a00000 	nop			; (mov r0, r0)
  920a38:	e3a030b4 	mov	r3, #180	; 0xb4
  920a3c:	e3403202 	movt	r3, #514	; 0x202
  920a40:	e5933000 	ldr	r3, [r3]
  920a44:	e2033040 	and	r3, r3, #64	; 0x40
  920a48:	e3530000 	cmp	r3, #0
  920a4c:	0afffff9 	beq	920a38 <mxc_serial_putc+0x28>
  920a50:	e55b3005 	ldrb	r3, [fp, #-5]
  920a54:	e353000a 	cmp	r3, #10
  920a58:	1a000001 	bne	920a64 <mxc_serial_putc+0x54>
  920a5c:	e3a0000d 	mov	r0, #13
  920a60:	ebffffea 	bl	920a10 <mxc_serial_putc>
  920a64:	e1a00000 	nop			; (mov r0, r0)
  920a68:	e24bd004 	sub	sp, fp, #4
  920a6c:	e8bd8800 	pop	{fp, pc}

00920a70 <mxc_serial_init>:
  920a70:	e92d4800 	push	{fp, lr}
  920a74:	e28db004 	add	fp, sp, #4
  920a78:	e3a03080 	mov	r3, #128	; 0x80
  920a7c:	e3403202 	movt	r3, #514	; 0x202
  920a80:	e3a02000 	mov	r2, #0
  920a84:	e5832000 	str	r2, [r3]
  920a88:	e3a03084 	mov	r3, #132	; 0x84
  920a8c:	e3403202 	movt	r3, #514	; 0x202
  920a90:	e3a02000 	mov	r2, #0
  920a94:	e5832000 	str	r2, [r3]
  920a98:	e1a00000 	nop			; (mov r0, r0)
  920a9c:	e3a03084 	mov	r3, #132	; 0x84
  920aa0:	e3403202 	movt	r3, #514	; 0x202
  920aa4:	e5933000 	ldr	r3, [r3]
  920aa8:	e2033001 	and	r3, r3, #1
  920aac:	e3530000 	cmp	r3, #0
  920ab0:	0afffff9 	beq	920a9c <mxc_serial_init+0x2c>
  920ab4:	e3a03088 	mov	r3, #136	; 0x88
  920ab8:	e3403202 	movt	r3, #514	; 0x202
  920abc:	e3002784 	movw	r2, #1924	; 0x784
  920ac0:	e5832000 	str	r2, [r3]
  920ac4:	e3a0308c 	mov	r3, #140	; 0x8c
  920ac8:	e3403202 	movt	r3, #514	; 0x202
  920acc:	e3a02902 	mov	r2, #32768	; 0x8000
  920ad0:	e5832000 	str	r2, [r3]
  920ad4:	e3a0309c 	mov	r3, #156	; 0x9c
  920ad8:	e3403202 	movt	r3, #514	; 0x202
  920adc:	e3a0202b 	mov	r2, #43	; 0x2b
  920ae0:	e5832000 	str	r2, [r3]
  920ae4:	e3a030a0 	mov	r3, #160	; 0xa0
  920ae8:	e3403202 	movt	r3, #514	; 0x202
  920aec:	e3a02000 	mov	r2, #0
  920af0:	e5832000 	str	r2, [r3]
  920af4:	e3a030b4 	mov	r3, #180	; 0xb4
  920af8:	e3403202 	movt	r3, #514	; 0x202
  920afc:	e3a02000 	mov	r2, #0
  920b00:	e5832000 	str	r2, [r3]
  920b04:	ebffffaf 	bl	9209c8 <mxc_serial_setbrg>
  920b08:	e3a03084 	mov	r3, #132	; 0x84
  920b0c:	e3403202 	movt	r3, #514	; 0x202
  920b10:	e3042027 	movw	r2, #16423	; 0x4027
  920b14:	e5832000 	str	r2, [r3]
  920b18:	e3a03080 	mov	r3, #128	; 0x80
  920b1c:	e3403202 	movt	r3, #514	; 0x202
  920b20:	e3a02001 	mov	r2, #1
  920b24:	e5832000 	str	r2, [r3]
  920b28:	e3a0000a 	mov	r0, #10
  920b2c:	ebffffb7 	bl	920a10 <mxc_serial_putc>
  920b30:	e3a00048 	mov	r0, #72	; 0x48
  920b34:	ebffffb5 	bl	920a10 <mxc_serial_putc>
  920b38:	e3a00045 	mov	r0, #69	; 0x45
  920b3c:	ebffffb3 	bl	920a10 <mxc_serial_putc>
  920b40:	e3a0004c 	mov	r0, #76	; 0x4c
  920b44:	ebffffb1 	bl	920a10 <mxc_serial_putc>
  920b48:	e3a0004c 	mov	r0, #76	; 0x4c
  920b4c:	ebffffaf 	bl	920a10 <mxc_serial_putc>
  920b50:	e3a0004f 	mov	r0, #79	; 0x4f
  920b54:	ebffffad 	bl	920a10 <mxc_serial_putc>
  920b58:	e3a00020 	mov	r0, #32
  920b5c:	ebffffab 	bl	920a10 <mxc_serial_putc>
  920b60:	e3a00057 	mov	r0, #87	; 0x57
  920b64:	ebffffa9 	bl	920a10 <mxc_serial_putc>
  920b68:	e3a0004f 	mov	r0, #79	; 0x4f
  920b6c:	ebffffa7 	bl	920a10 <mxc_serial_putc>
  920b70:	e3a00052 	mov	r0, #82	; 0x52
  920b74:	ebffffa5 	bl	920a10 <mxc_serial_putc>
  920b78:	e3a0004c 	mov	r0, #76	; 0x4c
  920b7c:	ebffffa3 	bl	920a10 <mxc_serial_putc>
  920b80:	e3a00044 	mov	r0, #68	; 0x44
  920b84:	ebffffa1 	bl	920a10 <mxc_serial_putc>
  920b88:	e3a0000a 	mov	r0, #10
  920b8c:	ebffff9f 	bl	920a10 <mxc_serial_putc>
  920b90:	e3a0004d 	mov	r0, #77	; 0x4d
  920b94:	ebffff9d 	bl	920a10 <mxc_serial_putc>
  920b98:	e3a00055 	mov	r0, #85	; 0x55
  920b9c:	ebffff9b 	bl	920a10 <mxc_serial_putc>
  920ba0:	e3a0004c 	mov	r0, #76	; 0x4c
  920ba4:	ebffff99 	bl	920a10 <mxc_serial_putc>
  920ba8:	e3a00054 	mov	r0, #84	; 0x54
  920bac:	ebffff97 	bl	920a10 <mxc_serial_putc>
  920bb0:	e3a00049 	mov	r0, #73	; 0x49
  920bb4:	ebffff95 	bl	920a10 <mxc_serial_putc>
  920bb8:	e3a00043 	mov	r0, #67	; 0x43
  920bbc:	ebffff93 	bl	920a10 <mxc_serial_putc>
  920bc0:	e3a0004f 	mov	r0, #79	; 0x4f
  920bc4:	ebffff91 	bl	920a10 <mxc_serial_putc>
  920bc8:	e3a00052 	mov	r0, #82	; 0x52
  920bcc:	ebffff8f 	bl	920a10 <mxc_serial_putc>
  920bd0:	e3a00045 	mov	r0, #69	; 0x45
  920bd4:	ebffff8d 	bl	920a10 <mxc_serial_putc>
  920bd8:	e3a0000a 	mov	r0, #10
  920bdc:	ebffff8b 	bl	920a10 <mxc_serial_putc>
  920be0:	e3a03000 	mov	r3, #0
  920be4:	e1a00003 	mov	r0, r3
  920be8:	e8bd8800 	pop	{fp, pc}

00920bec <pause>:
  920bec:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
  920bf0:	e28db000 	add	fp, sp, #0
  920bf4:	e24dd00c 	sub	sp, sp, #12
  920bf8:	e50b0008 	str	r0, [fp, #-8]
  920bfc:	e1a00000 	nop			; (mov r0, r0)
  920c00:	e51b3008 	ldr	r3, [fp, #-8]
  920c04:	e2432001 	sub	r2, r3, #1
  920c08:	e50b2008 	str	r2, [fp, #-8]
  920c0c:	e3530000 	cmp	r3, #0
  920c10:	1afffffa 	bne	920c00 <pause+0x14>
  920c14:	e1a00000 	nop			; (mov r0, r0)
  920c18:	e24bd000 	sub	sp, fp, #0
  920c1c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
  920c20:	e12fff1e 	bx	lr

00920c24 <outbyte>:
  920c24:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
  920c28:	e28db000 	add	fp, sp, #0
  920c2c:	e24dd00c 	sub	sp, sp, #12
  920c30:	e1a03000 	mov	r3, r0
  920c34:	e54b3005 	strb	r3, [fp, #-5]
  920c38:	e1a00000 	nop			; (mov r0, r0)
  920c3c:	e3a03094 	mov	r3, #148	; 0x94
  920c40:	e3403202 	movt	r3, #514	; 0x202
  920c44:	e5933000 	ldr	r3, [r3]
  920c48:	e2033a02 	and	r3, r3, #8192	; 0x2000
  920c4c:	e3530000 	cmp	r3, #0
  920c50:	0afffff9 	beq	920c3c <outbyte+0x18>
  920c54:	e3a03040 	mov	r3, #64	; 0x40
  920c58:	e3403202 	movt	r3, #514	; 0x202
  920c5c:	e55b2005 	ldrb	r2, [fp, #-5]
  920c60:	e5832000 	str	r2, [r3]
  920c64:	e1a00000 	nop			; (mov r0, r0)
  920c68:	e24bd000 	sub	sp, fp, #0
  920c6c:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
  920c70:	e12fff1e 	bx	lr

00920c74 <UART1_init>:
  920c74:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
  920c78:	e28db000 	add	fp, sp, #0
  920c7c:	e24dd00c 	sub	sp, sp, #12
  920c80:	e3a03fa1 	mov	r3, #644	; 0x284
  920c84:	e340320e 	movt	r3, #526	; 0x20e
  920c88:	e3a02fa1 	mov	r2, #644	; 0x284
  920c8c:	e340220e 	movt	r2, #526	; 0x20e
  920c90:	e5922000 	ldr	r2, [r2]
  920c94:	e3822003 	orr	r2, r2, #3
  920c98:	e5832000 	str	r2, [r3]
  920c9c:	e3a03fa1 	mov	r3, #644	; 0x284
  920ca0:	e340320e 	movt	r3, #526	; 0x20e
  920ca4:	e3a02fa1 	mov	r2, #644	; 0x284
  920ca8:	e340220e 	movt	r2, #526	; 0x20e
  920cac:	e5922000 	ldr	r2, [r2]
  920cb0:	e3c22004 	bic	r2, r2, #4
  920cb4:	e5832000 	str	r2, [r3]
  920cb8:	e3a03e92 	mov	r3, #2336	; 0x920
  920cbc:	e340320e 	movt	r3, #526	; 0x20e
  920cc0:	e3a02001 	mov	r2, #1
  920cc4:	e5832000 	str	r2, [r3]
  920cc8:	e3a03d0a 	mov	r3, #640	; 0x280
  920ccc:	e340320e 	movt	r3, #526	; 0x20e
  920cd0:	e3a02d0a 	mov	r2, #640	; 0x280
  920cd4:	e340220e 	movt	r2, #526	; 0x20e
  920cd8:	e5922000 	ldr	r2, [r2]
  920cdc:	e3822003 	orr	r2, r2, #3
  920ce0:	e5832000 	str	r2, [r3]
  920ce4:	e3a03d0a 	mov	r3, #640	; 0x280
  920ce8:	e340320e 	movt	r3, #526	; 0x20e
  920cec:	e3a02d0a 	mov	r2, #640	; 0x280
  920cf0:	e340220e 	movt	r2, #526	; 0x20e
  920cf4:	e5922000 	ldr	r2, [r2]
  920cf8:	e3c22004 	bic	r2, r2, #4
  920cfc:	e5832000 	str	r2, [r3]
  920d00:	e3043024 	movw	r3, #16420	; 0x4024
  920d04:	e340320c 	movt	r3, #524	; 0x20c
  920d08:	e5933000 	ldr	r3, [r3]
  920d0c:	e203303f 	and	r3, r3, #63	; 0x3f
  920d10:	e50b3008 	str	r3, [fp, #-8]
  920d14:	e3043024 	movw	r3, #16420	; 0x4024
  920d18:	e340320c 	movt	r3, #524	; 0x20c
  920d1c:	e51b2008 	ldr	r2, [fp, #-8]
  920d20:	e5832000 	str	r2, [r3]
  920d24:	e3a03084 	mov	r3, #132	; 0x84
  920d28:	e3403202 	movt	r3, #514	; 0x202
  920d2c:	e3a02001 	mov	r2, #1
  920d30:	e5832000 	str	r2, [r3]
  920d34:	e3a03084 	mov	r3, #132	; 0x84
  920d38:	e3403202 	movt	r3, #514	; 0x202
  920d3c:	e3022006 	movw	r2, #8198	; 0x2006
  920d40:	e5832000 	str	r2, [r3]
  920d44:	e3a03080 	mov	r3, #128	; 0x80
  920d48:	e3403202 	movt	r3, #514	; 0x202
  920d4c:	e3a02001 	mov	r2, #1
  920d50:	e5832000 	str	r2, [r3]
  920d54:	e3a03084 	mov	r3, #132	; 0x84
  920d58:	e3403202 	movt	r3, #514	; 0x202
  920d5c:	e3a02084 	mov	r2, #132	; 0x84
  920d60:	e3402202 	movt	r2, #514	; 0x202
  920d64:	e5922000 	ldr	r2, [r2]
  920d68:	e3822901 	orr	r2, r2, #16384	; 0x4000
  920d6c:	e5832000 	str	r2, [r3]
  920d70:	e3a03084 	mov	r3, #132	; 0x84
  920d74:	e3403202 	movt	r3, #514	; 0x202
  920d78:	e3a02084 	mov	r2, #132	; 0x84
  920d7c:	e3402202 	movt	r2, #514	; 0x202
  920d80:	e5922000 	ldr	r2, [r2]
  920d84:	e3822020 	orr	r2, r2, #32
  920d88:	e5832000 	str	r2, [r3]
  920d8c:	e3a03084 	mov	r3, #132	; 0x84
  920d90:	e3403202 	movt	r3, #514	; 0x202
  920d94:	e3a02084 	mov	r2, #132	; 0x84
  920d98:	e3402202 	movt	r2, #514	; 0x202
  920d9c:	e5922000 	ldr	r2, [r2]
  920da0:	e3822040 	orr	r2, r2, #64	; 0x40
  920da4:	e5832000 	str	r2, [r3]
  920da8:	e3a03088 	mov	r3, #136	; 0x88
  920dac:	e3403202 	movt	r3, #514	; 0x202
  920db0:	e3a02088 	mov	r2, #136	; 0x88
  920db4:	e3402202 	movt	r2, #514	; 0x202
  920db8:	e5922000 	ldr	r2, [r2]
  920dbc:	e3822004 	orr	r2, r2, #4
  920dc0:	e5832000 	str	r2, [r3]
  920dc4:	e3a02080 	mov	r2, #128	; 0x80
  920dc8:	e3402202 	movt	r2, #514	; 0x202
  920dcc:	e3a03080 	mov	r3, #128	; 0x80
  920dd0:	e3403202 	movt	r3, #514	; 0x202
  920dd4:	e5933000 	ldr	r3, [r3]
  920dd8:	e3833c02 	orr	r3, r3, #512	; 0x200
  920ddc:	e3833001 	orr	r3, r3, #1
  920de0:	e5823000 	str	r3, [r2]
  920de4:	e3a03084 	mov	r3, #132	; 0x84
  920de8:	e3403202 	movt	r3, #514	; 0x202
  920dec:	e3a02084 	mov	r2, #132	; 0x84
  920df0:	e3402202 	movt	r2, #514	; 0x202
  920df4:	e5922000 	ldr	r2, [r2]
  920df8:	e3c22c01 	bic	r2, r2, #256	; 0x100
  920dfc:	e5832000 	str	r2, [r3]
  920e00:	e3a03090 	mov	r3, #144	; 0x90
  920e04:	e3403202 	movt	r3, #514	; 0x202
  920e08:	e5933000 	ldr	r3, [r3]
  920e0c:	e50b3008 	str	r3, [fp, #-8]
  920e10:	e3a03090 	mov	r3, #144	; 0x90
  920e14:	e3403202 	movt	r3, #514	; 0x202
  920e18:	e3a02d0a 	mov	r2, #640	; 0x280
  920e1c:	e5832000 	str	r2, [r3]
  920e20:	e3a03090 	mov	r3, #144	; 0x90
  920e24:	e3403202 	movt	r3, #514	; 0x202
  920e28:	e3a02090 	mov	r2, #144	; 0x90
  920e2c:	e3402202 	movt	r2, #514	; 0x202
  920e30:	e5921000 	ldr	r1, [r2]
  920e34:	e51b2008 	ldr	r2, [fp, #-8]
  920e38:	e1812002 	orr	r2, r1, r2
  920e3c:	e5832000 	str	r2, [r3]
  920e40:	e3a030a4 	mov	r3, #164	; 0xa4
  920e44:	e3403202 	movt	r3, #514	; 0x202
  920e48:	e3a02004 	mov	r2, #4
  920e4c:	e5832000 	str	r2, [r3]
  920e50:	e3a030a8 	mov	r3, #168	; 0xa8
  920e54:	e3403202 	movt	r3, #514	; 0x202
  920e58:	e3a020d8 	mov	r2, #216	; 0xd8
  920e5c:	e5832000 	str	r2, [r3]
  920e60:	e1a00000 	nop			; (mov r0, r0)
  920e64:	e24bd000 	sub	sp, fp, #0
  920e68:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
  920e6c:	e12fff1e 	bx	lr

00920e70 <start_secondary_cpu>:
  920e70:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
  920e74:	e28db000 	add	fp, sp, #0
  920e78:	e24dd014 	sub	sp, sp, #20
  920e7c:	e50b0010 	str	r0, [fp, #-16]
  920e80:	e50b1014 	str	r1, [fp, #-20]	; 0xffffffec
  920e84:	e51b2010 	ldr	r2, [fp, #-16]
  920e88:	e30b3004 	movw	r3, #45060	; 0xb004
  920e8c:	e3403041 	movt	r3, #65	; 0x41
  920e90:	e0823003 	add	r3, r2, r3
  920e94:	e1a03183 	lsl	r3, r3, #3
  920e98:	e1a02003 	mov	r2, r3
  920e9c:	e300342c 	movw	r3, #1068	; 0x42c
  920ea0:	e3403092 	movt	r3, #146	; 0x92
  920ea4:	e5823000 	str	r3, [r2]
  920ea8:	e51b3010 	ldr	r3, [fp, #-16]
  920eac:	e1a02183 	lsl	r2, r3, #3
  920eb0:	e3083024 	movw	r3, #32804	; 0x8024
  920eb4:	e340320d 	movt	r3, #525	; 0x20d
  920eb8:	e0823003 	add	r3, r2, r3
  920ebc:	e1a02003 	mov	r2, r3
  920ec0:	e51b3014 	ldr	r3, [fp, #-20]	; 0xffffffec
  920ec4:	e5823000 	str	r3, [r2]
  920ec8:	e51b3010 	ldr	r3, [fp, #-16]
  920ecc:	e3530000 	cmp	r3, #0
  920ed0:	da00000c 	ble	920f08 <start_secondary_cpu+0x98>
  920ed4:	e3a03902 	mov	r3, #32768	; 0x8000
  920ed8:	e340320d 	movt	r3, #525	; 0x20d
  920edc:	e5933000 	ldr	r3, [r3]
  920ee0:	e51b2010 	ldr	r2, [fp, #-16]
  920ee4:	e2822015 	add	r2, r2, #21
  920ee8:	e3a01001 	mov	r1, #1
  920eec:	e1a02211 	lsl	r2, r1, r2
  920ef0:	e1833002 	orr	r3, r3, r2
  920ef4:	e50b3008 	str	r3, [fp, #-8]
  920ef8:	e3a03902 	mov	r3, #32768	; 0x8000
  920efc:	e340320d 	movt	r3, #525	; 0x20d
  920f00:	e51b2008 	ldr	r2, [fp, #-8]
  920f04:	e5832000 	str	r2, [r3]
  920f08:	e1a00000 	nop			; (mov r0, r0)
  920f0c:	e24bd000 	sub	sp, fp, #0
  920f10:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
  920f14:	e12fff1e 	bx	lr

00920f18 <getCPUnum>:
  920f18:	e52db004 	push	{fp}		; (str fp, [sp, #-4]!)
  920f1c:	e28db000 	add	fp, sp, #0
  920f20:	ee100fb0 	mrc	15, 0, r0, cr0, cr0, {5}
  920f24:	e2000003 	and	r0, r0, #3
  920f28:	e1a03000 	mov	r3, r0
  920f2c:	e1a00003 	mov	r0, r3
  920f30:	e24bd000 	sub	sp, fp, #0
  920f34:	e49db004 	pop	{fp}		; (ldr fp, [sp], #4)
  920f38:	e12fff1e 	bx	lr

00920f3c <main>:
  920f3c:	e92d4800 	push	{fp, lr}
  920f40:	e28db004 	add	fp, sp, #4
  920f44:	e24dd008 	sub	sp, sp, #8
  920f48:	ebfffff2 	bl	920f18 <getCPUnum>
  920f4c:	e50b0008 	str	r0, [fp, #-8]
  920f50:	e51b3008 	ldr	r3, [fp, #-8]
  920f54:	e3530000 	cmp	r3, #0
  920f58:	1a000014 	bne	920fb0 <main+0x74>
  920f5c:	ebffff44 	bl	920c74 <UART1_init>
  920f60:	e3a00046 	mov	r0, #70	; 0x46
  920f64:	ebffff2e 	bl	920c24 <outbyte>
  920f68:	e3a03f8d 	mov	r3, #564	; 0x234
  920f6c:	e340320e 	movt	r3, #526	; 0x20e
  920f70:	e3a02f8d 	mov	r2, #564	; 0x234
  920f74:	e340220e 	movt	r2, #526	; 0x20e
  920f78:	e5922000 	ldr	r2, [r2]
  920f7c:	e3822005 	orr	r2, r2, #5
  920f80:	e5832000 	str	r2, [r3]
  920f84:	e3a03f8d 	mov	r3, #564	; 0x234
  920f88:	e340320e 	movt	r3, #526	; 0x20e
  920f8c:	e3a02f8d 	mov	r2, #564	; 0x234
  920f90:	e340220e 	movt	r2, #526	; 0x20e
  920f94:	e5922000 	ldr	r2, [r2]
  920f98:	e3c22002 	bic	r2, r2, #2
  920f9c:	e5832000 	str	r2, [r3]
  920fa0:	e30c3004 	movw	r3, #49156	; 0xc004
  920fa4:	e3403209 	movt	r3, #521	; 0x209
  920fa8:	e3a02004 	mov	r2, #4
  920fac:	e5832000 	str	r2, [r3]
  920fb0:	e28f10c8 	add	r1, pc, #200	; 0xc8
  920fb4:	e1c100d0 	ldrd	r0, [r1]
  920fb8:	ebfffe36 	bl	920898 <imx_iomux_v3_setup_pad>
  920fbc:	e28f10c4 	add	r1, pc, #196	; 0xc4
  920fc0:	e1c100d0 	ldrd	r0, [r1]
  920fc4:	ebfffe33 	bl	920898 <imx_iomux_v3_setup_pad>
  920fc8:	ebfffea8 	bl	920a70 <mxc_serial_init>
  920fcc:	e51b3008 	ldr	r3, [fp, #-8]
  920fd0:	e3530003 	cmp	r3, #3
  920fd4:	ca000002 	bgt	920fe4 <main+0xa8>
  920fd8:	e51b3008 	ldr	r3, [fp, #-8]
  920fdc:	e3530000 	cmp	r3, #0
  920fe0:	aa000002 	bge	920ff0 <main+0xb4>
  920fe4:	e3a00021 	mov	r0, #33	; 0x21
  920fe8:	ebfffe88 	bl	920a10 <mxc_serial_putc>
  920fec:	ea000005 	b	921008 <main+0xcc>
  920ff0:	e51b3008 	ldr	r3, [fp, #-8]
  920ff4:	e6ef3073 	uxtb	r3, r3
  920ff8:	e2833031 	add	r3, r3, #49	; 0x31
  920ffc:	e6ef3073 	uxtb	r3, r3
  921000:	e1a00003 	mov	r0, r3
  921004:	ebfffe81 	bl	920a10 <mxc_serial_putc>
  921008:	e51b3008 	ldr	r3, [fp, #-8]
  92100c:	e3530002 	cmp	r3, #2
  921010:	ca000005 	bgt	92102c <main+0xf0>
  921014:	e51b3008 	ldr	r3, [fp, #-8]
  921018:	e2833001 	add	r3, r3, #1
  92101c:	e3001f3c 	movw	r1, #3900	; 0xf3c
  921020:	e3401092 	movt	r1, #146	; 0x92
  921024:	e1a00003 	mov	r0, r3
  921028:	ebffff90 	bl	920e70 <start_secondary_cpu>
  92102c:	e51b3008 	ldr	r3, [fp, #-8]
  921030:	e3530000 	cmp	r3, #0
  921034:	0a000000 	beq	92103c <main+0x100>
  921038:	eafffffe 	b	921038 <main+0xfc>
  92103c:	e3a0002a 	mov	r0, #42	; 0x2a
  921040:	ebfffef7 	bl	920c24 <outbyte>
  921044:	e3a00605 	mov	r0, #5242880	; 0x500000
  921048:	ebfffee7 	bl	920bec <pause>
  92104c:	e3a03903 	mov	r3, #49152	; 0xc000
  921050:	e3403209 	movt	r3, #521	; 0x209
  921054:	e3a02004 	mov	r2, #4
  921058:	e5832000 	str	r2, [r3]
  92105c:	e3a0002d 	mov	r0, #45	; 0x2d
  921060:	ebfffeef 	bl	920c24 <outbyte>
  921064:	e3a00605 	mov	r0, #5242880	; 0x500000
  921068:	ebfffedf 	bl	920bec <pause>
  92106c:	e3a03903 	mov	r3, #49152	; 0xc000
  921070:	e3403209 	movt	r3, #521	; 0x209
  921074:	e3a02000 	mov	r2, #0
  921078:	e5832000 	str	r2, [r3]
  92107c:	eaffffee 	b	92103c <main+0x100>
  921080:	00650280 	rsbeq	r0, r5, r0, lsl #5
  921084:	03616230 	cmneq	r1, #48, 4
  921088:	20654284 	rsbcs	r4, r5, r4, lsl #5
  92108c:	0b616239 	bleq	2179978 <SRC_BASE_ADDR+0xa1978>

Disassembly of section .mmu_page_table:

00938000 <__mmu_page_table_base__>:
	...

Disassembly of section .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00002e41 	andeq	r2, r0, r1, asr #28
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000024 	andeq	r0, r0, r4, lsr #32
  10:	412d3705 			; <UNDEFINED> instruction: 0x412d3705
  14:	070a0600 	streq	r0, [sl, -r0, lsl #12]
  18:	09010841 	stmdbeq	r1, {r0, r6, fp}
  1c:	0c030a02 			; <UNDEFINED> instruction: 0x0c030a02
  20:	14041201 	strne	r1, [r4], #-513	; 0xfffffdff
  24:	17011501 	strne	r1, [r1, -r1, lsl #10]
  28:	1a011803 	bne	4603c <outer_inner_WT_S+0x35432>
  2c:	Address 0x000000000000002c is out of bounds.


Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <VFP_DN_ENABLE+0xd0d24>
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

