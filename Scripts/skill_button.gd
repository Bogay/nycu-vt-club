class_name SkillButton
extends Button

var callback

func bind_skill(skill: Skill):
	clear_binding()

	if skill == null:
		text = '-'
		disabled = true
		return

	text = skill.skill_name
	disabled = false
	# FIXME: hard-coded target
	callback = func ():
		skill.cast(General.enemy_party[0])
	assert(pressed.connect(callback) == OK)

func clear_binding():
	if callback != null:
		assert(pressed.is_connected(callback))
		pressed.disconnect(callback)
	callback = null
