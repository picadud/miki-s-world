extends CharacterBody2D

# Timer to check for being stuck
@export var check_time: float = 1.0  # Duration to check for being stuck
@export var move_threshold: float = 1.0  # Minimum movement threshold
@export var lrSpeed = 300.0 #moving speed(left and right)
@export var falling_Velocity = 200.0 #falling speed
var floorCheckerPrevious = false #if it is on the floor
var direction = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var previous_position: Vector2
var timer: Timer

func _ready():
	previous_position = position
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = check_time
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
func _on_timer_timeout():
	queue_free()
	
func _physics_process(delta):
	if previous_position.distance_to(position) > move_threshold: #reset the timer if the object moves enough
		previous_position = position
		timer.start()	
	# Add the gravity.
	var floorCheckerNow = is_on_floor()

	if !floorCheckerPrevious && floorCheckerNow: #if the lightening just fall down on a platform
		var changeDirection = randi() % 2 #decide the direction after falling on a floor randomly
		if changeDirection:
			direction = -direction
			velocity.x = direction * lrSpeed
	elif !floorCheckerNow: #if in the air, fall down straight
		velocity.x = 0
		velocity.y = falling_Velocity
	
	else: #if just moving on a platform, velocity does not change
		velocity.x = direction * lrSpeed
	#to think of a way to remove the lightening after it got stuck	
	
		
	floorCheckerPrevious = floorCheckerNow
	
	move_and_slide()
