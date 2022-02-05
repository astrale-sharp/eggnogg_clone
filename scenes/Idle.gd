extends State

func _enter_state():
	pass

func _step(delta):
	if owner.motion_velocity.is_equal_approx(Vector2.ZERO):
		if owner.animator.current_animation != "idle":
#			owner.animator.stop()
			print("interrupt_run")
			owner.animator.play("idle")
	else:
		if owner.animator.current_animation != "running":
#			owner.animator.stop()
			owner.animator.play("running")		
	owner.handle_direction(delta)
	owner.handle_arm(delta)
	owner.move_and_slide()
	if not owner.is_on_floor():
		return "falling"

	if Input.is_action_just_pressed("ui_accept") and owner.is_on_floor():
		return "jumping"
	
func _exit_state():
#	owner.animator.stop()
	pass
