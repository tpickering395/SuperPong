extends Control


var score_left = 0
var score_right = 0
var stop = false
var speed = 138
var ai_pos = Vector2(Globals.width - 16, Globals.height / 2 + 4)


func _ready():
	
	$ball.position.x = Globals.width / 2 + 4
	$ball.position.y = Globals.height / 2 + 4
	
	$paddle_L.position.x = 16
	$paddle_L.position.y = Globals.height / 2 + 4
	
	$paddle_R.position.x = ai_pos[0]
	$paddle_R.position.y = ai_pos[1]
	if Globals.allowMusic:
		print_debug("MusicEngine at dB: " + str(Globals.musicVolume))
		$GameMusicPlayer.updateVolume(Globals.musicVolume)
		$GameMusicPlayer.play()
		
	if Globals.allowSound:
		$OpponentScorePlayer.updateVolume(Globals.effectVolume)
		$PlayerScorePlayer.updateVolume(Globals.effectVolume)
		
	pass # Replace with function body.

func _physics_process(delta):
	ai_pos = ai_pos.move_toward(Vector2($paddle_R.position.x, $ball.position.y), delta * speed)
	$paddle_R.position = ai_pos
	
	
	if $ball.position.x + 2 < 0:
		if(!$ball.stop):
			score_right += 1
			if Globals.allowSound:
				$OpponentScorePlayer.play()
		$ball._on_ui_score()
		$ball.velocity.x = 75
		$ball.velocity.y = 75
		
		$ui/score_R.text = str(score_right)
		if !$ui/score_R.text == "7":
			$ui._on_time_ball_reset_timeout()
		
		
	if $ball.position.x + 2 > Globals.width:
		if(!$ball.stop):
			score_left += 1
			if Globals.allowSound:
				$PlayerScorePlayer.play()
		$ball._on_ui_score()
		$ball.velocity.x = -75
		$ball.velocity.y = 75
		
		$ui/score_L.text = str(score_left)
		if !$ui/score_L.text == "7":
			$ui._on_time_ball_reset_timeout()
		
		
	if $ui/score_L.text == "7":
		$ball.stop = true
		$ui/ball_reset.hide()
		$ui/ColorRect.show()
		if !stop:
			$ui._on_timer_win_text_timeout()
			stop = true
			
	if $ui/score_R.text == "7":
		$ball.stop = true
		$ui/ball_reset.hide()
		$ui/ColorRect.show()
		if !stop:
			$ui._on_timer_win_text_timeout()
			stop = true
		


func _on_ui_respawn_ball():
	$ball.stop = false
	$ball.show()
	pass # Replace with function body.


func _on_ui_restart():
	score_left = 0 
	score_right = 0
	$ui/ball_reset.hide()
	$ui._on_time_ball_reset_timeout()
	stop = false
	$ui/ColorRect.hide()
	pass # Replace with function body.
