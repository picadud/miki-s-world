extends CharacterBody2D


const SPEED = 250
const JUMP_VELOCITY = -350

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_Sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("move_left", "move_right")
	#flip the direction based on input
	if direction > 0 :
		animated_Sprite.flip_h = true
	elif direction < 0:
		animated_Sprite.flip_h = false
	#change animation
	if is_on_floor():
		if direction: #if not zero
			animated_Sprite.play("run")
		else:
			animated_Sprite.play("idle")
	else:
		animated_Sprite.play("jump")
		
	#change velocity based on input	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
