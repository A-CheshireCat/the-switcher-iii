extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://training_level.tscn")


func _on_quit_button_down() -> void:
	get_tree().quit()
