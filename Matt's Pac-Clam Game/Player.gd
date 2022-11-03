extends KinematicBody2D

#Declare Variables
var sprite
var speed
var direction
onready var walls = get_parent().get_node("Navigation2D/TileMap")

func _ready():
	sprite = get_node("AnimatedSprite")
	speed = 100
	direction = Vector2()
	sprite.play("moving")
	
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		direction = Vector2(0,-1)
		rotation_degrees = -90
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2(0,1)
		rotation_degrees = 90
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2(-1,0)
		rotation_degrees = 0
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2(1,0)
		rotation_degrees = 0
	
	if direction == Vector2(-1,0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
	var _temp = move_and_collide(direction * speed * delta)
	walls.eat(position)
