extends CharacterBody2D

@export var max_velocity := 600.0
@export var max_over_velocity := 4000.0
@export var accel := 3000.0

var wish_dir
var target = null
var target_char


func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		wish_dir = (target.global_position - global_position).normalized()
	else:
		var enemy_list = get_parent().get_node("Enemies")
		var found = false
		for enemy in enemy_list.get_children():
			if enemy.chr == target_char:
				target = enemy
				found = true
				break
		if !found:
			queue_free()
	
	if wish_dir.length() > 0:
		velocity = ((wish_dir * accel * delta) + velocity).limit_length(max(max_velocity,min(max_over_velocity,velocity.length())))
	accel += 300.0
	move_and_slide()
