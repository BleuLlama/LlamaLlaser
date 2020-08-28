#!/usr/local/bin/python
################################################################################
#	
#	LD.py
#
################################################################################
#
#	v001 2020-08-21 SDL initial version

################################################################################
# you may need to install pyserial:
# 	sudo pip install pyserial
# 	on windows, c:\Python27\Scripts\pip.exe install pyserial
################################################################################

################################################################################
# importing libraries...

# general app stuff
import os
import sys
sys.dont_write_bytecode = True
sys.path.append( 'libs' )
import getopt

# app stuff
from libAppCore import AppCore

# connection
from libArduinoSer import ArduinoSer
from GS_Timing import delay,micros,millis


class LDP():

	def __init__( self, theSerial ):
		self.theSerial = theSerial

	# send a command, get a response
	def Command( self, txt ):
		self.theSerial.send( txt )
		self.theSerial.send( "\r" )

		#print "CMD TX: {}".format( txt )

		acc = ""
		ch = self.theSerial.blocking_read()
		while( ch != '\r' ):
			acc += ch
			ch = self.theSerial.blocking_read()

		#print "    RX: {}".format( acc )
		return acc


	def Play( self ):
		self.Command( 'PL' );


	def OSD( self, line, text ='' ):
		self.Command( str(line) + "PR" );
		self.Command( text );

		print "{}: {}".format( line, text )

	def DBG( self, text = '' ):
		self.OSD( 2, text )


	def ConfigureScreen( self ):
		self.Command( '0DS' )	# turn off on screen text
		self.Command( '0RB' )	# normal squelches
		self.Command( 'CS' ) 	# clear screen

		self.Command( '1DS' )	# turn on on-screen text
		self.Command( '5RA' )	# user text + frame number

		#self.OSD( 1, 'DEBUG' );


	def SpinUp( self ):
		self.DBG( 'spin up' )
		self.Command( 'PL' ) 	# spin up the disk, play

	def StepReverse( self ):
		self.Command( 'SR' )	# go back one frame

	def StepForward( self ):
		self.Command( 'SF' )	# go forward one frame

	def Stop( self ):
		self.DBG( 'Stop' )
		self.Command( 'RJ' )	# reject (stop / eject)
		self.Command( 'CO' )	# close the tray

	def Seek( self, frm ):
		self.DBG( 'Seek ' +str( frm ))
		self.Command( 'FR' + str( frm ) + 'SE' )
	
	def CountFrames( self ):
		self.Command( "FRLOSE" ); # seek to lead out
		return int( self.Command( "?F" ))

################################################################################
# main command line interface routines

class LDDumperApp( AppCore ):

	def usage( self ):
		print "App.py <options>"
		print "  -a TXT   attach to port with 'TXT' matching"
		print "  -a SIM   for the simulated serial device"
		print "  -l       list detected serial ports"


	# application specific stuffs

	def appInit( self ):
		print "Init app."
		self.arduinotext = "usbserial"
		#self.configFileName = "config.json";

		self.theSerial = False 
		#self.lastCode = 0
		#self.lastCodeStartTime = 0


	def appOptions( self ):

		try:
			opts, args = getopt.getopt(self.argv,"hla:",["arduino="])

		except getopt.GetoptError:
			self.usage()
			sys.exit(2)

		for opt, arg in opts:
			if opt == '-l':
				self.theSerial.listSerialPorts()
				return

			elif opt == '-a':
				self.arduinotext = arg

			elif opt in ("-a", "--arduino"):
				self.arduinotext = arg

			else:
				self.usage()
				sys.exit()


	def openAndInitSerial( self ):
		print "Serial Init"
		self.theSerial = ArduinoSer( True )
		self.theSerial.openConnection( self.arduinotext )

		if not self.theSerial.isConnected():
			print " ===================="
			print "  Arduino not found!"
			print " ===================="
			return
		
		s = self.theSerial


	def runRaw( self, theCmd ):
		stream = os.popen( theCmd )
		output = stream.read()
		return output.rstrip()

	def runScpt( self, scpt ):
		# run the requested command
		scptCommand = 'osascript -e "{}"'
		return self.runRaw( scptCommand.format( scpt ))

	def runCmds( self, cmdline ):
		self.cmdDir = "../cmds/"
		return self.runRaw( "{}{}".format( self.cmdDir, cmdline ))


	def fnFromIdx( self, idx ):
		return 'tmp/{:05d}.jpg'.format( idx )

	def capture( self, idx ):
		filename = self.fnFromIdx( idx )
		self.runRaw( 'imagesnap {}'.format( filename ))
		print "Image captured to {}".format( filename )

	def frameExists( self, idx ):
		filename = self.fnFromIdx( idx )
		if os.path.exists( filename ): 
			return True
		return False

	def handleResponse( self, response ):

		print "R: {}".format( response )


	def appRun( self ):

		print "Connecting to LDP"
		self.openAndInitSerial()

		if not self.theSerial.isConnected():
			quit()

		print "Configuring LDP..."
		self.ldp = LDP( self.theSerial )

		#response = self.ldp.Command( 'F?' );
		self.ldp.ConfigureScreen()
		self.ldp.SpinUp()

		
		nFrames = self.ldp.CountFrames();
		print "Disc has {} Frames.".format( nFrames );

		# DiscoVision disks show their startup animation all
		# on frame 0.  so the last frame 0 before frame 1 is
		# the real frame 0.
		# so, seek to frame 1, then go back one.
		self.ldp.Seek( 1 )
		self.ldp.StepReverse()
		self.ldp.DBG()

		for fr in range( 0, nFrames ):
			if not self.frameExists( fr ):
				self.capture( fr )
			self.ldp.StepForward()

		print "Shutting down..."
		self.ldp.Stop()
		self.ldp.DBG()
		self.theSerial.closeConnection()


if __name__ == "__main__":
		deckApp = LDDumperApp()
		deckApp.main(sys.argv[1:])
