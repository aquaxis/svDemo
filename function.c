
#include "dpi.h"

int cFuncStart()
{
  int rslt;
  printf("[cFuncStart]\n");
  rslt = svPlWrite(0x40000000, 0x01234567);
//  taskTest(10, & rslt);
//  printf("rslt: %08x\n", rslt);
  printf("[Check LED]\n");
  svStopSim();
  return 0 ;
}

// 67d7842dbbe25473c3c32b93c0da8047785f30d78e8a024de1b57352245f9689
