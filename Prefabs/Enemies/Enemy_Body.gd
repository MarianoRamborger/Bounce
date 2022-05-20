extends KinematicBody2D

export var Hp = 20
export var Speed = 20

onready var nav_rays = $Navigation_Rays.get_children()
onready var interest_array = [0,0,0,0,0,0,0,0]
onready var movement_vectors = [Vector2(0,-1.5), Vector2(1,-1), Vector2(1.5,0), Vector2(1,1), Vector2(0,1.5), Vector2(-1,1), Vector2(-1.5,0), Vector2(-1,-1)] # Posibles vectores de movimiento.
var collision_array = [0,0,0,0,0,0,0,0]  #El array que va a usar rays para detectar.
var direction


func get_interest(): #De aca salen los numeros, a mas largo mas distancia del player
	for i in range(0, len(interest_array)):
		interest_array[i] = (global_position + movement_vectors[i]).distance_to(GameManager.player_position)


func get_danger():
	for i in range(0,len(nav_rays)):
		if nav_rays[i].get_collider():
			interest_array[i] += 10000 #Mejorar esto prolly

func choose_direction():
	var shortest = interest_array[0]
	direction = movement_vectors[0]
	for i in range(1, len(interest_array)):
		if interest_array[i] < shortest:
			shortest = interest_array[i]
			direction = movement_vectors[i]

func move():
	move_and_slide(direction * 50)

func _ready():
	get_interest()

func animate():
	if direction == Vector2(1.5,0):
		$Enemy_Rotator.play("Right")
	elif direction == Vector2(1,1):
		$Enemy_Rotator.play("Down_Right")
	elif direction == Vector2(0, 1.5):
		$Enemy_Rotator.play("Down")
	elif direction == Vector2(-1,1):
		$Enemy_Rotator.play("Down_Left")
	elif direction == Vector2(-1.5,0):
		$Enemy_Rotator.play("Left")
	elif direction == Vector2(-1,-1):
		$Enemy_Rotator.play("Up_Left")
	elif direction == Vector2(0,-1.5):
		$Enemy_Rotator.play("Up")
	elif direction == Vector2(1,-1):
		$Enemy_Rotator.play("Up_Right")

func _physics_process(delta):
		get_interest()
		get_danger()
		choose_direction()
		animate()
		move()
		if Input.is_action_just_pressed("Shoot"):
			print(direction)


func hurt(damage):
	Hp -= damage
	if Hp <= 0:
		$Enemy_Animator.play("Death")
	else:
		$Enemy_Animator.play("Hurt")


func Despawn():
	queue_free()



