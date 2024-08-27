//! \file   32haus.c
/// \date   2018-03-23 ��. 05:00
/// \author Kurbanov Zulkaid kurbanov_z kurbanov_z@mcst.ru
/// \brief  
///
/// $Id$
///  ��� ����� ����� ����������
///  :! clear && gcc % -lm && ./a.out
///  HOME /home/kurbanov_z/Desktop/code/handtests/e2k/d200318
///  EXT  /auto/vgr/users/kurbanov_z/fixed_dir/d200318

#include <stdio.h>
#include <float.h>
#include <stdint.h>
#include <fenv.h>

#pragma STDC FENV_ACCESS ON

union f32_union {
	uint32_t i;
	float f;
} a,b,c;

int main () {
	
	feclearexcept(FE_ALL_EXCEPT);
	fesetround(FE_TONEAREST);
	
	a.i=0x45000001;
	printf("%f\n",a.f);
	printf("%e\n",a.f);
	printf("0x%x\n",a.i);
	printf("-------\n");
	
	b.i=0x45000002;
	printf("%f\n",b.f);
	printf("%e\n",b.f);
	printf("0x%x\n",b.i);
	printf("-------\n");
	
	c.f = a.f*b.f;
	printf("%f\n",c.f);
	printf("%e\n",c.f);
	printf("0x%x\n",c.i);
	printf("-------\n");
	
	if(fetestexcept(FE_DIVBYZERO)) printf(" FE_DIVBYZERO");
	if(fetestexcept(FE_INEXACT))   printf(" FE_INEXACT");
	if(fetestexcept(FE_INVALID))   printf(" FE_INVALID");
	if(fetestexcept(FE_OVERFLOW))  printf(" FE_OVERFLOW");
	if(fetestexcept(FE_UNDERFLOW)) printf(" FE_UNDERFLOW");
	feclearexcept(FE_ALL_EXCEPT);
	printf("\n");
	printf("-------\n");
	
///////////////////////////////////////////////////////////////////////////////
	
	feclearexcept(FE_ALL_EXCEPT);
	
	a.i=0x05000003;
	printf("%f\n",a.f);
	printf("%e\n",a.f);
	printf("0x%x\n",a.i);
	printf("-------\n");
	
	b.i=0x06000002;
	printf("%f\n",b.f);
	printf("%e\n",b.f);
	printf("0x%x\n",b.i);
	printf("-------\n");
	
	c.f = a.f*b.f;
	printf("%f\n",c.f);
	printf("%e\n",c.f);
	printf("0x%x\n",c.i);
	printf("-------\n");
	
	if(fetestexcept(FE_DIVBYZERO)) printf(" FE_DIVBYZERO");
	if(fetestexcept(FE_INEXACT))   printf(" FE_INEXACT");
	if(fetestexcept(FE_INVALID))   printf(" FE_INVALID");
	if(fetestexcept(FE_OVERFLOW))  printf(" FE_OVERFLOW");
	if(fetestexcept(FE_UNDERFLOW)) printf(" FE_UNDERFLOW");
	feclearexcept(FE_ALL_EXCEPT);
	printf("\n");
	printf("-------\n");
	
return 0;
}
