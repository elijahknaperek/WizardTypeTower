extends CharacterBody2D

var chr = " "
var wish_dir
var player

@export var max_velocity := 100.0
@export var max_over_velocity := 4000.0
@export var accel := 1200.0

var stop_speed := 400.0
@export var friction := 0.2	

signal dead

func _ready() -> void:

	chr = Global.chars2[randi_range(0,len(Global.chars2)-1)]
	print(chr)
	$Label.text = chr
	
	
func _physics_process(delta: float) -> void:
	wish_dir = (player.global_position - global_position).normalized()
	
	if velocity.length() > 0:
		var control = max(stop_speed, velocity.length())#+(0.01*speed**2))
		var drop = control * friction * delta
		
		# Scale the velocity based on friction
		velocity *= max(velocity.length() - drop, 0) / velocity.length()
	if wish_dir.length() > 0:
		velocity = ((wish_dir * accel * delta) + velocity).limit_length(max(max_velocity,min(max_over_velocity,velocity.length())))
	move_and_slide()
	
func hit():
	dead.emit()
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	hit()
