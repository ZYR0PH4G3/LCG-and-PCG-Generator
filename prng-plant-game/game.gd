extends Node2D
@onready var camera = $Camera2D
@onready var parallax_bg = $Scrolling_Background
@onready var  pot = $Pot
@onready var bud = $Bud

@export var camera_smooth_speed: float =4.0
@export var climb_distance: float = 32.0

var current_bud_y: float 
var target_camera_y: float

var pcg_system: PCGPseudoRandomGenerator

func _ready() -> void:
	pcg_system = PCGPseudoRandomGenerator.new()
	
	camera.global_position = Vector2(576,324)
	target_camera_y = camera.global_position.y
	
	current_bud_y=bud.global_position.y

func _process(delta: float) -> void:
	target_camera_y = bud.global_position.y + 64.0
	camera.global_position.y= lerp(camera.global_position.y, target_camera_y, camera_smooth_speed * delta)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		grow_plant()

func grow_plant():
	current_bud_y -= climb_distance
	bud.global_position.y=current_bud_y
	
	print("Climbing skyward! New Target Camera Y: ", target_camera_y)
