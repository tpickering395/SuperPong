extends CanvasLayer

signal score
signal respawn_ball
signal restart

var reset_time = 0 
var gameend_time = 0 
var score = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_time_ball_reset_timeout()
	pass # Replace with function body.

func _process(delta):
	
	if reset_time > 0:
		reset_time -= delta
		$ball_reset.text = "Ball will spawn in " + str(round(reset_time)) + " seconds"
	if reset_time < 0:
		reset_time = 0 
		score = true
		$ball_reset.text = "Ball will spawn in " + str(reset_time) + " seconds"
		$ball_reset.hide()
		emit_signal("respawn_ball")
		
	if gameend_time > 0 && $score_L.text == "7":
		gameend_time -= delta
		$win_text.text = "Left player Wins! Would you like to play again? Y/N\n" + str(round(gameend_time)) + " seconds"
		if(Input.is_action_pressed("ui_accept")):
			emit_signal("restart")
			gameend_time = 0 
			$score_L.text = "0"
			$score_R.text = "0"
			$win_text.text = ""
		elif gameend_time < 0:
			get_tree().quit()
			
	if gameend_time > 0 && $score_R.text == "7":
		gameend_time -= delta
		$win_text.text = "Right player Wins! Would you like to play again? Y/N\n" + str(round(gameend_time)) + " seconds"
		if(Input.is_action_just_pressed("ui_accept")):
			emit_signal("restart")
			gameend_time = 0 
			$score_L.text = "0"
			$score_R.text = "0"
			$win_text.text = ""
		elif Input.is_action_just_pressed("ui_cancel"):
			get_tree().quit()
		elif gameend_time < 0:
			get_tree().quit()
	
	pass


func _on_time_ball_reset_timeout():
	reset_time = 3
	$ball_reset.text = "Ball will spawn in " + str(reset_time) + " seconds"
	$ball_reset.show()
	pass # Replace with function body.


func _on_timer_win_text_timeout():
	gameend_time = 10 
	$ColorRect.show()
	if $score_L.text == "7":
		$win_text.text = "Left player wins would you like to play again Y/N\n" + str(gameend_time) + " seconds"
	if $score_R.text == "7":
		$win_text.text = "Right player wins would you like to play again Y/N\n" + str(gameend_time) + " seconds"
	pass # Replace with function body.
