extends RigidBody2D

var damage = 10
var hits = 0
var first_upgrade = 1
var second_upgrade = 3
var third_upgrade = 5
var fourth_upgrade = 8
var max_hits = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func upgrade_by_impact():
	hits += 1
	damage += 10
	if hits >= first_upgrade and hits <= second_upgrade:
		$Bullet_Sprite.modulate = "ffe300"
	elif hits >= second_upgrade and hits <= third_upgrade:
		$Bullet_Sprite.modulate = "ff8300"
	elif hits >= third_upgrade and hits <= fourth_upgrade:
		$Bullet_Sprite.modulate = "ff0000"




func _on_Bullet_Body_body_entered(body):
	if body.has_method("hurt"):
		body.hurt(damage)
		if hits >= max_hits:
			queue_free()
	upgrade_by_impact()

