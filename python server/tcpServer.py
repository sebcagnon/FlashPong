#!/usr/bin/env python

import socket

TCP_IP = '127.0.0.1'
TCP_PORT = 5005
BUFFER_SIZE = 20  # Normally 1024, but we want fast response

class Party:
    def __init__(self, partyID):
        self.id = partyID
        self.objects = {'Left':[0,0], 'Right':[0,0], 'Ball':[0,0]}
        self.isStarted = False
        self.score = [0,0]
        
    def updatePosition(self, object, newPosition):
        if object in self.objects.keys():
            self.objects[object] = newPosition
            
    def getPositions(self, objectList):
        response = ''
        for object in objectList:
            if object in self.objects:
                response += str(object) + ':'+ str(self.objects[object]).strip('[]') + '\t'
        return response

    
def main():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind((TCP_IP, TCP_PORT))
    s.listen(1)
    s.settimeout(1)
    print "Socket ready, waiting for connections"
    try:
        while 1:
            try:
                conn, addr = s.accept()
                print 'Connection address:', addr
                data = conn.recv(BUFFER_SIZE)
                if not data: break
                print "received data:", data
                if data.startswith('create'):
                   party = Party(1)
                   conn.send(party.getPositions(['Left', 'Right', 'Ball']))
                conn.close()
            except socket.timeout, e:
                pass
    except KeyboardInterrupt, e:
        s.close()
        print "Socket closed, Bye Bye!"

if __name__=='__main__':
    main()