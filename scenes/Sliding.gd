extends State

func _enter_state():
	owner._set_arm_rotation_at_0()
	owner.animator.play("sliding")	
	
func _step(delta):
	owner.motion_velocity.x *= 0.995
	owner.facing_right = owner.motion_velocity.x >= 0
	owner.move_and_slide()
	
	if owner.motion_velocity.is_equal_approx(Vector2.ZERO):
		owner.animator.stop(true)
	else:
		owner.animator.play()
	
	
	if not owner.is_on_floor():
		return "falling"

	if not Input.is_action_pressed("ui_jump"):
		return "idle"
	
	
func _exit_state():
#	owner.animator.stop()
	pass

