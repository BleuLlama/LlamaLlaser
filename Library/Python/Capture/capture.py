#!/usr/local/bin/python
################################################################################
#	
#	capture.py
#
################################################################################
#
#	v002 2020-10-10 SDL - Additional refinements
#	v001 2020-08-21 SDL - initial version

################################################################################
# you may need to install pyserial:
# 	sudo pip install pyserial
# 	on windows, c:\Python27\Scripts\pip.exe install pyserial
#
# and if you have old 2.7 with no pip:
#	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
################################################################################

# requires the command imagesnap which captures a frame of video
# from the firewire video source and saves it as a PNG
#
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
from libLDP import LDP
from GS_Timing import delay,micros,millis


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
		theApp = LDDumperApp()
		theApp.main(sys.argv[1:])
