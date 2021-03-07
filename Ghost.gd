extends Area2D

enum Direction { LEFT, RIGHT, UP, DOWN  }
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200
var screen_size
var direction = Direction.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	velocity.x = 0
	velocity.y = 0
	
	match direction:
		Direction.LEFT: 
			velocity.x = -1
		Direction.RIGHT:
			velocity.x = 1;
		Direction.UP:
			velocity.y = -1;
		Direction.DOWN:
			velocity.y = 1;
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	
	var rememberX = position.x
	var rememberY = position.y
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	var hitTheWall = rememberX!=position.x || rememberY!=position.y
	
	if hitTheWall:
		match direction:
			Direction.LEFT:
				direction = Direction.UP
			Direction.UP:
				direction = Direction.RIGHT
			Direction.RIGHT:
				direction = Direction.DOWN
			Direction.DOWN:
				direction= Direction.LEFT
				
		
		
