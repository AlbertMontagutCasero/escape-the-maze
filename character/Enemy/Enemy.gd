extends "res://character/Character.gd"


"""
 The code in the _ready() function serves an important purpose:
 because the enemies are added to the tree below the TileMap nodes,
 they'll be processed first
"""
func _ready():
	can_move = false
	facing = moves.keys()[randi() % 4] # select one direction 0 - 3
	print("Facing" +  str(facing) + " - _ready() Enemy.gd")
	yield(get_tree().create_timer(0.5), 'timeout') # Nice trick bro
	can_move = true


func _process(delta):
	if can_move:
		if not move(facing) or randi() % 10 > 5:
			facing = moves.keys()[randi() % 4]