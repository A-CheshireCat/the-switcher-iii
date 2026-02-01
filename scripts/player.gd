extends CharacterBody3D

const SPEED = 7.0
const JUMP_VELOCITY = 9.5

signal hit

var mask1_active: bool = true
var mask2_active: bool = false
var mask3_active: bool = false
var double_jump_active: bool = false

@onready var collision_mask2: CollisionShape3D = $HitAreaMask2/CollisionShape3D
@onready var animation_tree: AnimationTree = $PlayerCollision/Player_Character/AnimationTree

func _ready() -> void:
	animation_tree.active = true
	
func _process(delta: float) -> void:
	update_animations()
	
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
		change_mask(true,false)
	if Input.is_action_just_pressed("mask2"):
		change_mask(false,true)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func change_mask(mask1: bool, mask2: bool):
	mask1_active = mask1
	double_jump_active = mask1
	mask2_active = mask2
	collision_mask2.disabled = not mask2


func die():
	hit.emit()
	queue_free()
	get_tree().change_scene_to_file("res://death_screen.tscn")
	

func _on_mob_detector_body_entered(_body: Node3D) -> void:
	die()

func _on_area_3d_body_entered(_body: Node3D) -> void:
	$SpikeOfDoom

func update_animations():
	if velocity.x != 0:
		animation_tree["parameters/conditions/run"] = true
		animation_tree["parameters/conditions/idle"] = false
	else:
		animation_tree["parameters/conditions/run"] = false
		animation_tree["parameters/conditions/idle"] = true
	
	if Input.is_action_just_pressed("jump"):
		animation_tree["parameters/conditions/jump"] = true
	else:
		animation_tree["parameters/conditions/jump"] = false
