extends CanvasLayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			get_tree().paused = false
			visible = false
		else:
			get_tree().paused = true
			visible = true
			



func _on_unpause_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_restart_pressed() -> void:
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to_packed(Global.GAME_SCENE)


func _on_quit_pressed() -> void:
	get_tree().quit()
