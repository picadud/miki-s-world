extends Node2D

#每个关卡都应该添加进组“level”，别忘了
signal level_completed
const lightening = preload("res://level/Lightening.tscn")
var lighteningTimer: Timer
var lighteningGenerated: int = 0
@onready var lighteningTrigger: Area2D = $EventTrigger
@export var lighteningSpawnLocation: Vector2 = Vector2(100, -50)
@export var numberOfLightening: int = 10
@export var lighteningInterval: float = 0.3

#进入终点后发出信号。
func _on_exit_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("level_completed")
		set_deferred("monitoring", false)
		


func _on_event_trigger_area_entered(area):
	if area.is_in_group("playerArea"):
		if area.global_position.y > lighteningTrigger.global_position.y:
			print("thunder")
			lighteningTrigger.queue_free()		
			lighteningTimer = Timer.new()
			add_child(lighteningTimer)
			lighteningTimer.wait_time = lighteningInterval
			lighteningTimer.one_shot = false
			lighteningTimer.timeout.connect(_on_lightening_timer_time_out)
			lighteningTimer.start()
		


	
func _on_lightening_timer_time_out():
	if lighteningGenerated < numberOfLightening:
		#print("coming")
		var lgt = lightening.instantiate()
		add_child(lgt)		
		lgt.position = lighteningSpawnLocation
		lighteningGenerated += 1
	else:
		#print("runout")
		lighteningTimer.queue_free()
		
		
		
