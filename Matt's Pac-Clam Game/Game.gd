extends Node2D


func _ready():
	get_node("UI/Lose").hide()
	get_node("UI/Win").hide()
	get_node("UI/Restart").hide()


func _on_Restart_pressed():
	var _temp = get_tree().reload_current_scene()


func _on_Player_tree_exiting():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()
	var pell_left = get_node("Navigation2D/TileMap").pellets_left
	get_node("UI/Lose").text += str(pell_left)
	get_node("UI/Lose").show()
	get_node("UI/Restart").show()
	get_node("BGM").stop()
	get_node("GameOver").play()


func _on_TileMap_Victory():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()
	get_node("UI/Win").show()
	get_node("UI/Restart").show()


