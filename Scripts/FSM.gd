extends Node

enum states {RESET, LEFT1, LEFT2, RIGHT1, RIGHT2}
enum events {LEFT, RIGHT}

var registered_states = []
var current_state = null
var next_state = null

func add_state(state, allowed):	
	var s = State.new()
	s.current = state
	s.allowed = allowed
	registered_states.append(s)

func handle(event):
	var state = registered_states[current_state]
	for link in state.allowed:
		if link.event == events.LEFT:
			current_state = state.allowed[events.LEFT].state
		if link.event == events.RIGHT:
			current_state = state.allowed[events.RIGHT].state
		


	
class State:
	var current = null
	var allowed = [{"event":null, "state":null}]
	
