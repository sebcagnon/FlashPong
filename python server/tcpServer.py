#!/usr/bin/env python

import socket
import json

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
      self.status = 'waiting'
      self.side = None
      
    def getSide(self):
      return self.side
    
    def getID(self):
      return self.id
      
class Server:
    def __init__(self, IP, PORT):
        self.tcp_ip = IP
        self.tcp_port = PORT
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.bind((self.tcp_ip, self.tcp_port))
        self.sock.listen(1)
        self.sock.settimeout(1)
        self.nextUserID = 0
        self.nextPartyID = 0
        self.waitingUsers = []
        self.parties = {}
      
    def mainLoop(self):
        try:
            while 1:
                try:
                    data = None
                    
                    conn, addr = self.sock.accept()
                    while not data:
                      print 'Connection address:', addr
                      try:
                        data = conn.recv(BUFFER_SIZE)
                      except:
                        print "no data"
                        data = None
                      if not data: continue
                    print "received data:", data
                    retMsg = self.parseData(data)
                    conn.send(retMsg)
                    conn.close()
                except socket.timeout, e:
                    pass
        except KeyboardInterrupt:
            self.sock.close()
            print "socket closed"
            
    def parseData(self, jsonData):
        msgDict = json.loads(jsonData)
        # New User
        if msgDict['ID'] == None:
            self.waitingUsers.append(User(self.nextUserID))
            userID = self.nextUserID
            self.nextUserID += 1
            if len(self.waitingUsers) >= 2:
                newPartyID = self.nextPartyID
                self.parties[self.nextPartyID] = Party(self.nextPartyID, self.waitingUsers[0], self.waitingUsers[1])
                self.nextPartyID += 1
                return self.parties[newPartyID].getState(userID)
            else:
                return json.dumps({'ID':userID, 'status':'waiting'})
        # Waiting for Party
        elif not msgDict.get('partyID', None):
            id = msgDict['ID']
            # 1- check if in waiting list
            for user in self.waitingUsers:
                if user.getID() == id:
                    return json.dumps({'ID':id, 'status':'waiting'})
            # 2- check in which party it was added
            for party in self.parties.values():
                if id in party.getUserIDs():
                    return party.getState(id)
        # Already in a party
        else:
            userID = msgDict['ID']
            partyID = msgDict['partyID']
            return self.parties[partyID].update(msgDict)
    
def main():
    server = Server(TCP_IP, TCP_PORT)
    server.mainLoop()

if __name__=='__main__':
    main()