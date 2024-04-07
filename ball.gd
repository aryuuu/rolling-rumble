extends RigidBody3D

@export var rolling_force = 1000
@export var jump_impulse = 100

@export var mouse_sensitivity = .1
@export var camera_anglev = 0
## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
	
	
func _ready():
	$CameraPivot.top_level = true
	$FloorCheck.top_level = true
	
func _input(event):
	if event is InputEventMouseMotion:
		$CameraPivot.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var changev = -event.relative.y * mouse_sensitivity
		if camera_anglev+changev > -50 and camera_anglev + changev < 50:
			camera_anglev += changev
			$CameraPivot.rotate_x(deg_to_rad(changev))

func _physics_process(delta):
	var old_camera_pos= $CameraPivot.global_transform.origin
	var ball_pos = global_transform.origin
	var new_camera_pos = lerp(old_camera_pos, ball_pos, 0.1)
	$CameraPivot.global_transform.origin = new_camera_pos
	
	$FloorCheck.global_transform.origin = global_transform.origin
	
	if Input.is_action_pressed("move_forward"):
		angular_velocity.x -= rolling_force*delta
	elif Input.is_action_pressed("move_backward"):
		angular_velocity.x += rolling_force*delta
		
	if Input.is_action_pressed("move_right"):
		angular_velocity.z -= rolling_force*delta
	elif Input.is_action_pressed("move_left"):
		angular_velocity.z += rolling_force*delta
		
	var is_on_floor = $FloorCheck.is_colliding()
	if Input.is_action_just_pressed("jump"):
		print("ball jump pressed")
	if Input.is_action_just_pressed("jump") and is_on_floor:
		print("should jump")
		apply_central_impulse(Vector3.UP * jump_impulse)
		
	
