### THIS IS THE CHILD SCRIPT ###

# Need the EXACT path to the script you are inheriting AND it must be contained
# in quotes!
#
# A SUPER easy way to do this is by right-clicker the script name in the editor
# and selecting the option "Copy Script Path" from the drop down menu. From there,
# you simply paste it inside the quotation marks and you're good to go!
extends "res://character.gd"

# our exported text. this way you can edit it to anything you could want
export var testTxt = ""

# will be run once when the node this script is attached too is spawned
func _ready():
	
	# running our inherited function with our text
	HelloWorld_Inherited(testTxt)
	
	pass
	