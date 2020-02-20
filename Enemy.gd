extends KinematicBody2D

export var limit_y = 350
export var score = 10
export var speed = 2
export var move_probability = 0.07
export var fire_probability = 0.3

onready var Bullet2 = load("res://Scenes/Bullet2")

var ready = false
var new_position = Vector2(0,0)

func get_new_position():
	var VP = get_viewport_rect().size
	new_position.x = randi() % int(VP.x)
	new_position.y = min(randi() % int(VP.y), int(VP.y) - limit_y)
	$Tween.interpolate_property(self, "position", position, new_position, speed, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	ready = true

func die():
	queue_free()

func _ready():
	randomize()
	get_new_position()
	
# warning-ignore:unused_argument
func _physics_process(delta):
	if ready:
		$Tween.start()
		ready = false

func _on_Timer_timeout():
	if randf() < move_probability:
		get_new_position()
	if randf() < fire_probability:
		var b = Bullet2.instance()
		b.position = position 
		b.position.y += 25
		get_node("/root/Game/Bullet2").add_child(b)
