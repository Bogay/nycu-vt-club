class_name Skill
extends Resource

@export var id: int
@export var skill_name: String
# TODO: use enum or class for `type` and `attribute`
@export var type: String
@export var attribute: String
@export var power: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
