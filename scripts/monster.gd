extends CharacterBody3D

const SPEED = 2.0
#calculate thinking there are 60 ticks/sec
var DISTANCE_DIRECTION_SWITCH = 500
var DISTANCE_TRAVELLED = 0
var DIRECTION_WAY = 1

func _physics_process(delta: float) -> void:
	#calculate distance travelled
	DISTANCE_TRAVELLED += SPEED
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#Add movement on th X axis
	if(DIRECTION_WAY == 1):
		velocity.x = SPEED
	else:
		velocity.x = -SPEED
	
	#when the patrol changes direction
	if(DISTANCE_TRAVELLED >= DISTANCE_DIRECTION_SWITCH):
		DIRECTION_WAY = 2
		
	if(DISTANCE_TRAVELLED == (2*DISTANCE_DIRECTION_SWITCH)):
		DIRECTION_WAY = 1
		DISTANCE_TRAVELLED = 0
		
	move_and_slide()


func _on_hurt_box_area_entered(area: Area3D) -> void:
	# monster dies - add animations if available
	queue_free()
