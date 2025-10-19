class_name door
extends Node2D
var open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggle():
	print("qui", $CollisionShape2D.disabled)
	open = not open
	if(open):
		$Sprite2D.visible=false
		$CollisionShape2D.set_deferred("disabled",true) 
		print("aperta")
	else:
		$Sprite2D.visible=true
		$CollisionShape2D.set_deferred("disabled",false) 
		print("chiusa")
