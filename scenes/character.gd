extends CharacterBody2D

const SPEED = 600.0
const JUMP_FORCE = 800.0
const WALL_JUMP_FORCE = 500 * Vector2(3,1)
const ARM_SPEED = 300
const ARM_MAX_ANGLE = 30
const FRICTION = 0.4
const GRAVITY := 980 * 3.5
# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var acceleration := Vector2.ZERO
var facing_right := true 
var has_sword := true
var jump_counter := 0
var arm_rotation := 0.0:
	set(value):
		arm_rotation = value
		$Sprites/SpriteArm.rotation = value #Change that line

@onready var animator = $AnimationPlayer
@onready var arm = $Arm
@onready var state = $States/Idle
@onready var states = {
	"idle" : $States/Idle,
	"jumping" : $States/Jumping,
	"falling" : $States/Falling,
	"on_wall" : $States/OnWall,
	"stunned" : $States/Stunned,
}
@onready var timer_on_wall = $TimerOnWall

func _ready():
	state._enter_state()
	


func set_facing_right(value: bool):
	if facing_right != value:
		if value:
			$Sprites.scale.x = 1
		else:
			$Sprites.scale.x = -1
	facing_right = value 

func set_has_sword(value):
	has_sword = value

func _physics_process(delta):	
	var next_state = await state._step(delta)
	if next_state:
		state._exit_state()
		state = states[next_state]
		state._enter_state()

func handle_direction():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		motion_velocity.x = direction * SPEED
		set_facing_right(motion_velocity.x >= 0)  
	else:
		motion_velocity.x = move_toward(motion_velocity.x, 0, abs(motion_velocity.x) * FRICTION)



func handle_arm():
	var direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		arm_rotation = move_toward(arm_rotation, 0, ARM_MAX_ANGLE * sign(direction))
	else:
		arm_rotation = move_toward(arm_rotation, 0, ARM_SPEED)
