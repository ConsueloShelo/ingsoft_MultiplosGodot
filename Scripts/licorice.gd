extends Node2D

export (int) var health = 1

func _ready():
	pass # Replace with function body.

func take_damage(damage):
	health -= damage
	
