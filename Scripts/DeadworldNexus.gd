extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.global_position = Vector2(640*$Camera2D.zoom.x, 360*$Camera2D.zoom.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if $Jack.position.x > 640*$Camera2D.zoom.x:
		$Camera2D.global_position.x = $Jack.global_position.x
	if $Jack.position.y > 360*$Camera2D.zoom.y:
		$Camera2D.global_position.y = $Jack.global_position.y
