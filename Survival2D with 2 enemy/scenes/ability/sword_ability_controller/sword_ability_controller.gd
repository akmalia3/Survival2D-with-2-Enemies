extends Node

const MAX_RANGE = 150

@export var sword_ability: PackedScene
@export var sword_ability2: PackedScene

func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2))

	if enemies.size() == 0:
		return
			
	var enemies2 = get_tree().get_nodes_in_group("enemy2")
	enemies2 = enemies2.filter(func(enemy2: Node2D):
		return enemy2.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2))
	
	if enemies2.size() == 0:
		return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	enemies2.sort_custom(func(c: Node2D, d: Node2D):
		var c_distance = c.global_position.distance_squared_to(player.global_position)
		var d_distance = d.global_position.distance_squared_to(player.global_position)
		return c_distance < d_distance
	)	

	var sword_instance = sword_ability.instantiate() as Node2D
	var sword_instance2 = sword_ability.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	player.get_parent().add_child(sword_instance2)
	sword_instance.global_position = enemies[0].global_position
	sword_instance2.global_position = enemies2[0].global_position
