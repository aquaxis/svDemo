#include "dpi.h"

#define MAP_LENG 0x00010000

int svPlWrite(unsigned int addr, unsigned int data)
{
    int fd;
    unsigned int *laddr;

    fd = open( "/dev/mem", O_RDWR | O_SYNC );
    if( fd == -1 ){
      printf( "Can't open /dev/mem.\n" );
      return 0;
    }

    laddr = mmap( NULL, MAP_LENG, PROT_READ | PROT_WRITE, MAP_SHARED, fd, addr & 0xFFFF0000);
    if( addr == MAP_FAILED ){
        printf( "Error: mmap()\n" );
        return 0;
    }

    laddr[(addr & 0x0000FFFC) / 4] = data;

    munmap(laddr, MAP_LENG);

    close(fd);

    return 0;
}

int main(int argc, char **argv)
{
    cFuncStart();

    return 0;
}
