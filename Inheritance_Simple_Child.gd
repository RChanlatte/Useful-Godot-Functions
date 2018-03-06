### THIS IS THE CHILD SCRIPT ###

# need the EXACT path to the script you are inheriting AND it must be contained
# in quotes! This is in case there are any spaces in the filename!
extends "res://character.gd"

# our exported text. this way you can edit it too anything you could want
export var testTxt = ""

# will be run once when the node this script is attached too is spawned
func _ready():
	
	# running our inherited function with our text
	HelloWorld_Inherited(testTxt)
	
	pass
	