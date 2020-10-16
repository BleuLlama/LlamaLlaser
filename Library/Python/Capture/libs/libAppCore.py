#!/usr/bin/python
################################################################################
#	
#	AppCore.py
#
################################################################################
#
#	v001 2020-06-11 SDL initial version

################################################################################
# you may need to install pyserial:
# 	sudo pip install pyserial
# 	on windows, c:\Python27\Scripts\pip.exe install pyserial
################################################################################

################################################################################
# importing libraries...

# general app stuff
import sys
sys.dont_write_bytecode = True
sys.path.append( 'libs' )
import getopt
import json

# connection
from libArduinoSer import ArduinoSer
from GS_Timing import delay,micros,millis


################################################################################
# signal stuff

import signal

def signal_handler( signal, frame ):
	print( "BREAK." )
	sys.exit( 0 )


# and immediately install it on including this library
signal.signal( signal.SIGINT, signal_handler )
#signal.pause()




################################################################################
# main command line interface routines

class AppCore:

	# utility

	def rangeAdapt( self, a, amin, amax,  bmin, bmax ):
		ARange = (amax - amin)  
		BRange = (bmax - bmin)  
		newValue = (((a - amin) * BRange) / ARange) + bmin

		return newValue

	def rangeAdaptInv( self, a, amin, amax, bmin, bmax ):
		newValue = self.rangeAdapt( a, amin, amax, bmin, bmax )
		b = newValue - bmin
		return bmax - b

	def readJsonFile( self, filename ):
		with open( filename ) as json_file:
			data = json.load( json_file )
			return data
		return false

	def writeNewJsonFile( self, filename, data ):
		with open(filename, 'w') as outfile:
			json.dump(data, outfile)


	# Level 2 utilities

	def appLoadConfig( self ):
		self.config = self.readJsonFile( "config.json" );
		print( "Config:" );
		#print( self.config );
		print json.dumps( self.config, sort_keys=True, indent=4, separators=(',', ': ') )



	# override these!

	def appInit( self ):
		print "Init app."
		self.configFileName = "config.json";

	def appOptions( self ):
		print "App Options"

	def appRun( self ):
		print "Do stuff"

	# main framework wrapper

	def main( self, argv ):
		self.argv = argv
		
		self.appInit()
		self.appOptions()
		self.appLoadConfig()
		self.appRun()
#
#if __name__ == "__main__":
#		deck = TapeDeckApp()
#		deck.main(sys.argv[1:])
