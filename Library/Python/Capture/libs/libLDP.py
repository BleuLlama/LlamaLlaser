#!/usr/local/bin/python
################################################################################
#	
#	libLDP.py
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

# connection
from libArduinoSer import ArduinoSer
from GS_Timing import delay,micros,millis


class LDP():

	def __init__( self, theSerial ):
		self.debugLine = 9
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
		self.Command( 'PL' )


	def Speed( self, value ):
		# 180 = 3x
		# 120 = 2x
		# 60  = 1x
		self.Command( '{}SP'.format( value ))

	def OSD( self, line, text ='' ):
		self.Command( str(line) + "PR" );
		self.Command( text );

		print "{}: {}".format( line, text )

	def DBG( self, text = '' ):
		self.OSD( self.debugLine, text )

	def VideoSwitch( self, which ):
		if which == 'toggle':
			self.OSD( 1, 'XRV' )
			return

		if which == 'ldp':
			self.OSD( 1, '1RV' )
			return
		
		self.OSD( 1, '0RV' )


	def ConfigureScreen( self ):
		self.Command( '0DS' )	# turn off on screen text
		self.Command( '0RB' )	# normal squelches
		self.Command( 'CS' ) 	# clear screen

		self.Command( '1DS' )	# turn on on-screen text
		self.Command( '5RA' )	# user text + frame number

		#self.OSD( 1, 'DEBUG' );

	def Squelch( self, isOn ):
		if( isOn ):
			self.Command( '0RB' )
		else :
			self.Command( '192RB' )


	def SpinUp( self ):
		self.DBG( 'spin up' )
		self.Command( 'PL' ) 	# spin up the disk, play

	def StepReverse( self ):
		self.DBG( 'Step Reverse' )
		self.Command( 'SR' )	# go back one frame

	def StepForward( self ):
		self.DBG( 'Step Forward' )
		self.Command( 'SF' )	# go forward one frame

	def SkimReverse( self ):
		self.DBG( 'Skim Reverse' )
		self.Command( 'NR' )	# go back a bunch of frames

	def SkimForward( self ):
		self.DBG( 'Skim Forward' )
		self.Command( 'NF' )	# go forward a bunch of frames

	def Stop( self ):
		self.DBG( 'Stop' )
		self.Command( 'RJ' )	# reject (stop / eject)
		self.Command( 'CO' )	# close the tray

	def Seek( self, frm ):
		self.DBG( 'Seek ' +str( frm ))
		self.Command( 'FR' + str( frm ) + 'SE' )
	
	def CountFrames( self ):
		self.DBG( 'Count Frames' )
		self.Command( "FRLOSE" ); # seek to lead out
		return int( self.Command( "?F" ))
