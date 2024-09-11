@tool
extends HBoxContainer
class_name SegmentedProgressBar

@export var texture:Texture2D:
	set(v):
		texture = v
		value = value

@export_range(1,100) var segments := 1:
	set(v):
		for x in get_children():
			x.queue_free()
		for x in v:
			var t := TextureRect.new()
			t.size_flags_horizontal = 3
			t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			t.texture = texture
			add_child(t)
		segments = v
		value = value
			
@export_range(0.0,1.0) var value = 0.0:
	set(v):
		for n in get_child_count():
			if n < v * segments:
				get_child(n).texture = texture
			else:
				get_child(n).texture = null
		value = v
			
			
