# The state machine's target object, node, etc
var target = null setget set_target, get_target

# Dictionary of states by state id
var states = {} setget set_states, get_states

# Dictionary of valid state transitions
var transitions = {} setget set_transitions, get_transitions

# Reference to current state object
var current_state = null setget set_current_state, get_current_state

# Internal current state object
var _current_state = DefaultState.new()

func set_target(target):
	"""
	Sets the target object, which could be a node or some other object that the states expect
	"""
	target = target
	for s in states: 
		s.set_target(target)

func get_target():
	"""
	Returns the target object (node, object, etc)
	"""
	return target

func set_states(states):
	"""
	Expects an array of state definitions to generate the dictionary of states
	"""
	for s in states:
		if s.id && s.state: 
			set_state(s.id, s.state.new())

func get_states():
	"""
	Returns the dictionary of states
	"""
	return states

func set_transitions(transitions):
	"""
	Expects an array of transition definitions to generate the dictionary of transitions
	"""
	for t in transitions:
		if t.state_id && t.to_states: 
			set_transition(t.state_id, t.to_states)

func get_transitions():
	"""
	Returns the dictionary of transitions
	"""
	return transitions

func set_current_state(state_id):
	"""
	This is a "just do it" method and does not validate transition change
	"""
	if state_id in states:
		current_state = state_id
		_current_state = states[state_id]
	else:
		print("Cannot set current state, invalid state: ", state_id)

func get_current_state():
	"""
	Returns the string id of the current state
	"""
	return current_state

class State:
	# State ID
	var id

	# Target for the state (object, node, etc)
	var target

	# Reference to state machine
	var state_machine

	# State machine callback called during transition when entering this state
	func _on_enter_state(): 
		pass

	# State machine callback called during transition when leaving this state
	func _on_leave_state(): 
		pass

class DefaultState extends State:
	"""
	Default state class to implement null object pattern for the state machine's current state
	"""
	func _process(delta): print("Unimplemented _process(delta)")
	func _fixed_process(delta): print("Unimplemented _fixed_process(delta)")
	func _input(event): print("Unimplemented _input(event)")