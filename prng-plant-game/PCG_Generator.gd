class_name PCGPseudoRandomGenerator
extends RefCounted

var a: int=6364136223846793005
var c:int=1442695040888963407
var state: int

func __init__(seed_val=null):
	if seed_val==null:
		var system_time=int(Time.get_unix_time_from_system()*1000)
		var process_mix=int(ResourceLoader.get_instance_id()) << 32
		state = process_mix^system_time
	else:
		state = int(seed_val)
	state = (a*state+c)
	
func generate_number(num_range=null):
	state = (a*state+c)
	var rot:int = (state>>59) & 0x1F
	var state_shifted_18= (state>>18)^state
	var xorshifted:int=(state_shifted_18>>27)&0xFFFFFFFF
	var left_shift = (-rot) & 31
	var pcg_output: int = ((xorshifted>>rot) | (xorshifted<<left_shift)) & 0xFFFFFFFF
	if num_range == null:
		return pcg_output
	else:
		var max_32_bit_float: float=4294967295.0
		var progress: float= float(pcg_output)/max_32_bit_float
		var scaled: float= progress*(num_range[1]-num_range[0])+num_range[0]
		return int(scaled)
