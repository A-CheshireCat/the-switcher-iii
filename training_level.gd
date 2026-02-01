extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	get_tree().reload_current_scene()

func _on_area_3d_area_entered(_area: Area3D) -> void:
	get_tree().change_scene_to_file("res://second_level.tscn")


func _on_area_3d_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://win_screen.tscn")
