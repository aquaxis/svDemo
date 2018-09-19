import socket
import sys

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

addr = ('localhost', 1234)
print 'starting up on %s port %s' % addr
sock.bind(addr)
sock.listen(1)

while True:
    print 'waiting for connection'
    connection, client_address = sock.accept()

    try:
        print 'connection from', client_address

        while True:
            data = connection.recv(1024)
            if data:
                print 'received "%s"' % data
                data = data.upper();
                print 'send upper string'
                connection.sendall(data)
            else:
                print 'no receive data'
                break
            
    finally:
        connection.close()
