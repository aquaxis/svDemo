#include <stdio.h>
#include "svdpi.h" /* Vivado 2018.2ではdpi.hからsvdpi.hに変わっています */

int cFuncStart()
{
  int rslt;

  printf("[INFO] cFuncStart()\n");

  rslt = svPlWrite(0x40000000, 0x01234567);

//  taskTest(10, & rslt);
//  printf("rslt: %08x\n", rslt);

  printf("[INFO] Check LED\n");

  svStopSim();

  return 0 ;
}
