// ------------------------------------------------------------
// Cortex-A MPCore - Snoop Control Unit
// Suitable for the Cortex-A9 MPCore and Cortex-A5 MPCore
// Header File
//
// Copyright (c) 2011-2014 ARM Ltd.  All rights reserved.
// ------------------------------------------------------------

#ifndef _CORTEXA_SCU_H
#define _CORTEXA_SCU_H

// ------------------------------------------------------------
// SCU
// ------------------------------------------------------------

// Returns the number of cores in the A9 Cluster
unsigned int getNumCPUs(void);

// ------------------------------------------------------------
// SCU
// ------------------------------------------------------------

// Enables the SCU
void enableSCU(void);

// The return value is 1 bit per core:
// bit 0 (0x1) - CPU 0
// bit 1 (0x2) - CPU 1
// bit 2 (0x4) - CPU 2
// bit 3 (0x8) - CPU 3
unsigned int getCPUsInSMP(void);

 //Enable the broadcasting of cache & TLB maintenance operations
// When enabled AND in SMP, broadcast all "inner sharable"
// cache and TLM maintenance operations to other SMP cores
void enableMaintenanceBroadcast(void);

// Disable the broadcasting of cache & TLB maintenance operations
void disableMaintenanceBroadcast(void);

// cpu: 0x0=CPU 0 0x1=CPU 1 etc...
// This function invalidates the SCU copy of the tag rams
// for the specified core.
void secureSCUInvalidate(unsigned int cpu, unsigned int ways);

// ------------------------------------------------------------
// TrustZone
// ------------------------------------------------------------

// Sets whether the Private Timer & Watchdog can be accessed in NS world
// secure -  IF 0 (secure access only) ELSE (ns access allowed)
void setPrivateTimersNonSecureAccess(unsigned int secure, unsigned int cpu);


// Sets whether the Global Timer can be accessed in NS world
// secure -  IF 0 (secure access only) ELSE (ns access allowed)
void setGlobalTimersNonSecureAccess(unsigned int secure, unsigned int cpu);

#endif

// ------------------------------------------------------------
// End of MP_SCU.h
// ------------------------------------------------------------
