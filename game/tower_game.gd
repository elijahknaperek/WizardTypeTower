extends Node2D

const enemy = preload("res://game/enemy.tscn")
var cpm = 30.0

func _ready() -> void:
	$Spawn.start()

func spawn_enemy():
	var e = enemy.instantiate()
	
	
	e.global_position = ($Tower.global_position+Vector2(1000,0).rotated(randf() * 2 * PI))
	e.player = $Tower
	e.dead.connect(on_enemy_defeat)
	$Enemies.add_child(e)
	
	
func on_enemy_defeat():
	cpm = cpm + 0.1


func _on_spawn_timeout() -> void:
	spawn_enemy()
	$Spawn.wait_time = 60.0/cpm


func _on_tower_took_damage(hp: Variant) -> void:
	%SegmentedProgressBar.value = hp/10.0
