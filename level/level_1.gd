extends Node2D

#每个关卡都应该添加进组“level”，别忘了
signal level_completed

#进入终点后发出信号。
func _on_exit_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("level_completed")
		set_deferred("monitoring", false)
		
