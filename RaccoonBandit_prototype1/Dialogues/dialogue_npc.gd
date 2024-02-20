extends Control

var text_label: RichTextLabel

func _ready():
	text_label = $NinePatchRect/MarginContainer/Text

func update_text(text: String):
	text_label.bbcode_text = text

func show_dialogue():
	visible = true

func hide_dialogue():
	visible = false
