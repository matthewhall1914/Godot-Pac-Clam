extends TileMap

var pellets_left
var tile
signal Victory

func _ready():
	pellets_left = 0
	for x in range(get_used_rect().size.x):
		for y in range(get_used_rect().size.y):
			tile = get_cell(x,y)
			if (tile == 1 or tile == 2):
				pellets_left += 1
		
func eat(pos):
	var curr_tile = world_to_map(pos)
	tile = get_cellv(curr_tile)
	if(tile == 1 or tile == 2):
		set_cellv(curr_tile, 0)
		pellets_left -= 1
		get_owner().get_node("PelletSound").play()
		if(tile == 2):
			get_tree().call_group("enemy", "weaken")
		if(pellets_left == 0):
			emit_signal("Victory")