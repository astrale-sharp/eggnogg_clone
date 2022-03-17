extends State

func _enter_state():
	pass

func _step(delta):
	owner.handle_direction(delta)
	owner.handle_arm(delta)
	owner.move_and_slide()
	
#	if not owner.animator.is_playing():
			
	if not owner.is_on_floor():
		return "falling"

	if owner.motion_velocity.is_equal_approx(Vector2.ZERO):
		owner.animator.stop()
		owner.animator.play("idle")
		return "idle"

	if Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_jump"):
		return "sliding"

	if Input.is_action_just_pressed("ui_jump"):
		return "jumping"
	
	owner.animator.play("running")
	
func _exit_state():
#	owner.animator.stop()
	pass
