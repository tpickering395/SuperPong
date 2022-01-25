extends Control


var score_left = 0
var score_right = 0
var stop = false
var speed = 170
var ai_pos = Vector2(Globals.width - 16, Globals.height / 2 + 4)
var pTimer = 0.5
var cCounter = 3
var rng = RandomNumberGenerator.new()
var powerup = 4


func _ready():
	rng.randomize()
	$ball.position.x = Globals.width / 2 + 4
	$ball.position.y = Globals.height / 2 + 4
	
	$NewBall.position.x = Globals.width / 2 + 4
	$NewBall.position.y = Globals.height / 2 + 4
	
	$paddle_L.position.x = 16
	$paddle_L.position.y = Globals.height / 2 + 4
	
	$paddle_R.position.x = ai_pos[0]
	$paddle_R.position.y = ai_pos[1]
	

func _physics_process(delta):
	if $ball.position.x >= $NewBall.position.x:
		ai_pos = ai_pos.move_toward(Vector2($paddle_R.position.x, $ball.position.y), speed*delta)
	else:
		if $NewBall.stop == true:
			ai_pos = ai_pos.move_toward(Vector2($paddle_R.position.x, $ball.position.y), speed*delta)
		else:
			ai_pos = ai_pos.move_toward(Vector2($paddle_R.position.x, $NewBall.position.y), speed*delta)
	$paddle_R.position = ai_pos
	
	if cCounter == 3:
		if $"Extra Ball".used:
			powerup = rng.randi_range(0,1)
		else:
			powerup = rng.randi_range(0,2)
		var quad = rng.randi_range(0,3)
		# fire hoop
		if powerup == 0:
			if quad == 0:
				$"Fire Hoop".position.x = 100
				$"Fire Hoop".position.y = 75
			elif quad == 1:
				$"Fire Hoop".position.x = 190
				$"Fire Hoop".position.y = 75
			elif quad == 2:
				$"Fire Hoop".position.x = 75
				$"Fire Hoop".position.y = 175
			else:
				$"Fire Hoop".position.x = 190
				$"Fire Hoop".position.y = 190
		
		# boomerang
		# quad 0 = top left, quad 1 = top right, quad 2 = bottom left, quad 3 = bottom right
		if powerup == 1:
			if quad == 0:
				$"Boomerang".position.x = 100
				$"Boomerang".position.y = 75
			elif quad == 1:
				$"Boomerang".position.x = 190
				$"Boomerang".position.y = 75
			elif quad == 2:
				$"Boomerang".position.x = 75
				$"Boomerang".position.y = 175
			else:
				$"Boomerang".position.x = 190
				$"Boomerang".position.y = 190
		
		# extra ball
		if powerup == 2:
			if quad == 0:
				$"Extra Ball".position.x = 100
				$"Extra Ball".position.y = 75
			elif quad == 1:
				$"Extra Ball".position.x = 190
				$"Extra Ball".position.y = 75
			elif quad == 2:
				$"Extra Ball".position.x = 75
				$"Extra Ball".position.y = 175
			else:
				$"Extra Ball".position.x = 190
				$"Extra Ball".position.y = 190
			$"Extra Ball".used = true
		cCounter = 0
	
	if $ball.position.x + 2 < 0 or $NewBall.position.x + 2 < 0:
		if(!$ball.stop or !$NewBall.stop and pTimer > 0.5):
			pTimer = 0
			score_right += 1
		$ball._on_ui_score()
		$NewBall._on_ui_score()
		$"Extra Ball".position.x = 1000
		$"Fire Hoop".position.x = 1000
		$Boomerang.position.x = 1000
		$ball.velocity.x = -45
		$ball.velocity.y = 45
		$NewBall.velocity.x = -45
		$NewBall.velocity.y = 45
		
		$ui/score_R.text = str(score_right)
		if !$ui/score_R.text == "7":
			$ui._on_time_ball_reset_timeout()
	
	if $ball.position.x + 2 > Globals.width or $NewBall.position.x + 2 > Globals.width:
		if(!$ball.stop or !$NewBall.stop and pTimer > 0.5):
			pTimer = 0
			score_left += 1
		$ball._on_ui_score()
		$NewBall._on_ui_score()
		$"Extra Ball".position.x = 1000
		$"Fire Hoop".position.x = 1000
		$Boomerang.position.x = 1000
		$ball.velocity.x = 45
		$ball.velocity.y = 45
		$NewBall.velocity.x = 45
		$NewBall.velocity.y = 45
		
		$ui/score_L.text = str(score_left)
		if !$ui/score_L.text == "7":
			$ui._on_time_ball_reset_timeout()
		
		
	if $ui/score_L.text == "7":
		$ball.stop = true
		$NewBall.stop = true
		$ui/ball_reset.hide()
		$ui/ColorRect.show()
		if !stop:
			$ui._on_timer_win_text_timeout()
			stop = true
			
	if $ui/score_R.text == "7":
		$ball.stop = true
		$NewBall.stop = true
		$ui/ball_reset.hide()
		$ui/ColorRect.show()
		if !stop:
			$ui._on_timer_win_text_timeout()
			stop = true
	pTimer += delta


func _on_ui_respawn_ball():
	$ball.stop = false
	$ball.show()
	$ball/CollisionShape2D.disabled = false


func _on_ui_restart():
	score_left = 0 
	score_right = 0
	$ui/ball_reset.hide()
	$ui._on_time_ball_reset_timeout()
	stop = false
	$ui/ColorRect.hide()
