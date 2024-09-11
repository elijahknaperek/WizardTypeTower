extends CharacterBody2D

var hp = 10
const fireball = preload("res://game/fireball.tscn")

signal took_damage(hp)
signal died

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		# Get the unicode value of the key event
		var unicode_value = event.unicode
		
		# Check if the key has a valid unicode character
		if unicode_value != 0:
			# Convert the unicode value to a string
			var key_char = char(unicode_value)
			fire_fireball(key_char)
		else:
			# Handle keys that don't map to characters (like function keys, etc.)
			print("Key pressed but no character representation: ", event.unicode)
			
func fire_fireball(chr):
	var enemy_list = get_parent().get_node("Enemies")
	for enemy in enemy_list.get_children():
		if enemy.chr == chr:
			var f = fireball.instantiate()
			get_parent().add_child(f)
			f.global_position = global_position
			f.velocity = (enemy.global_position -  global_position).normalized() * 400
			break
			


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	body.queue_free()
	hp -= 1
