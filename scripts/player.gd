extends KinematicBody2D

var speed = 200  # speed in pixels/sec
var velocity = Vector2.ZERO

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		$sprite.play("walk-right")
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		$sprite.play("walk-left")
	elif Input.is_action_pressed('ui_down'):
		velocity.y += 1
		$sprite.play("walk-down")
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		$sprite.play("walk-up")
	else:
		$sprite.set_frame(0)
		$sprite.stop()

	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
