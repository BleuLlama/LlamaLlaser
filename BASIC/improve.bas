Some things to change from 0.15 (2018 Maker Faire version)

Note that even though this lists commands withing the text of the 
document, the scene commands do have to be quoted in DATA statements.
eg:

	FR200SE
	FR333PL

is really:
	1000 DATA "FR200SE", "FR333PL"
	

- It's super cumbersome to use Multi-speed forward/reverse to a frame.
	Currently, we need to do: (for half-speed playback from frame 200
	to frame 333)

	FR200SE			seek to 200
	FR333SM			put a stop marker at frame 333
	30SP			1/2 speed setting			
	MF				multispeed forward - MR is multispeed reverse
	!FR 333			Internal command to poll ?F frame number, and
					stop when frame 333 is reached

	One possible improvement is to roll all of that into a new command,
	to handle stop marker, mf/mr, as well as frame count polling like so:

	FR200SE			seek to 200
	!MF 30 333		Multispeed forward, 30-speed, to frame 333

- Another thign that might be useful is a universal ?F checker.
	- poll ?F until the frame number hasn't changed for N seconds
	- this would eliminate exact frame polling. so any SM stop
		marker should work. eg:

	FR200SE			seek to 200
	FR333SM			put a stop marker at frame 333
	240SP			play at 3x speed
	MF				multispeed forward
	!F-NC			wait for frame "no change"

- With the current system, there is an alternating series of scenes:
	Scene 1: wait for user input
	Scene 2: movement as we transition to scene 3
	Scene 3: wait for user input
		etc

	The problem with this is that if we want to return to scene 3 from
	another angle, the LD needs to seek to that location.  Ie, we move
	"left" to the solar system video, at the end of it, we can't just 
	!SC back to scene 3, we have to FRxxxxSE, !SC 3 since the scene
	setting for scene 3 is actually in the tail end of scene 2.

	FRxxxSE will squelch and look for the frame EVEN IF IT IS ALREADY
	ON THE FRAME.

	- a Seek command needs to be created.  ie:

		!SE 200

	- This will first query for the current frame ?F and if it's 
	already there, it does nothing.  However, if it is not there,
	then it will issue the FR200SE command and THEN return.
	
	- This should simplify playback as well, as every scene can 
	start with a SEEK to the frame it should be starting on without
	issues

- Input buffer should be flushed before polling for user input!!!!!
	- people like to press buttons a lot, and it can cue up tens of
	presses while it's playing a scene.  This should be a pretty easy
	fix.
	- in the !Key command, the first thing it should do is:

		100 REM clear the inkey buffer
		110 K$ = INKEY$ : IF NOT K$ = '' THEN 110
		120 REM buffer is cleared.
	
		

