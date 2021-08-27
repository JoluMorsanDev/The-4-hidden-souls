extends KinematicBody2D

const aceleration = 4000
const max_speed = 600
const friction = .25

var motion = Vector2()
var x_input = 0
var y_input = 0

func _ready():
	$AnimatedSprite/Polygon2D.show_behind_parent = true

func _physics_process(delta):
	x_input = Input.get_action_strength("ui_right") -  Input.get_action_strength("ui_left")
	y_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if x_input != 0 and y_input != 0:
		motion.x += x_input * aceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		motion.y += y_input * aceleration * delta
		motion.y= clamp(motion.y, -max_speed, max_speed)
		$AnimationPlayer.play("walk")
	elif x_input == 0 and y_input != 0:
		motion.y += y_input * aceleration * delta
		motion.y= clamp(motion.y, -max_speed, max_speed)
		motion.x = lerp(motion.x, 0, friction)
		$AnimationPlayer.play("walk")
	elif x_input != 0 and y_input == 0:
		motion.x += x_input * aceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		motion.y = lerp(motion.y, 0, friction)
		$AnimationPlayer.play("walk")
	elif x_input == 0 and y_input == 0:
		motion.x = lerp(motion.x, 0, friction)
		motion.y = lerp(motion.y, 0, friction)
		$AnimationPlayer.play("idle")
	if x_input > 0:
		$AnimatedSprite.flip_h = false
		#scale.x = 1
	elif x_input < 0:
		$AnimatedSprite.flip_h = true
		#scale.x = -1
	motion = move_and_slide(motion, Vector2.UP)
