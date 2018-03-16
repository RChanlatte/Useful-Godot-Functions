extends Position2D

# zero out mouse position
var mouse_pos = Vector2(0,0)
var icon_size = Vector2(0,0)
const MAX_PARTICLE_AMT = 10
var particle_count = 0
var particle_scene = load("res://Scenes/click_p1_particle.tscn")

# These are the holy functions of instancing in GODOT. They ought to be treated
# like dynamic memory is treated in low level languages like C/C++. They WILL
# cause memory leaks if not terminated after use, so be extremely careful
# with each instance and remember to terminate them after their use has run
# their course... Now here is how to utilize them: 
#
# var enemy1 = enemyscene.instance()
# get_parent().add_child(enemy1)
# self.free() / self.queue_free() / remove_child(self) OR get_parent().remove_child(self)
#
# Explanation:
# 1.) initialize a variable to hold your instanced scene
#		you need to instance the scene before it can spawn children
# 2.) get the parent node you wish to house your instanced child
# 3.) delete/terminate the instanced node after use.
#		a.) self.free() literally REMOVES the node from the root scene, like, INSTANTLY
#		b.) self.queue_free() removes the node AFTER all processing it has is completed
#		c.) remove_child(self) and its more verbose cousin simply reparent to the root node.
#			this does not actually delete the node, but simply move it.

# GODOT gets the position of the icon, on its bottom-right.
# this function changes the mouse position, relative to the 
# computer's icon so it ends up at the very tip of the cursor
func icon_mouse_pos(icon_sz, raw_mouse_pos):
	var new_mouse_pos = Vector2(0,0)
	new_mouse_pos = raw_mouse_pos
	new_mouse_pos.x -= icon_sz.x
	new_mouse_pos.y -= icon_sz.y
	return new_mouse_pos

func emit_on_mPress():
	var particle_effect = particle_scene.instance()
	
	if(particle_count <= MAX_PARTICLE_AMT):
		print("Particle was added.")
		add_child(particle_effect)
		particle_count += 1
		print("#####DEBUG##### PARTICLE ADDED:= Current particle count: " + str(particle_count))
	else:
		particle_count -= 1
		print("#####DEBUG##### PARTICLE REMOVED:= Current particle count: " + str(particle_count))

func _input(event):
	
	# store mouse pressed event
	var mouse_left_button_pressed = event.is_action_pressed("mouse_left_button")
	
	# if it is pressed change the position of the node
	if(mouse_left_button_pressed):
		mouse_pos = icon_mouse_pos( icon_size, (event.position) )
		set_position(mouse_pos)
		print(mouse_pos)
		emit_on_mPress()
		return
