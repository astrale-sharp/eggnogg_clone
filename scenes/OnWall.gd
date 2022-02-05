extends State

func speed(jump_counter)-> float:
	match jump_counter:
		0:
			return 0.0
		1:
			return 400.0
		2:
			return 600.0
		3:
			return 800.0
	print("what is :", jump_counter)
	return 800.0

func _enter_state():
	owner.motion_velocity = Vector2.ZERO
	owner.animator.stop()
	owner.facing_right = not owner.facing_right
	if owner.animator.is_playing():
			await owner.animator.animation_finished
	owner.animator.play("on_wall")
	

func _step(delta):
	owner.handle_arm(delta)
	if Input.is_action_just_pressed("ui_accept"):
		return "falling"
	else:
		owner.motion_velocity.y += speed(owner.jump_counter)
	owner.move_and_slide()
	
	
func _exit_state():
	owner.timer_on_wall.start()
	var direction = Vector2.RIGHT if owner.facing_right else Vector2.LEFT
	var jump_velocity = (direction + Vector2.UP).normalized() * owner.WALL_JUMP_FORCE
	
	owner.jump_counter += 1
	owner.motion_velocity = jump_velocity
	var r = RayCast2D.new()
	r.target_position = jump_velocity
	owner.add_child(r)
	owner.move_and_slide()
	
#	owner.motion_velocity += direction
#	owner.move_and_slide()
