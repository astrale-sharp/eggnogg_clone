extends State

func _enter_state():
#	print("jumping")
	owner.motion_velocity.y = owner.JUMP_FORCE * Vector2.UP.y

func _step(delta):
	return "falling"
	
func _exit_state():
	pass
