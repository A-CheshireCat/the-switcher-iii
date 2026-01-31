extends RigidBody3D
var SPEED = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# put SPEED with minus so the spike goes left
	SPEED = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += SPEED * delta


func _on_spike_launcher_body_entered(body: Node3D) -> void:
	SPEED=-10
