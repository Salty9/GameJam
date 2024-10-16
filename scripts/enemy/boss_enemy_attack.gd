extends State


@export var axes:Array[Node2D]

@export var cooldown_time:float = 2

func _ready():
	super._ready()
	$Timer.timeout.connect(on_timer_timeout)
	
	for axe in axes:
		axe.thrown.connect(on_axe_thrown)

func on_axe_thrown(thrown_axe:Projectile):
	thrown_axe.scale *= 1

func enter():
	super.enter()
	$Timer.wait_time = cooldown_time
	for axe in axes:
		axe.visible = true


func throw_axe():
	var player:Character = get_tree().get_first_node_in_group("player_group")
	if player == null:
		return
	for axe in axes:
		if axe.axe_count > 0:
			axe.throw((player.global_position - global_position ).normalized())
			break

func on_timer_timeout():
	if not enabled or axes.is_empty():
		return
	
	throw_axe()


func exit():
	super.exit()
	for axe in axes:
		axe.visible = false
