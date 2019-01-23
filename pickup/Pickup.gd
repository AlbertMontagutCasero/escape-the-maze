extends Area2D

signal coin_pickup

var textures = { 'Coin' : 'res://pickup/coin.png',
				 'KeyRed' : 'res://pickup/keyRed.png',
				 'Star' : 'res://pickup/star.png'}
var type


func _ready():
	$Tween.interpolate_property(
		$Sprite,
		'scale',
		Vector2(1,1),
		Vector2(3,3),
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT)
	$Tween.interpolate_property(
		$Sprite,
		'modulate',
		Color(1,1,1,1),
		Color(1,1,1,0),
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT)

"""
 Some programming languages use the notion of private functions or variables,
 meaning they are only used locally. The _ naming convention in GDScript
 is used to visually designate variables or functions that should be
 regarded as private. Note that they aren't actually any different from
 any other name; it is merely a visual indication for the programmer.
"""
func init(_type, pos):
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos


func pickup():
	match type:
		'Coin':
			emit_signal('coin_pickup', 1)
			$CoinPickup.play()
		'KeyRed':
			$KeyPickup.play()
	$CollisionShape2D.disabled = true
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
