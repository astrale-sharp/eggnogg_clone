extends State

func _enter_state():
#	print("jumping")
	owner.motion_velocity = owner.JUMP_FORCE * Vector2.UP

func _step(delta):
	return "falling"
	
func _exit_state():
	pass
