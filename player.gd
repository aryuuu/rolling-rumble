extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_impulse = 20

@export var deceleration_rate = 2

@export var bounce_impulse = 8

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	#var direction
	#if velocity.is_zero_approx():
		#direction = Vector3.ZERO
	#else:
		#direction = 
	#var direction = velocity
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
		
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
		
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		
		# handle collision with the ground
		if collision.get_collider() == null:
			continue
			
		# handle collision with a mob
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			
			var bounce_velocity: Vector3
			mob.bounce(target_velocity)
			#Vector3.UP
			
			# TODO: move the mob with some speed and direction depends on our player
			# TODO: bounce the player a bit after collision using bounce_impulse
			
			#if Vector3.UP.dot(collision.get_normal()) > 0.1:
			#print(collision.get_normal())
				
			
			
	
		
	velocity = target_velocity
	move_and_slide()
		
	
	
