extends Node2D

var len_x = 0
var len_y = 0 







func _on_Room_Area_body_entered(body):
	print(body)
	if body.name == "Player":
		$Camera2D.current = true


func _on_Room_Area_body_exited(body):
	if body.name == "Player":
		$Camera2D.current = false
