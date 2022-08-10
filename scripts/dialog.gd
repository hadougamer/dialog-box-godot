extends Node2D

func set_image( npc_id ):
	var filename = "res://assets/images/%s.png" % npc_id
	var texture = load(filename)

	print(filename)
	$"Control/picture".set_texture( texture )

func set_name( name ):
	$"Control/charName".text=name

func set_message( message ):
	$"Control/charMessage".text=message
