extends Node2D

const enemy = preload("res://game/enemy.tscn")
const GAME_OVER_SCENE = preload("res://game/game_over.tscn")
var wpm = 10.0:
	set(v):
		wpm = max(v,10.0)

var wpm_down_on_hit = 5.0

var wpm_gain_on_hit = 0.01

var shield_chance = 0.1

var min_spawn_dist = 680
var spawn_spacing = 10

var dead = false



func _ready() -> void:
	Global.reset()
	$Spawn.start()
	$AnimationPlayer.play("start")
	Global.streak_changed.connect(_on_streak_changed)
	
#8.5 seconds to reach from spawn for first
#20
 

func spawn_enemy():
	
	var num_to_spawn = int(clamp(randfn(4,1),1,min(12,(wpm-10.0)*0.2 + 5.0)))
	var pos = randf() * 2 * PI
	
	var start_spawn_dist =  min_spawn_dist
	if $Enemies.get_child_count() > 0:
		var furthest:Enemy = $Enemies.get_child($Enemies.get_child_count()-1)
		start_spawn_dist = max((furthest.global_position - $Tower.global_position).length(), min_spawn_dist)
	
	for total_spawned in num_to_spawn:
		var e = enemy.instantiate()
		
		#dont spawn if too many for wpm
		if (($Enemies.get_child_count()/(start_spawn_dist/e.max_velocity))*60.0)/5.0 > wpm:
			print("to many")
			break
		
		e.global_position = ($Tower.global_position+Vector2(start_spawn_dist + spawn_spacing * total_spawned,0).rotated(randf() * 2 * PI))
		e.player = $Tower
		if randf() < shield_chance:
			e.shield = 1
		e.dead.connect(on_enemy_defeat)
		e.closest = !( $Enemies.get_child_count() > 0 )
		$Enemies.add_child(e)
		
	
	
	
func on_enemy_defeat(bonus):
	wpm = wpm + wpm_gain_on_hit + (wpm_gain_on_hit * bonus)
	Global.score += 1 + bonus
	Global.streak += 1
	%Score.text = str(Global.score)


func _on_spawn_timeout() -> void:
	spawn_enemy()
	$Spawn.wait_time = 60.0/wpm
	$Spawn.start()


func _on_tower_took_damage(hp: Variant) -> void:
	%SegmentedProgressBar.value = hp/10.0
	wpm -= wpm_down_on_hit
	$Spawn.stop()
	$Spawn.wait_time = (60.0/wpm) * 2.0
	$Spawn.start()
	for enemy in $Enemies.get_child_count():
		var e:Enemy = $Enemies.get_child(enemy)
		e.velocity += (e.global_position - $Tower.global_position).normalized() * (800.0 + 5.0 * enemy)
	
func _on_Tower_died():
	if dead:
		return
	dead = true
	$AnimationPlayer.play("Death")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed.call_deferred(GAME_OVER_SCENE)


func _on_bonus_reduce_body_entered(body: Node2D) -> void:
	body.bonus -= 1


func _on_activate_body_entered(body: Node2D) -> void:
	body.active = true
	
func _on_streak_changed(s):
	%Streak.text = str(s)
