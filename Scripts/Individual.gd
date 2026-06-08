class_name Individual
extends Node3D


var individuals_name : String
var id : int
var age : int
var alive : bool

var health : int
var level : int

var traits : Traits
var stats : Stats

func _init() -> void:
	stats = Stats.new()
	traits = Traits.new()
