extends Node2D

var parent




func _on_Back_Area_Detector_body_entered(body):
	if body.name == "Player":
		if parent.has_method("start_room"):
			parent.start_room()


func open():
	$Door_Body/Door_Body_Area.set_deferred("disabled", true)
	$AnimatedSprite.play('Open')


func close():
	print("S")
	$Door_Body/Door_Body_Area.set_deferred("disabled", false)
	$AnimatedSprite.play('Closed')
