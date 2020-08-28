#!/usr/bin/python

import sys
import glob


################################################################################
# Fake Comport + Arduino simulation
class SimCom:
	SimDevice = "/fake/SIMUDUINO"

	device = SimDevice
	description = "Arduino Serial Simulation"
	isConnected = False
	accumulator = ""

	def __init__( self ):
		self.device = self.SimDevice
		self.description = "Arduino Serial Simulation"
		self.flush()
		print "Serial simulation mode active."


	####################
	# fake port interface stuff

	def close( self ):
		self.isConnected = False
	
	def open ( self ):
		self.isConnected = True

	def flush ( self ):
		self.accumulator = ""
		return

	def flushInput ( self ):
		self.flush()
		return

	def flushOutput ( self ):
		self.flush()
		return


	####################
	# stashed data for return values

	stashedLine = "\n"

	def stash( self, val ):
		self.stashedLine = val

	####################

	def handleLine( self ):
		args = self.accumulator.strip().split( "," )
		cmd = args[0]

		##############################	
		print args

		##############################	

		##############################	

		print "{}: unknown option".format( cmd )
		return


	####################
	# handle writes to us

	def write ( self, txt ):
		#sys.stdout.write( "SER WR:|" )
		#sys.stdout.write( self.cleanText( txt ))
		#sys.stdout.write( "|" )
		#sys.stdout.flush()
		# we're going to assume the newline is the end of a string.
		self.accumulator = self.accumulator + txt
		if( '\n' in self.accumulator or '\r' in self.accumulator ):
			self.handleLine()
			self.accumulator = ""
		return


	####################
	# handle reads from us

	def readLine( self ):
		# do something based on "txt"
		return self.stashedLine

	def read( self, count ):
		retval = '\n'

		if ( len( self.stashedLine ) == 0):
			return '\n'

		try:
			retval = self.stashedLine[0]
			self.stashedLine = self.stashedLine[1:]
		except:
			pass
	   	
		return retval
