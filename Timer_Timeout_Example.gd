# Documentation on the Timer:
# http://docs.godotengine.org/en/3.0/classes/class_timer.html?highlight=timer#enum-timer-timerprocessmode

# global "timer" variable set to null. Must be global if you wish to reference
# at arbitrary scope
var timer = null

# a float variable for the duration of the timer
# "export" puts the duration inside the scene inspector to be modified without
# going into the code
export var duration = 1.0

# test function to execute after the timer has finished
func print_test():
	print("The timer worked!")
	

# this function creates the timer. It does not execute it, simply creates a
# timeout timer, for whatever needs a cool down.
func create_timeout_timer(time_limit, method_name):
	
	# set our variable timer to a new timer
	timer = Timer.new()
	
	# "set_one_shot(true)" is the method that makes it a finite timer.
	# if set to false, the timer will restart after execution
	timer.set_one_shot(true)
	
	# sets the timer time too the value of our "time_limit" parameter
	timer.set_wait_time(time_limit)
	
	# timer.connect(timer type, where to execute, function to execute when timer runs out)
	timer.connect("timeout", self, method_name)
	
	# scripts need a node in the scene in order to be executed, so this function
	# adds a child node to our root scene tree so the timer can be executed when 
	# necessary
	add_child(timer)
	
	
# example execution
func _ready():

	# this initializes the timer
	create_timeout_timer(duration, "print_test")

	# starts the timer. when the time given for "duration" has elapsed,
	# our message should be printed
	timer.start()