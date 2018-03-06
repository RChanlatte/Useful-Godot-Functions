### You can get more information about kinematic bodies and movement with Godot's 3.0 documentation:
### http://docs.godotengine.org/en/3.0/tutorials/physics/physics_introduction.html?highlight=move_and_collide

# in order for movement to work you need your script attached to a kinematic
# body. It will also need a collision box.
extends KinematicBody2D

# constants should always be fully capitalized
const ACCELERATION = 1000
const DECELERATION = 1000
const MIN_SPEED = 0
const MAX_SPEED = 500

export var speed = 1.0

# we have an array here to determine the direction the player is moving. With
# this we can determine when to apply deceleration due to a direction shift.
#
# [0] is the previous direction
# [1] is the current direction
var direction_buffer = [1,1]

var velocity = Vector2()

# we don't need to initialize anything with our simple character movement, so
# this function will remain empty. "pass" is necessary here and it simply tells
# the parser to ignore this bit of code.
func _ready():
	pass

# "_input(event)" is a special function that is always looking for input
func _input(event):
	
	# you can place button presses inside variables for cleaner code
	var move_left = event.is_action_pressed("ui_left")
	var move_right = event.is_action_pressed("ui_right")
	
	# you can even place logic relating to the button presses for super clean code
	var not_moving = not (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"))
	
	# movement logic
	if(move_right):
		print("The 'right' button is pressed!")
		direction_buffer[1] = 1
		
	elif(move_left):
		print("The 'left' button is pressed!")
		direction_buffer[1] = -1
		
	elif(not_moving):
		direction_buffer[1] = 0
	
	# this will have you decelerate or accelerate depending when you switch
	# between the left and right keys
	if((move_left or move_right) and (direction_buffer[1] !=0)):
		
		# if the previous direction [0] != the current direction [1], then the deceleration is applied
		if(direction_buffer[0] != direction_buffer[1]):
			speed /= 3
	
# "_process(delta)" is run every frame and "delta" is the time since the last frame
func _process(delta):
	
	# we put the previous direction equal to the current direction so we can keep
	# everything updated.
	direction_buffer[0] = direction_buffer[1]
	
	# since the key press determines the direction, this checks if we have any direction
	# at all and, if we do, then we accelerate, else we decelerate for a smooth stop.
	if(direction_buffer[1] != 0):
		speed += ACCELERATION * delta
	else:
		speed -= DECELERATION * delta

	# "clamp(value, min, max)" is a function that will force whatever value you
	# pass into it to conform to the interval [min, max], inclusive.
	speed = clamp(speed, MIN_SPEED, MAX_SPEED)
	
	# calculating the velocity
	velocity = speed * delta * direction_buffer[1]
	
	# of note, here is that "move_and_collide()" already has the delta timestep
	# built into it so we don't have to multiply anything by delta. Furthermore,
	# this function RETURNS a kinematic body object with information about collisions.
	# In such a simple demo we have no collisions, but if we did this info would
	# be useful for the engine to have.
	move_and_collide(Vector2(velocity, 0))
	
	# prints our current position
	print(self.get_transform())