extends Node2D

export (Texture) var CharSpr
export var CharScale = Vector2(1,1)
export (Color) var CharColor = Color8(255,255,255,255)
export (Texture) var BoxSpr
export var BoxScale = Vector2(1,1)
export (Color) var BoxColor = Color8(255,255,255,255)
export var text1 = ""
export var text2 = ""
export var text3 = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialog.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	#Defining the apeareance of the dialog
	$Dialog/CharTalking.texture = CharSpr
	$Dialog/CharTalking.scale.x = CharScale.x
	$Dialog/CharTalking.scale.y = CharScale.y
	$Dialog/CharTalking.modulate = CharColor
	$Dialog/DialogBox.texture = BoxSpr
	$Dialog/DialogBox.scale.x = BoxScale.x
	$Dialog/DialogBox.scale.y = BoxScale.y
	$Dialog/DialogBox.modulate = BoxColor
	$Dialog/Text1.text = text1
	$Dialog/Text2.text = text2
	$Dialog/Text3.text = text3
