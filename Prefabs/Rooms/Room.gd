extends Node2D

var len_x = 0
var len_y = 0 
var solved = false


func _ready():
	for child in $Doors.get_children():
		child.parent = self
		handle_doors("open")



func _on_Room_Area_body_entered(body):
	print(body)
	if body.name == "Player":
		$Camera2D.current = true


func _on_Room_Area_body_exited(body):
	if body.name == "Player":
		$Camera2D.current = false


func start_room():
	if !solved: 
		handle_doors("close")

func finish_room():
	handle_doors("open")
	
	

func handle_doors(action):
	for child in $Doors.get_children():
		child.open() if action == "open" else child.close()
