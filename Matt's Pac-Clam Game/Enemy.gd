extends Area2D

onready var walls = get_parent().get_node("Navigation2D")
onready var player = get_parent().get_node("Player")
var path = []
var direction
var speed

func _ready():
	speed = 45
	direction = Vector2()
	path = walls.get_simple_path(position, player.position, false)
	get_node("weak").hide()
	randomize()
	
func _process(delta):
	direction = (path[0] - position).normalized()
	if(position.distance_to(path[0]) > 1):
		position += direction * speed * delta
	else:
		path.remove(0)
	if(path.size() == 0):
		path = walls.get_simple_path(position, player.position, false)


func _on_refresh_timeout():
	path = walls.get_simple_path(position, player.position, false)
	get_node("refresh").set_wait_time(rand_range(1,4))


func _on_Enemy_body_entered(body):
	if(body == player and get_node("debuff").time_left > 0):
		position = walls.get_node("TileMap").map_to_world(Vector2(10,10))
		path = walls.get_simple_path(position, player.position, false)
	elif(body == player):
		player.queue_free()
		get_node("refresh").stop()

func weaken():
	get_node("debuff").start()
	get_node("weak").show()
	get_node("normal").hide()

func _on_debuff_timeout():
	get_node("normal").show()
	get_node("weak").hide()
