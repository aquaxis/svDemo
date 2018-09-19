#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/un.h>

typedef int SOCKET;
#define INVALID_SOCKET -1
#define SOCKET_ERROR   -1
#define closesocket(s) close(s);

#define BUFFER_SIZE 1024
struct handle {
    SOCKET sock;
};

struct handle* init_struct(SOCKET sock) {
    struct handle* h = malloc(sizeof(struct handle));
    if(h) {
        h->sock = sock;
    }
    return h;
}

void* socket_open(const char* name) {
    // Extract hostname / port
    char* string = strdup(name);
    if(!string) return NULL;
    char* colon = strchr(string, ':');
    if(!colon) {
        free(string);
        return NULL;
    }
    *colon = '\0'; // Split string into hostname and port
    const char* hostname = string;
    const char* port = colon + 1;

    int status;
    struct addrinfo hints, *res, *p;

    // Setup hints - we want TCP and dont care if its IPv6 or IPv4
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC; // AF_INET or AF_INET6 to force version
    hints.ai_socktype = SOCK_STREAM;

    // Look up the host
    if ((status = getaddrinfo(hostname, port, &hints, &res)) != 0) {
        free(string);
        return NULL;
    }
    free(string);

    // Try and connect
    SOCKET sock = INVALID_SOCKET;
    for(p = res; sock == INVALID_SOCKET && p != NULL; p = p->ai_next) {
        sock = socket(p->ai_family, p->ai_socktype, p->ai_protocol);
        if(sock != INVALID_SOCKET) {
            status = connect(sock, p->ai_addr, p->ai_addrlen);
            if(status == SOCKET_ERROR) {
                closesocket(sock);
                sock = INVALID_SOCKET;
            }
        }
    }
    freeaddrinfo(res); // free the linked list
    if( sock == INVALID_SOCKET ) {
        return NULL;
    }

    // Create handle
    return init_struct(sock);
}

void socket_close(void* handle) {
    if(!handle)
        return;
    
    struct handle* h = handle;
    closesocket(h->sock);
    free(h);
}

int socket_write(void* handle, const char* data) {
    if(!handle) return 0;
    size_t len = strlen(data);
    struct handle* h = handle;

    // Write
    int ret = 0;
    ret = send(h->sock, data, len, 0);

    return ret == -1 ? 0 : 1;
}

const char* socket_read(void* handle) {
    if(!handle) return 0;    
    struct handle* h = handle;
    char *data;

    data = malloc(BUFFER_SIZE);

    // Read
    int ret = 0;
    ret = recv(h->sock, data, BUFFER_SIZE, 0);
    data[ret] = '\0';

    return data;
}
