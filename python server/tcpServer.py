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

class User:
    def __init__(self, ID):
      self.id = ID
      self.ballPos = [0.5, 0.5]
    
    def getID(self):
      return self.id
    
    def getBallPos(self):
      self.ballPos[0] = (self.ballPos[0] + 0.05) % 1
      return 'ball:' + ','.join(map(str, self.ballPos))
    
def main():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind((TCP_IP, TCP_PORT))
    s.listen(1)
    s.settimeout(1)
    users = []
    print "Socket ready, waiting for connections"
    try:
        while 1:
            try:
                data = None
                
                conn, addr = s.accept()
                while not data:
                  print 'Connection address:', addr
                  try:
                    data = conn.recv(BUFFER_SIZE)
                  except:
                    print "no data"
                    data = None
                  if not data: continue
                print "received data:", data
                if data.startswith('NEW_USER'):
                  users.append(User(len(users)))
                  conn.send('ID:'+str(users[-1].getID()))
                if data.startswith('update'):
                  lData = data.split(':')
                  id = int(lData[-1])
                  print "sending pos"
                  conn.send(users[id].getBallPos())
                conn.close()
            except socket.timeout, e:
                pass
    except KeyboardInterrupt, e:
        s.close()
        print "Socket closed, Bye Bye!"

if __name__=='__main__':
    main()