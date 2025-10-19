extends CharacterBody2D

class_name player
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var movement_history = []
const RECORD_INTERVAL = 0.02 # Registra ogni 0.05 secondi
var record_timer = 0.0
@export var double_node: double
@onready var animations = $AnimatedSprite2D
func _physics_process(delta: float) -> void:
	# Add the gravity.
	record_timer += delta
	var direction := Input.get_axis("ui_left", "ui_right")
	if record_timer >= RECORD_INTERVAL:
		record_timer = 0
		var current_data = {
			"direction":direction,
			"position": global_position,
			"flip_h": $AnimatedSprite2D.flip_h # Registra se lo sprite è girato orizzontalmente
		}
		movement_history.append(current_data)
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("activate_double"):
		print("here")
		if double_node and not double_node.active:
			double_node.activate()
			get_tree().create_timer(5.0).timeout.connect(double_node.deactivate)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		if(direction < 0):
			animations.play("walk")
			animations.flip_h = true
		elif(direction > 0):
			animations.play("walk")
			animations.flip_h = false
		else:
			animations.play("idle")
	else:
		animations.play("jump")
		if(direction < 0):
			animations.flip_h = true
		if(direction > 0):
			animations.flip_h = false
			
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
