extends CharacterBody2D

var redy = true
var shotgun = false
var gun = true

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var health = 100

@export var bullet : PackedScene

func get_input():
	look_at(get_global_mouse_position())
	velocity= transform.x * Input.get_axis("down","up")

func _physics_process(delta):
	get_input()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	var dvizh = Input.get_axis("up","down")
	
	if direction == 0:
		$AnimatedSprite2D.play("default")
		
	
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	if dvizh:
		velocity.y = dvizh * SPEED
		$AnimatedSprite2D.play("run")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if health <= 0:
		queue_free()
		get_tree().reload_current_scene()

	move_and_slide()


	if Input.is_action_just_pressed("shoot"):
		if shotgun == true:
			if redy == true:
				shoot()
				redy = false
		if gun == true:
			shoot()
	
	if Input.is_action_just_pressed("Shotgun"):
		shotgun =  true
		gun = false
	if Input.is_action_just_pressed("Gun"):
		shotgun = false
		gun = true
	
func _on_timer_timeout():
	redy = true
	
	
	
	
func shoot():
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = $GunCast2D/Marker2D.global_transform
	


	


