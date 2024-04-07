extends CharacterBody3D

@export var speed = 20
@export var fall_acceleration = 75
@export var jump_impulse = 20

@export var deceleration_rate = 0.5
@export var acceleration_rate = 1

@export var collision_rate = 1

@export var bounce_impulse = 8

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	#var direction = Vector3()
	var current_velocity = Vector3.ZERO
	var x_dir = 0
	var z_dir = 0
	
	if not is_nan(current_velocity.x):
		current_velocity.x = velocity.x
		
		if current_velocity.x != 0:
			x_dir = current_velocity.x / abs(current_velocity.x)
		
	current_velocity.y = velocity.y

	if not is_nan(current_velocity.z):
		current_velocity.z = velocity.z
		
		if current_velocity.z != 0:
			z_dir = current_velocity.z / abs(current_velocity.z)
	
	var x_decel = -x_dir * deceleration_rate
	var z_decel = -z_dir * deceleration_rate
	
	var acc = Vector3(x_decel, 0, z_decel)
	
	if Input.is_action_pressed("move_right"):
		acc.x = acceleration_rate
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		acc.x = -acceleration_rate
		direction.x -= 1
	if Input.is_action_pressed("move_backward"):
		acc.z = acceleration_rate
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		acc.z = -acceleration_rate
		direction.z -= 1
		
	#if direction != Vector3.ZERO:
		#direction = direction.normalized()
		#$Pivot.basis = Basis.looking_at(direction)
	
	if abs(current_velocity.x + acc.x) > speed:
		velocity.x = direction.x * speed
	else:
		velocity.x += acc.x
		
	if abs(current_velocity.z + acc.z) > speed:
		velocity.z = direction.z * speed
	else:
		velocity.z += acc.z
		
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
		
	velocity.y = target_velocity.y
		
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		
		# handle collision with the ground
		if collision.get_collider() == null:
			continue
			
		# handle collision with a mob
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			
			var bounce_velocity: Vector3
			var collision_vec = collision.get_normal()
			bounce_velocity.x = collision_vec.x * collision_rate * speed
			bounce_velocity.y = collision_vec.y * collision_rate * speed
			bounce_velocity.z = collision_vec.z * collision_rate * speed
			print("player_vel: ", velocity)
			print("bounce_vel: ", bounce_velocity)
			
			mob.bounce(bounce_velocity)
			#Vector3.UP
			
			# TODO: move the mob with some speed and direction depends on our player
			# TODO: bounce the player a bit after collision using bounce_impulse
			
			#if Vector3.UP.dot(collision.get_normal()) > 0.1:
			#print(collision.get_normal())
				
	#velocity = target_velocity
	#print("player velo:", velocity)
	move_and_slide()
	#move_and_collide(velocity)
		
	
	
