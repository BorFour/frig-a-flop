extends ProgressBar


@onready var frog_character: CharacterBody3D = $"../../../FrogCharacter"
@onready var theme_styles_fill =  self.get("theme_override_styles/fill")
# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_value = frog_character.MAX_JUMP_FORCE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the jump force value from the character node
	self.value = frog_character.jump_force
	
	# Change the color based on the percentage
	if self.value < frog_character.MIN_JUMP_FORCE:
		theme_styles_fill.bg_color = Color.DIM_GRAY
	elif self.value < self.max_value * 0.30:
		theme_styles_fill.bg_color = Color.GREEN_YELLOW
		theme_styles_fill.bg_color.s = 0.6   
		theme_styles_fill.bg_color.v = 0.8     
	elif self.value < self.max_value * 0.60:    
		theme_styles_fill.bg_color = Color.YELLOW     
		theme_styles_fill.bg_color.s = 0.6
		theme_styles_fill.bg_color.v = 0.8
	elif self.value < self.max_value * 0.90:          
		theme_styles_fill.bg_color = Color.ORANGE_RED    
		theme_styles_fill.bg_color.s = 0.7  
		theme_styles_fill.bg_color.v = 0.8
	elif self.value <= self.max_value:
		theme_styles_fill.bg_color = Color.DARK_RED
		theme_styles_fill.bg_color.s = 0.7
