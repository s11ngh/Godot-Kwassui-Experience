extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_play_pressed() -> void:
	
	print("Press registerd") # Replace with function body.

	get_tree().change_scene_to_file("res://world.tscn")


func _on_how_pressed() -> void:
	print("how to play pressed")
	get_tree().change_scene_to_file("res://howto_play.tscn")
