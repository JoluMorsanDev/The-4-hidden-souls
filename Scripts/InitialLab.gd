extends Node2D


export var min_cam_x = 640
export var max_cam_x = 3680
export var min_cam_y = 360
export var max_cam_y = 2400

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.global_position = Vector2(min_cam_x*$Camera2D.zoom.x, min_cam_y*$Camera2D.zoom.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if $Jack.position.x > min_cam_x*$Camera2D.zoom.x and $Jack.position.x < max_cam_x - min_cam_x*$Camera2D.zoom.x:
		$Camera2D.global_position.x = $Jack.global_position.x
	if $Jack.position.y > min_cam_y*$Camera2D.zoom.y and $Jack.position.y < max_cam_y - min_cam_y*$Camera2D.zoom.y:
		$Camera2D.global_position.y = $Jack.global_position.y
	
	if Input.is_action_just_released("ZoomUp") and $Camera2D.zoom < Vector2(1.5,1.5):
		$Camera2D.zoom += Vector2(.25,.25)
	
		#$Camera2D.global_position = Vector2(min_cam_x*$Camera2D.zoom.x, min_cam_y*$Camera2D.zoom.y)
		$Camera2D.global_position.x = clamp($Jack.global_position.x, min_cam_x*$Camera2D.zoom.x, max_cam_x - min_cam_x*$Camera2D.zoom.x)
		$Camera2D.global_position.y = clamp($Jack.global_position.y, min_cam_y*$Camera2D.zoom.y, max_cam_y - min_cam_y*$Camera2D.zoom.y)
		if $Jack.position.x > min_cam_x*$Camera2D.zoom.x and $Jack.position.x < max_cam_x - min_cam_x*$Camera2D.zoom.x:
			$Camera2D.global_position.x = $Jack.global_position.x
	
		if $Jack.position.y > min_cam_y*$Camera2D.zoom.y and $Jack.position.y < max_cam_y - min_cam_y*$Camera2D.zoom.y:
			$Camera2D.global_position.y = $Jack.global_position.y
	
	if Input.is_action_just_released("ZoomDown") and $Camera2D.zoom > Vector2(.75,.75):
		$Camera2D.zoom -= Vector2(.25,.25)
		#$Camera2D.global_position = Vector2(min_cam_x*$Camera2D.zoom.x, min_cam_y*$Camera2D.zoom.y)
		$Camera2D.global_position.x = clamp($Jack.global_position.x, min_cam_x*$Camera2D.zoom.x, max_cam_x - min_cam_x*$Camera2D.zoom.x)
		$Camera2D.global_position.y = clamp($Jack.global_position.y, min_cam_y*$Camera2D.zoom.y, max_cam_y - min_cam_y*$Camera2D.zoom.y)
		if $Jack.position.x > min_cam_x*$Camera2D.zoom.x and $Jack.position.x < max_cam_x - min_cam_x*$Camera2D.zoom.x:
			$Camera2D.global_position.x = $Jack.global_position.x
		
		if $Jack.position.y > min_cam_y*$Camera2D.zoom.y and $Jack.position.y < max_cam_y - min_cam_y*$Camera2D.zoom.y:
			$Camera2D.global_position.y = $Jack.global_position.y
	if Input.is_action_just_pressed("ui_select"):
		skipcutscene()

func cutscenedialog():
	$AnimationPlayer.play("Start")

func _on_Portal_area_entered(area):
	if area.owner.name == "Jack":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/DeadworldNexus.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Prologue":
		cutscenedialog()

func skipcutscene():
	if $AnimationPlayer.current_animation_length > 2 and $AnimationPlayer.current_animation_position < 8:
		$AnimationPlayer.playback_speed = 500
		yield(get_tree().create_timer(.1),"timeout")
		$AnimationPlayer.playback_speed = 1
		
