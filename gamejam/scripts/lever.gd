extends Area2D
var player_near = false
var state = "idle"
var player_interaction = false
@export var target_door: door
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_near and Input.is_action_just_pressed("pull_lever"):
		player_interaction = true
		toggle()



func _on_body_entered(body: Node2D) -> void:
	if(body.name == "player"):
		player_near = true
	elif(player_interaction):
		player_interaction = false
		toggle()
		
		
func toggle():
	
	if state == "idle":
		target_door.switch_pressed()
		$pulled.visible = true
		$idle.visible = false
		state = "active"
	elif state == "active":
		target_door.switch_released()
		
		$pulled.visible = false
		$idle.visible = true
		state = "idle"

func _on_body_exited(body: Node2D) -> void:
	player_near = false
