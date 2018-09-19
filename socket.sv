// socket sample
import "DPI-C" function chandle socket_open(input string uri);                       // socket open(hostname:port)
import "DPI-C" function void socket_close(input chandle handle);                     // socket close
import "DPI-C" function int socket_write(input chandle handle, input string data); // socket write
import "DPI-C" function string socket_read(input chandle handle);                  // socket read
