extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_play_pressed() -> void:
	
	print("Press registerd") # Replace with function body.

	get_tree().change_scene_to_file("res://scenes/world.tscn")




func _on_intro_pressed() -> void:
	print("intro register")
	get_tree().change_scene_to_file("res://scenes/intro.tscn")


func _on_credits_pressed() -> void:
	pass # Replace with function body.
