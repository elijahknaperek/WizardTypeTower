extends HBoxContainer


var  score = 0:
	set(v):
		$VBoxContainer/Score.text = str(v)

func _ready() -> void:
	score = Global.score

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_packed(Global.GAME_SCENE)


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(Global.MAIN_MENU_SCENE)
