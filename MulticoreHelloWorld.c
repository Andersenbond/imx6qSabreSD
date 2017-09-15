
#include "stdio.h"

void start_secondary_cpu(int cpu_num, unsigned int *ptr){
	/* prepare pointers for ROM code */
	writel((u32)&ResetHandler, SRC_BASE_ADDR + (SRC_GPR1_OFFSET + cpu_num*8));
	writel((u32)ptr, SRC_BASE_ADDR + (SRC_GPR2_OFFSET + cpu_num*8));
	/* start core */
	if (cpu_num > 0){
		writel( (readl(SRC_BASE_ADDR + SRC_SCR_OFFSET) | (1 << (21 + cpu_num))),(SRC_BASE_ADDR + SRC_SCR_OFFSET));
	}
}

void hello_mpcore(){
	int cpu_id, i;
	cpu_id = getCPUnum();
	if (cpu_id == 0){
		debug_uart_iomux();
		debug_uart->freq = 80000000;
		init_debug_uart(debug_uart, 115200);
		printf("####################################################\n");
	}
	printf("Hello from CPU %d\n", cpu_id);
	if (cpu_id < (TOTAL_CORES-1)){ //start the next core
		start_secondary_cpu(cpu_id+1, (unsigned int *)&hello_mpcore);
	}
	while(1);
}