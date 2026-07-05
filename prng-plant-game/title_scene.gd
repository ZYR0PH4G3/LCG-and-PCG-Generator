extends Node2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")# Replace with function body.



func _on_settings_pressed() -> void:
	pass

 # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()# Replace with function body.
