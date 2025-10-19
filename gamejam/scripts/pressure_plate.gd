extends StaticBody2D

@export var target_door: door
var weight = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_area_2d_body_entered(_body: Node2D) -> void:
	if target_door && weight == 0:
		print("pedana ha attivato la porta:", target_door.name)
		target_door.switch_pressed()
		$pressed.visible = true
		$unpressed.visible = false
	weight += 1

func _on_area_2d_body_exited(_body: Node2D) -> void:
	weight -= 1
	if target_door && weight <= 0:
		weight = 0
		await get_tree().create_timer(0.5).timeout
		print("pedana ha attivato la porta:", target_door.name)
		target_door.switch_released()
		$pressed.visible = false
		$unpressed.visible = true


	
