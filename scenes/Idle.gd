extends State

func _enter_state():
	pass

func _step(delta):
	owner.animator.play("idle")
	owner.handle_direction()
	owner.handle_arm()
	owner.move_and_slide()
	if not owner.is_on_floor():
		return "falling"

	if Input.is_action_just_pressed("ui_accept") and owner.is_on_floor():
		return "jumping"
	
func _exit_state():
#	owner.animator.stop()
	pass
