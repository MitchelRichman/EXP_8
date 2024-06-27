extends CharacterBody2D

var chase = false
var alive = true

var speed = 50
var enemyhealth = 100 

func _physics_process(delta):
	
	var player = get_tree().get_first_node_in_group("player")
	var direction = (player.position - self.position).normalized()
	
	
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed
	$AnimatedSprite2D.play("default")
		
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite2D.flip_h = true
		
	move_and_slide()
	if enemyhealth <= 0:
		death()
		
		
func _on_dtector_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_death_body_entered(body):
	if body.name == "Player":
		if alive == true: 
			body.health -= 40
			death()


func death ():
	alive = false 
	$AnimatedSprite2D.play("death")
	queue_free()
