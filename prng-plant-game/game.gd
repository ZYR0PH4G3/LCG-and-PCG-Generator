extends Node2D

@onready var camera = $Camera2D
@onready var parallax_bg = $Scrolling_Background
@onready var pot = $Pot
@onready var bud = $Bud
@onready var stem_line = $Stem

@export var camera_smooth_speed: float = 6.0

@export var climb_distance_per_click: float = 64.0

var current_bud_y: float
var target_camera_y: float
var current_stem_height: float = 0.0 

var active_demand: String = ""
var pcg_system: PCGPseudoRandomGenerator

func _ready():
	pcg_system = PCGPseudoRandomGenerator.new()
	
	camera.global_position = Vector2(576, 324)
	target_camera_y = camera.global_position.y
	current_bud_y = bud.global_position.y
	stem_line.size = Vector2(60.0, 0.0)
	stem_line.global_position.x = 576.0 - (stem_line.size.x / 2.0)
	
	stem_line.global_position.y = current_bud_y + bud.size.y

func _process(delta):
	target_camera_y = bud.global_position.y + 64.0
	camera.global_position.y = lerp(camera.global_position.y, target_camera_y, camera_smooth_speed * delta)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		grow_plant()

func grow_plant():
	current_bud_y -= climb_distance_per_click
	bud.global_position.y = current_bud_y
	current_stem_height += climb_distance_per_click
	stem_line.size = Vector2(60.0, current_stem_height)
	var stem_x = 576.0 - (stem_line.size.x / 2.0)
	var stem_y = current_bud_y + bud.size.y
	stem_line.global_position = Vector2(stem_x, stem_y)
	
	print("Plant growing cleanly! Total stalk height: ", current_stem_height)
