extends CharacterBody3D

const SPEED = 7.0
const JUMP_VELOCITY = 9.5

var mask1_active: bool = true
var mask2_active: bool = false
var mask3_active: bool = false

var double_jump_active: bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif mask1_active:
		double_jump_active = true
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle double jump
	if Input.is_action_just_pressed("jump") and double_jump_active and not is_on_floor():
		velocity.y = JUMP_VELOCITY
		double_jump_active = false

	# Handle mask switch
	if Input.is_action_just_pressed("mask1"):
		mask1_active = true
		mask2_active = false
		mask3_active = false
	if Input.is_action_just_pressed("mask2"):
		mask1_active = false
		mask2_active = true
		mask3_active = false
	if Input.is_action_just_pressed("mask3"):
		mask1_active = false
		mask2_active = false
		mask3_active = true
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
