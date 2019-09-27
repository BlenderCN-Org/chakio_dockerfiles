#!/usr/bin/env python

import pyaudio
import wave
import numpy as np
from datetime import datetime

import fcntl
import termios, sys, os
import time, sys
import sys

import time

import csv

import pandas as pd

chunk = 1024
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 44100
RECORD_SECONDS = 2

threshold = 0.01

p = pyaudio.PyAudio()

stream = p.open(format = FORMAT,
    channels = CHANNELS,
    rate = RATE,
    input = True,
    frames_per_buffer = chunk
)

df = pd.DataFrame({
        'dist'  : [0.5, 0.8, 1.1, 1.4, 1.7, 2.0, 2.3, 2.6, 2.9, 3.2, 3.5, 3.8, 4.1, 4.4, 4.7, 5.0],
        '01'     : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        '02'     : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        '03'     : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        '04'     : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        '05'     : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        '06'     : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        '07'     : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        '08'     : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        '09'     : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        '10'    : [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    })

cnt     = 0
MAX_VOL = 10000
start   = False
check   = True

targetDist  = 0
targetTry   = 0

def getkey():
    fno = sys.stdin.fileno()

    attr_old = termios.tcgetattr(fno)

    attr = termios.tcgetattr(fno)
    attr[3] = attr[3] & ~termios.ECHO & ~termios.ICANON # & ~termios.ISIG
    termios.tcsetattr(fno, termios.TCSADRAIN, attr)

    fcntl_old = fcntl.fcntl(fno, fcntl.F_GETFL)
    fcntl.fcntl(fno, fcntl.F_SETFL, fcntl_old | os.O_NONBLOCK)

    chr = 0

    try:
        c = sys.stdin.read(1)
        if len(c):
            while len(c):
                chr = (chr << 8) + ord(c)
                c = sys.stdin.read(1)

    except:
        pass

    finally:

        fcntl.fcntl(fno, fcntl.F_SETFL, fcntl_old)
        termios.tcsetattr(fno, termios.TCSANOW, attr_old)

    return chr

def getVolume():
    data = stream.read(chunk)
    x = np.frombuffer(data, dtype="int16") 

    return x.max()

def updateTarget():
    global targetTry
    global targetDist
    targetTry += 1
    if targetTry == len(df.columns)-1:
        targetTry   = 0
        targetDist += 1
        if targetDist == len(df):
            print "all pattern complete"
            print "please pless R"
while True:
    ##distance from HSR to speacker is 50cm 
    key= getkey()
    if key==10:
        print len(df.columns)-1
        distance    = float(df.iat[targetDist,len(df.columns)-1])
        tryNum      =df.columns[targetTry]
        print "\n"
        print "please set"
        print "Distance:"+str(distance)
        print "Try:"+str(tryNum)
        print "ok? press Y or N"
        print "\n"
        while True:
            key= getkey()
            #print key
            if key == 121:
                start       = True
                starttime   = time.time()
                soundVol    = 0
                soundNum    = 0
                check       = False
                print ""
                print "Get Volume Start"
                print "\n"
                break
            elif key == 110:
                print "Escape"
                print "\n"
                break
            
    elif key==99:
        check = True
    elif key==114:
        print "Write data? press Y or N"
        print "\n"
        while True:
            key= getkey()
            #print key
            if key == 121:
                df.to_csv('voice_potential.csv')
                print ""
                print "Wrote data"
                print "\n"
                break
            elif key == 110:
                print "Escape"
                print "\n"
                break
        
    elif key==101:
        break
    #print key

    # getVolume
    vol = getVolume()

    if check: 
        if float(vol)>MAX_VOL:
            print True
        else :
            print False
            print vol

    if start:
        #targetDist
        #targetTry
        #print df
        #print "dist="+str(df.at['dist'])
        #print "time="+str(float(time.time() - starttime))
        if float(time.time() - starttime) <5:
            soundVol += vol
            soundNum += 1
            print vol
        else:
            soundVol /= soundNum
            print "result="+str(soundVol)
            start = False
            print "Save?? please press Y or N"
            while True:
                key= getkey()
                if key == 121:
                    df.iat[targetDist,targetTry] = soundVol
                    print df
                    updateTarget()  
                    break
                elif key == 110:
                    print "Not Saved"
                    break
            
    

stream.close()
p.terminate()