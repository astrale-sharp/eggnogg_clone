extends CharacterBody2D

const JUMP_FORCE = 800.0
const WALL_JUMP_FORCE = 500 * Vector2(3,1)

const ARM_SPEED = deg2rad(0.2* 5)
const ARM_MAX_ANGLE = deg2rad(30) 

const FRICTION = 0.4
const GRAVITY := 980 * 3.5
const MAX_SPEED := 600.0
#const MIN_SPEED := 60.0
const ACCELERATION := 4000.0
# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var acceleration := 0
var facing_right := true:
	set(value):
		if facing_right != value:
			if value:
				print("facing right")
				$Sprites.scale.x = 1
			else:
				print("facing left")
				$Sprites.scale.x = -1
		facing_right = value 
var has_sword := true:
	set(value):
		has_sword = value
var jump_counter := 0
var arm_rotation := 0.0:
	set(value):
		arm_rotation = value
		if state == $States/Idle:
			$Sprites/Position2DArmRotation.rotation = value #Change that line
		else:
			$Sprites/Position2DArmRotation/Position2DSword.rotation = value
	
@onready var animator = $AnimationPlayer
#@onready var arm = $Arm
@onready var state = $States/Idle
@onready var states = {
	"idle" : $States/Idle,
	"jumping" : $States/Jumping,
	"falling" : $States/Falling,
	"on_wall" : $States/OnWall,
	"stunned" : $States/Stunned,
	"running" : $States/Running
}
@onready var timer_on_wall = $TimerOnWall

func _ready():
	state._enter_state()
	
func spike_rotation():
	print("spike")

func _physics_process(delta):	
	var next_state = state._step(delta)
	if next_state:
		state._exit_state()
		state = states[next_state]
		state._enter_state()

func handle_direction(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		acceleration = delta * ACCELERATION * direction
		motion_velocity.x += acceleration
		motion_velocity.x = clampf(motion_velocity.x,-MAX_SPEED,MAX_SPEED)
		facing_right = motion_velocity.x >= 0
	else:
		motion_velocity.x = move_toward(motion_velocity.x, 0, abs(motion_velocity.x) * FRICTION)

func handle_arm(delta):
	var direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		arm_rotation = move_toward(arm_rotation, ARM_MAX_ANGLE * sign(direction) , ARM_SPEED )
	else:
		arm_rotation = move_toward(arm_rotation, 0,ARM_SPEED)
