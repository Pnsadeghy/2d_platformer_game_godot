extends StaticBody2D

var state_machine
var idle_state
var hit_state
var fire_state

@onready var animator := $AnimatedSprite2D
@onready var fire_timer := $FireTimer
@onready var hit_area := $HitArea

func _ready():
	const StateMachine = preload("res://modules/state_machine/StateMachine.gd")
	state_machine = StateMachine.new(self)
	
	const IdleState = preload("res://entities/fire/states/FireIdleState.gd")
	const HitState = preload("res://entities/fire/states/FireHitState.gd")
	const FireState = preload("res://entities/fire/states/FireOnState.gd")
	
	idle_state = IdleState.new(state_machine, self)
	hit_state = HitState.new(state_machine, self)
	fire_state = FireState.new(state_machine, self)
	
	animator.animation_finished.connect(state_machine.on_animation_finished)
	state_machine.change_state(idle_state)


func _on_delete_area_body_entered(body):
	idle_state.on_detected()

func _on_fire_timer_timeout():
	fire_state.on_timeout()

func play_animation(name: String):
	animator.play(name)
	
func set_hitarea(enable: bool):
	hit_area.monitorable = enable
	hit_area.monitoring = enable
