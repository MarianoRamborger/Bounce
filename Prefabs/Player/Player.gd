extends KinematicBody2D

export var speed = 400
var motion = Vector2(0,0)
var aiming = false
export var bullet_speed = 2500
onready var bullet = load("res://Prefabs/Bullet/Bullet.tscn")

func handle_movement(input):
	if input.is_action_pressed("Up") and !input.is_action_pressed("Down"):
		motion.y = -1
	elif input.is_action_pressed("Down") and !input.is_action_pressed("Up"):
		motion.y = 1
	else:
		motion.y = 0
	if input.is_action_pressed("Left") and !input.is_action_pressed("Right"):
		motion.x = -1
	elif input.is_action_pressed("Right") and !input.is_action_pressed("Left"):
		motion.x = 1
	else:
		motion.x = 0
	if input.is_action_just_pressed("Aim"):
		motion = Vector2.ZERO
		aiming = true


func animate_rotation():
	if motion.x < 0 and motion.y == 0:
		rotation_degrees = 180
	elif motion.x > 0 and motion.y == 0:
		rotation_degrees = 0
	elif motion.x == 0 and motion.y < 0:
		rotation_degrees = -90
	elif motion.x == 0 and motion.y > 0:
		rotation_degrees = 90
	elif motion.x > 0 and motion.y > 0:
		rotation_degrees = 45
	elif motion.x > 0 and motion.y < 0:
		rotation_degrees = -45
	elif motion.x < 0 and motion.y < 0:
		rotation_degrees = -135
	elif motion.x < 0 and motion.y > 0:
		rotation_degrees = 135


func handle_aiming(input):

	if input.is_action_pressed("Left") and !input.is_action_pressed("Right"):
		rotation_degrees -= 1
	elif input.is_action_pressed("Right") and !input.is_action_pressed("Left"):
		rotation_degrees += 1
	if input.is_action_just_pressed("Aim"):
		var shooting_vector = Vector2(cos(rotation), sin(rotation))
		var new_bullet = bullet.instance()
		GameManager.add_child(new_bullet)
		new_bullet.position = Vector2(position.x + shooting_vector.x * 35, position.y +  shooting_vector.y * 35)
		new_bullet.apply_central_impulse(Vector2(shooting_vector.x * bullet_speed ,shooting_vector.y * bullet_speed))
		new_bullet.last_velocity =  Vector2(shooting_vector.x * bullet_speed ,shooting_vector.y * bullet_speed)
		new_bullet.add_torque(rotation)
		motion = Vector2.ZERO
		aiming = false

	# print(Vector2(cos(rotation), sin(rotation))) #THIS CONVERTS ANGLE TO VECTOR

func animate_aiming():
	if aiming:
		$Playersprite.play("Aiming")
	else:
		$Playersprite.play("Walking")

func check_input(input):
	if !aiming:
		handle_movement(input)
	elif aiming:
		handle_aiming(input)



func _physics_process(delta):
	check_input(Input)
	animate_rotation()
	animate_aiming()
	move_and_slide(motion * speed)
	GameManager.player_position = Vector2(position.x,position.y)

func hurt(damage):
	$Player_Animator.play("Hurt")
