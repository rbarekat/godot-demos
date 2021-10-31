extends KinematicBody2D

var reset_state : bool = false
var vel : Vector2 = Vector2.ZERO
var slave_position : Vector2
var slave_vel : Vector2

func _ready():
  _on_Timer_timeout()

func _on_Timer_timeout():
  reset_state = true
  vel = Vector2.ZERO
  $Timer.start()

func _process(delta):
  
  if get_tree().is_network_server():
    Network.update_ball_position(int(name), position)

  if is_network_master():    
    rset_unreliable('slave_position', position)
    rset_unreliable('slave_vel', vel)
    move_and_collide(vel)
    if reset_state:
      vel = Vector2.ZERO
      position = Vector2(400, 400)
      reset_state = false
  else:
    move_and_collide(vel)
    position = slave_position
  
  if get_tree().is_network_server():
    Network.update_position(int(name), position)

func init(start_position):
  global_position = start_position
