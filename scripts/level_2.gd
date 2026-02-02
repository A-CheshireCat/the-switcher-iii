extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	get_tree().reload_current_scene()

const FILE_BEGIN = "res://scenes/level_"

func _on_area_3d_body_entered(body: Node3D):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		var next_Level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		get_tree().change_scene_to_file(next_Level_path)
		pass
