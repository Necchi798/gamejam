class_name double
extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var active = false
const initial_wait_time = 2.0  # La pausa iniziale di 2 secondi
var current_wait_timer = 0.0
@export var player: player
@onready var animations = $AnimatedSprite2D
var history_index = 0
func _ready() -> void:
	visible = false
	set_physics_process(false)
func deactivate():
	active = false
	visible = false
	set_physics_process(false)
	relative_index = 0
	print("Clone disattivato!")
var start_playback_index: int = 0
var playback_timer: float = 0.0
const RECORD_INTERVAL = 0.02

func activate():
	if active:return
	if is_instance_valid(player):
		self.start_playback_index = player.movement_history.size()
	current_wait_timer = 0
	active = true
	visible = true
	global_position = player.global_position
	playback_timer = 0
	set_physics_process(true)
	print("Clone attivato!")
var record_timer = 0
var relative_index = 0
func _physics_process(delta):

	if player.movement_history.is_empty():
		return
	if current_wait_timer < initial_wait_time:
		current_wait_timer += delta
		return
	playback_timer += delta
	#int(playback_timer / RECORD_INTERVAL)
	record_timer += delta
	if record_timer >= RECORD_INTERVAL:
		record_timer = 0
		relative_index+=1
	var target_index = int(relative_index + start_playback_index)
	
	if target_index >= player.movement_history.size():
		target_index = player.movement_history.size() - 1

	var input_data = player.movement_history[target_index]
	var direction = input_data.direction
	
	if(direction < 0):
		animations.play("walk")
		animations.flip_h = true
	elif(direction > 0):
		animations.play("walk")
		animations.flip_h = false
	else:
		animations.play("idle")
	global_position = input_data.position
