extends Node

var _needs_components: Array[ComponentNeeds] = []

func register_needs(needs: ComponentNeeds):
	if needs not in _needs_components:
		_needs_components.append(needs)

func unregister_needs(needs: ComponentNeeds):
	_needs_components.erase(needs)

func _process(delta: float):
	for needs in _needs_components:
		needs.update_decay(delta)
