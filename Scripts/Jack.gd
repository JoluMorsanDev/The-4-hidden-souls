extends KinematicBody2D

const aceleration = 4000
const max_speed = 600
const friction = .25

var motion = Vector2()
var x_input = 0
var y_input = 0
export var canmove = true
var weapon_detection = ""

#weapon vars
export (PackedScene) var DarkTome 

func _ready():
	if owner.name == "Lab":
		$AnimatedSprite.animation = "Before"
	$AnimatedSprite/Polygon2D.show_behind_parent = true

func _physics_process(delta):
	#get-inputs
	x_input = Input.get_action_strength("ui_right") -  Input.get_action_strength("ui_left")
	y_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#set the movement based on imputs
	if x_input != 0 and y_input != 0:
		motion.x += x_input * aceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		motion.y += y_input * aceleration * delta
		motion.y= clamp(motion.y, -max_speed, max_speed)
		if canmove == true:
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")
	elif x_input == 0 and y_input != 0:
		motion.y += y_input * aceleration * delta
		motion.y= clamp(motion.y, -max_speed, max_speed)
		motion.x = lerp(motion.x, 0, friction)
		if canmove == true:
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")
	elif x_input != 0 and y_input == 0:
		motion.x += x_input * aceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		motion.y = lerp(motion.y, 0, friction)
		if canmove == true:
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")
	elif x_input == 0 and y_input == 0:
		motion.x = lerp(motion.x, 0, friction)
		motion.y = lerp(motion.y, 0, friction)
		$AnimationPlayer.play("idle")
	if x_input > 0 and canmove == true:
		$AnimatedSprite.flip_h = false
		#scale.x = 1
	elif x_input < 0 and canmove == true:
		$AnimatedSprite.flip_h = true
		#scale.x = -1
	#movement
	if canmove == true:
		motion = move_and_slide(motion, Vector2.UP)
	else:
		motion = move_and_slide(Vector2(0,0))
	#Rigth-Click Interactions
	if Input.is_action_just_pressed("rightclick"):
		right_click()
	#Left-Click Interactions
	if Input.is_action_just_pressed("leftclick"):
		left_click()

func _on_ItemsDetection_area_entered(area):
	match area.name:
		"DarkTome":
			weapon_detection = "darktome"

# warning-ignore:unused_argument
func _on_ItemsDetection_area_exited(area):
	weapon_detection = ""

func right_click():
	if weapon_detection != "":
		hold_weapon()

func left_click():
	pass

func hold_weapon():
	match weapon_detection:
		"darktome":
			var darktome = DarkTome.instance()
			$Weapons.add_child(darktome)
