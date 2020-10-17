#!/usr/bin/python

import sys
import glob
import serial
import serial.tools.list_ports
from time import sleep
import sys, getopt
import datetime
from GS_Timing import millis, delay
from libSimCom import SimCom

# pip install pyserial
# on windows, c:\Python27\Scripts\pip.exe

################################################################################

class ArduinoSer:

	deviceport = None  # the serial port we're connected to
	comport = None     # the opened device handle
	unreadCharacter = None # for our read/unread
	baudrate = 4800

	def __init__( self, verbose = False ):
		self.verbose = verbose
		self.comport = None
		self.deviceport = None
		self.debug = False

	def GetPortName( self ):
		if self.deviceport is None:
			return "(none)"
		else:
			return self.deviceport.device

	def GetPortDescription( self ):
		if self.deviceport is None:
			return "(none)"
		else:
			return self.deviceport.description


################################################################################
# port discovery

	def couldBeArduino( self, trycomport ):
		possibilities = ['Arduino', 'CH340', 'CH341', 'wchusb', 'usbmodem' ]
		for needle in possibilities:
			if needle in trycomport.description:
				return True
			if needle in trycomport.device:
				return True
		# nope
		return False


	def detectArduinoPort( self, usrsearch ):
		theArduino = None

		ports = list(serial.tools.list_ports.comports())

		for tryComPort in ports:
			if usrsearch is None:
				# only check the builtins
				if self.couldBeArduino( tryComPort ):
					#print "Arduino on " + p.device
					theArduino = tryComPort
			else:
				# only check the usrsearch
				if usrsearch in tryComPort.description:
					#print "Requested port found on " + p.device
					theArduino = tryComPort
				if usrsearch in tryComPort.device:
					#print "Requested port found on " + p.device
					theArduino = tryComPort
		return theArduino


	def listSerialPorts( self ):
		print ""
		print "Serial ports: " 
		#print serial_ports()
		print ""
		ports = list(serial.tools.list_ports.comports())
		if len( ports ) == 0:
			print "   No ports found."
			return

		for p in ports:
			additional = ""
			if( self.couldBeArduino( p )):
				additional = " (detected as Arduino)"
			print "   " + p.device + " -- " + p.description + additional

################################################################################
# utility

	def vprint( self, text ):
		if self.verbose and not text is None:
			print text

			

################################################################################
# serial port layer

	def isConnected( self ):
		if self.comport is None:
			return False
		return True


	def closeConnection( self ):
		if self.isConnected():
			self.comport.close()
		self.comport = None
		self.deviceport = None
		self.unreadCharacter = None


	def openConnection( self, searchTerm = None ):
		if not self.isConnected():
			self.closeConnection()

		if searchTerm == "SIM":
			print "Starting simulation"
			self.comport = SimCom()
			#serial.Serial( self.deviceport.device, 115200, timeout=10 )

		else:
			self.deviceport = self.detectArduinoPort( searchTerm )

			if self.deviceport is None:
				return

			self.vprint( "Serial port: " + self.deviceport.device )

			try:
				self.comport = serial.Serial( self.deviceport.device, self.baudrate, timeout=10 )
			except:
				print "ERROR: Unable to open serial port!"
				self.comport = None
				return

		self.comport.close()
		self.comport.open()

		self.flush()

		return

		# Figure out if we need to add a delay for 328p/168 chips
		addDelay = True
		if "Leonardo" in self.GetPortName():
			addDelay = False
		if "Leonardo" in self.GetPortDescription():
			addDelay = False
			
		if addDelay is True:
			print "Non-Leonardo delay.",
			sys.stdout.flush()
			for a in range( 0,5 ):
				delay( 500 )
				print ".",
				sys.stdout.flush()
			print

		# print out some connection info
		widgetVersion = self.getVersion()
		self.vprint( "Connected to version {:04x}".format( widgetVersion ))
		siga = self.configRead( 0 )
		sigb = self.configRead( 1 )
		self.vprint( "  Signature: {:02x} {:02x}".format( siga, sigb ))

	def flush( self ):
		self.unreadCharacter = None
		# need to revisit this...
		if self.comport == None:
			return
		self.comport.flush()
		delay( 4 )
		self.comport.flushInput()
		self.comport.flushOutput()
		delay( 4 )
		# if using 3.0 of pyserial:
		#self.comport.reset_input_buffer()
		#self.comport.reset_output_buffer()


	def send( self, text ):
		if not self.isConnected():
			return
		self.comport.write( text )
		#self.vprint( "Sending: |" + text + "|" )

	def sendln( self, text ):
		self.send( text )
		self.send( "\n" )

	def sendList( self, list ):
		sendstr = ','.join( str(item) for item in list )
		self.sendln( sendstr )

	########################################	

	def blocking_read( self ):
		while( self.comport.inWaiting() == 0 ):
			pass # do nothing
		return self.comport.read( 1 )

	def our_read( self ):
		if not self.unreadCharacter == None:
			ch = self.unreadCharacter
			self.unreadCharacter = None
			return ch

		if not self.isConnected():
			return ''

		if( self.comport.inWaiting() == 0 ):
			return ''

		return self.comport.read( 1 )

	def our_unread( self, ch ):
		self.unreadCharacter = ch

	def our_consumeNewlines( self ):
		while True:
			# read a character until it's not a newline
			# then unread it.
			ch = self.our_read()
			if ch != '\n' and ch != '\r':
				self.our_unread( ch )
				break

	# read a line of content from the serial port
	# returns the line, without 
	def readln( self ):
		if not self.isConnected():
				return "0!"

		if( self.comport.inWaiting() == 0 ):
			return "0";

		linetxt = ""
		while True:
			c = self.our_read()
			if( self.debug ):
				print "READ {}".format( c )

			if (c == '\n') or (c == '\r'):
				self.our_consumeNewlines()
				break

			linetxt += c

		return linetxt


################################################################################
# Utility

######################################## 
# Pin IO pattern stuff
	def retvalToInt( self, retval ):
		retint = 0
		try:
			retval = retval[1:]		# "0x0001"
			retint = int( retval, 16 )
		except:
			return 0xFFFF
			pass
		return retint
