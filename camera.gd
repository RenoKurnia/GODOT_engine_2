extends Camera2D
export var target = "../Player"
export var forward_offset = 50
export var min_x_offset = 60
export var max_y_offset = 5
export var x_smoothing = .05
export var y_smoothing = .1
onready var target_node = get_node(target)
func _ready():
	OS.set_window_maximized(true)
	var pos = target_node.get_pos()
	pos = Vector2((pos.x), (pos.y))
	set_pos(pos)
	set_fixed_process(true)
func _fixed_process(delta):
	var target_pos = target_node.get_center_pos() + Vector2(1, 0) * target_node.facing_dir * forward_offset
	#print(target_pos.x)
	target_pos.x = lerp(get_pos().x, target_pos.x+min_x_offset*target_node.facing_dir, x_smoothing)	
	#gap it when the next position is out of bound
	#error
	if abs(target_pos.x - target_node.get_center_pos().x) > forward_offset:
		target_pos.x = target_node.get_center_pos().x - target_node.facing_dir * forward_offset * -1
	target_pos.y = lerp(get_pos().y, target_pos.y + max_y_offset, y_smoothing)
	if abs(target_pos.y - target_node.get_center_pos().y) > max_y_offset:
		target_pos.y =  target_node.get_center_pos().y + (sign(target_pos.y - target_node.get_center_pos().y) * max_y_offset)
	#set_pos(Vector2((target_node.get_pos().x), (target_node.get_pos().y)))
	set_pos(Vector2(target_pos.x,target_pos.y))