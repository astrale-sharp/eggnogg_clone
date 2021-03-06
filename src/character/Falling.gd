extends State

func _enter_state():
	pass


func _step(delta):
	owner.handle_direction(delta)
	owner.handle_arm(delta)
	if not owner.is_on_floor():
		if owner.is_on_wall() and owner.timer_on_wall.is_stopped():
			return "on_wall"
		owner.motion_velocity.y += owner.GRAVITY * delta
		owner.move_and_slide()
		if owner.animator.is_playing() and "turn" in owner.animator.current_animation :
			await owner.animator.animation_finished
		owner.animator.play("falling_up") if owner.motion_velocity.y <0 else owner.animator.play("falling_down")
	else:
		owner.move_and_slide()
		return "idle"
	
func _exit_state():
	owner.jump_counter = 0
