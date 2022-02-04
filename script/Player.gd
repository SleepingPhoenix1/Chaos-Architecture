extends RigidBody2D


export var acceleration = 20
export var max_speed = 100
export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

var is_on_ground = false

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


func _ready():
	pass

func _process(delta):
	
	if !is_on_ground:
		linear_velocity.y += get_gravity() * delta
	#if Input.is_action_just_pressed("jump") and is_on_ground:
	#	jump()

func _physics_process(delta):
	move()



func move():
	#print(linear_velocity)
	if Input.is_action_pressed("left"):
		linear_damp = -1
		if linear_velocity.x > -max_speed:
			apply_central_impulse(Vector2(-acceleration, 0))
		else:
			linear_velocity.x = -max_speed
	elif Input.is_action_pressed("right"):
		linear_damp = -1
		if linear_velocity.x < max_speed:
			apply_central_impulse(Vector2(acceleration, 0))
		else:
			linear_velocity.x = max_speed
	else:
		linear_damp = 10
	
		

func get_gravity() -> float:
	return jump_gravity if linear_velocity.y < 0.0 else fall_gravity
	
func jump():
	apply_central_impulse(Vector2(linear_velocity.x, linear_velocity.y + jump_velocity))
	#linear_velocity.y = jump_velocity
	
	





func _on_is_on_ground_body_entered(body):
	if body.is_in_group("ground"):
		is_on_ground = true


func _on_is_on_ground_body_exited(body):
	if body.is_in_group("ground"):
		is_on_ground = false
