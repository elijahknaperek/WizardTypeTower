extends Node2D

const enemy = preload("res://game/enemy.tscn")
const GAME_OVER_SCENE = preload("res://game/game_over.tscn")
var cpm = 30.0

var shield_chance = 0.1


var dead = false

func _ready() -> void:
	Global.score = 0
	$Spawn.start()
	$AnimationPlayer.play("RESET")
	

func spawn_enemy():
	var e = enemy.instantiate()
	
	
	e.global_position = ($Tower.global_position+Vector2(680,0).rotated(randf() * 2 * PI))
	e.player = $Tower
	if randf() < shield_chance:
		e.shield = 1
	e.dead.connect(on_enemy_defeat)
	$Enemies.add_child(e)
	
	
func on_enemy_defeat(bonus):
	cpm = cpm + 0.1 + (0.1 * bonus)
	Global.score += 1 + bonus
	Global.streak += 1
	%Score.text = str(Global.score)


func _on_spawn_timeout() -> void:
	spawn_enemy()
	$Spawn.wait_time = 60.0/cpm


func _on_tower_took_damage(hp: Variant) -> void:
	%SegmentedProgressBar.value = hp/10.0
	
func _on_Tower_died():
	if dead:
		return
	dead = true
	$AnimationPlayer.play("Death")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed.call_deferred(GAME_OVER_SCENE)


func _on_bonus_reduce_body_entered(body: Node2D) -> void:
	body.bonus = 0
