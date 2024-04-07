extends CharacterBody3D

@export var fall_acceleration = 20
@export var deceleration_rate = 2

@export var target_velocity = Vector3.ZERO

func _physics_process(delta):
	#var target_velocity = Vector3.ZERO
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	velocity = target_velocity
	#print("mob vel: ", velocity)
		
	move_and_slide()
#
func bounce(vec: Vector3):
	#print("bounce vec: ", vec)
	velocity = vec
	#target_velocity = vec
	
	move_and_slide()
