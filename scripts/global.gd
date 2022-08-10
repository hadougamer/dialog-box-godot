extends Node

var pre_dialog = preload("res://scenes/dialog.tscn")

func load_json( filename ):
  var file = File.new()
  var path = "res://dialogs/%s.json" % [filename]
  file.open(path, File.READ)
  var json = JSON.parse(file.get_as_text())
  
  return json.result.dialog

func load_dialog( npc, index ):
  var dialogs = load_json( npc.npc_id )
  npc.dialog_length=dialogs.size()

  if ! npc.dialog:
	  npc.dialog = pre_dialog.instance()
	  var ui = npc.get_parent().get_node("ui")
	  ui.add_child(npc.dialog)

  var char_id = dialogs[index].id
  var name = dialogs[index].name
  var message  = dialogs[index].message
  
  npc.dialog.set_image( char_id )
  npc.dialog.set_name( name )
  npc.dialog.set_message( message)

func close_dialog( npc ):
  var ui = npc.get_parent().get_node("ui")
  if ui.get_node("dialog"):
	  ui.get_node("dialog").queue_free()
	  npc.dialog=null
