extends HBoxContainer





func _on_Start_pressed():
	# Function to handle the Start button press
	# This would typically transition to the game scene
	get_tree().change_scene_to_packed(Global.GAME_SCENE)

func _on_Settings_pressed():
	# Here you would implement logic to open a settings menu
	# For now, we'll just print a message
	print("Settings button pressed. Implement settings scene change here.")

func _on_Quit_pressed():
	# Function to handle quitting the game
	get_tree().quit()

# Optional: If you want to handle any input for the entire menu (like escape to quit)
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
