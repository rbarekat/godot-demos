extends RigidBody2D

var reset_state : bool = false

func _ready():
  _on_Timer_timeout()

func _on_Timer_timeout():
  reset_state = true
  linear_velocity = Vector2.ZERO
  $Timer.start()

func _integrate_forces(state):
  if reset_state:
    state.transform = Transform2D(0.0, Vector2(400, 400))
    reset_state = false
