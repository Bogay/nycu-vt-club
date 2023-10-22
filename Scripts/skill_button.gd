class_name SkillButton
extends Button

func bind_skill(skill: Skill):
	if skill == null:
		text = 'None'
		disabled = true
		return

	text = skill.skill_name
	# TODO: add event listener

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
