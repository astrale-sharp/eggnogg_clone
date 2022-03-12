extends State

func _enter_state():
	pass

func _step(delta):
#	owner.animator.stop()
	owner.animator.play("idle")	
	owner.handle_direction(delta)
	owner.handle_arm(delta)
	owner.move_and_slide()
	if owner.animator.current_animation != "idle":
#	if owner.animator.is_playing() and owner.animator.current_animation != "idle":
		print("stop")
		owner.animator.stop()
			
	if not owner.is_on_floor():
		return "falling"

	if not owner.motion_velocity.is_equal_approx(Vector2.ZERO):
		return "running"
	
	if Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_jump"):
		return "crouch"

	if Input.is_action_just_pressed("ui_jump"):
		return "jumping"
	
		
func _exit_state():
#	owner.animator.stop()
	pass
