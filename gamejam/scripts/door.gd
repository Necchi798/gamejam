class_name door
extends Node2D
@export var required_switches: int = 1
var pressed_switchs = 0
var open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func switch_pressed():
	pressed_switchs+=1
	toggle()
	
func switch_released():
	pressed_switchs -=1
	toggle()
	
func toggle():
	print("qui", $CollisionShape2D.disabled)
	if(pressed_switchs == required_switches):
		open = true
	else:
		open = false
	if(open ):
		$open.visible=true
		$closed.visible=false
		$CollisionShape2D.set_deferred("disabled",true) 
		print("aperta")
	else:
		$open.visible=false
		$closed.visible=true
		$CollisionShape2D.set_deferred("disabled",false) 
		print("chiusa")
