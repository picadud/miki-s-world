extends CharacterBody2D

signal LifeChanged
signal CoinChanged

const SPEED = 250
const JUMP_VELOCITY = -350
var maxHealth = 10 #not sure if gonna keep this
var jumpBufferTimer: Timer
@export var jumpBufferTime: float = 0.1
@export var coinCount: int : set = set_coin_count
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
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_Sprite = $AnimatedSprite2D
var counter = 0


func _ready():
	add_to_group("player")
	jumpBufferTimer = Timer.new()
	add_child(jumpBufferTimer)
	jumpBufferTimer.wait_time = jumpBufferTime
	jumpBufferTimer.one_shot = true
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jumpBufferTimer.start()	
	if !jumpBufferTimer.is_stopped() and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumpBufferTimer.stop()
		
	
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
