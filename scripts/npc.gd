extends KinematicBody2D

var on_talk = false
var dialog_index = 0
var dialog_length = 0
var dialog = null

var start_posx = 0
var distance = 200

var last_action = "walk-right"
var action = "walk-right"

export var npc_id = 'myid'

func _ready():
	start_posx=int(global_position.x)

func finish_dialog():
	Global.close_dialog(self)
	action=last_action
	on_talk=false
	dialog_index=0

func load_next_dialog():
	print(get_tree().get_nodes_in_group("dialog").size())
	if (dialog_index < dialog_length) || dialog_length == 0:
		Global.load_dialog(self, dialog_index)
		dialog_index+=1
	else:
		finish_dialog()

func _process(delta):
	if on_talk:
		if Input.is_action_just_pressed('ui_action'):
			load_next_dialog()
	else:
		Global.close_dialog(self)
	
	if action == "talking":
		$sprite.set_frame(0)
		$sprite.stop()
	else:
		var pos_x = int(global_position.x)

		if( pos_x >= int(start_posx + distance)  ):
			action="walk-left"
		elif( pos_x <= start_posx ):
			action="walk-right"
		
		if( action == "walk-right"  ):
			global_position.x += 1.2
		elif( action == "walk-left" ):
			global_position.x -= 1.2
		
		$sprite.play(action)	

func _on_area_body_entered(body:Node):
	if body.is_in_group("player"):
		last_action=action
		action = "talking"
		on_talk=true

func _on_area_body_exited(body:Node):
	if body.is_in_group("player"):
		finish_dialog()
