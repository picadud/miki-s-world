extends CharacterBody2D

signal LifeChanged
signal CoinChanged

const SPEED = 250
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var maxHealth = 10 #not sure if gonna keep this
var jumpBufferTimer: Timer
var coyoteTimer: Timer
var wasOnFloor = false
var jumpCount = 0 #for potential double jump and getting rid of the bug introduced by coyote timer
@export var pushOffLedgeTolerance: float = 5
@export var maxJump: int = 1
@export var jumpBufferTime: float = 0.1
@export var coyoteTime: float = 0.1
@export var coinCount: int : set = set_coin_count
@export var jump_height: float = 5 #multiple of player height
func set_coin_count(value):
	coinCount = value
	CoinChanged.emit(value)
	
@export var LifeCount: int : set = set_life_count
func set_life_count(value):
	LifeCount = value
	LifeChanged.emit(value)
	if LifeCount <= 0 :
		player_dead()

# Get the gravity from the project settings to be synced with RigidBody nodes.

@onready var animated_Sprite = $AnimatedSprite2D
@onready var playCollider = $CollisionShape2D
#raycasting for pushing off ledges
@onready var left = $left
@onready var right = $right
@onready var center = $center 

func JUMP_VELOCITY():
	var v = sqrt(2 * gravity * jump_height * playCollider.shape.extents.y)
	return -v
	

func _ready():
	add_to_group("player")
	jumpBufferTimer = Timer.new()
	coyoteTimer = Timer.new()
	add_child(coyoteTimer)
	add_child(jumpBufferTimer)
	coyoteTimer.wait_time = coyoteTime
	jumpBufferTimer.wait_time = jumpBufferTime
	coyoteTimer.one_shot = true
	jumpBufferTimer.one_shot = true
	
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumpCount = 0
	# Handle jump.
	var justLeftFloor = !is_on_floor() && wasOnFloor
	if justLeftFloor:
		coyoteTimer.start() 	
	if Input.is_action_just_pressed("jump"):
		jumpBufferTimer.start()	
	var canJump = jumpCount < maxJump and !jumpBufferTimer.is_stopped() and (is_on_floor() or !coyoteTimer.is_stopped())
	if  canJump:		
		velocity.y = JUMP_VELOCITY()
		jumpCount += 1
		jumpBufferTimer.stop()
		coyoteTimer.stop()
		
	#push off ledges
	#tutorial for sophisticated manipulation
	#https://docs.godotengine.org/en/4.0/tutorials/physics/ray-casting.html
	if left.is_colliding() and !center.is_colliding():		
		global_position.x += pushOffLedgeTolerance
	elif right.is_colliding() and !center.is_colliding():		
		global_position.x -= pushOffLedgeTolerance
	
	
			
	var direction = Input.get_axis("move_left", "move_right")
	#flip the direction based on input

	#change animation
	
	if is_on_floor():

		if direction: #if not zero
			animated_Sprite.play("run")
		else:
			animated_Sprite.play("idle")
	else:

		animated_Sprite.play("jump")
	if direction > 0 :
		animated_Sprite.flip_h = false
	elif direction < 0:
		animated_Sprite.flip_h = true

	#change velocity based on input	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	wasOnFloor = is_on_floor()
	move_and_slide()
	


func _on_item_checker_area_entered(area):
	match area.get_groups(): 
		var coin when coin.has("Coin"):
			area.queue_free()
			coinCount += 1
			print(coinCount)
		var lightening when lightening.has("Lightening"):
			area.get_parent().queue_free() 
			LifeCount -= 1
			print(LifeCount)
		

	
func player_dead():
	pass
