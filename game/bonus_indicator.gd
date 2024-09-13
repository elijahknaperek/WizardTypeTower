extends Label

var pitch_scale = 1.0


func _ready() -> void:
	$AudioStreamPlayer.pitch_scale = pitch_scale + 0.01 * Global.streak + randf() * 0.005
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("FadeOut")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	self.queue_free()
