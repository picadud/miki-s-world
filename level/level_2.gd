extends Node2D

signal level_completed

func _on_exit_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("level_completed")
		set_deferred("monitoring", false)
