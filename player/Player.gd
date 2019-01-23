extends "res://character/Character.gd"

signal moved
signal dead
signal grabbed_key
signal win


func _ready():
	$Sprite.scale = Vector2(1,1)


func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					$FootSteps.play()
					emit_signal('moved')


func _on_Player_area_entered(area):
	if area.is_in_group('enemies'):
		area.hide()
		$CollisionShape2D.disabled = true
		set_process(false)
		$Lose.play()
		$AnimationPlayer.play('die')
		yield($Lose, 'finished')
		emit_signal('dead')

	if area.has_method('pickup'):
		area.pickup()
		if area.type == 'KeyRed':
			emit_signal('grabbed_key')
		if area.type == 'Star':
			$Win.play()
			$CollisionShape2D.disabled  = true
			yield($Win, "finished")
			emit_signal('win')
