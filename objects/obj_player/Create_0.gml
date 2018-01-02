/// @description Player variables

MAX_SPEED = 15
MIN_SPEED = 3
SPEED_REGENERATE = .5
// CONSTANTS (modifyable)
spd = 15
jumpspd = 14

VSP_CAP = 30
HSP_CAP = 20

GROUND_FRICTION = 0.75
AIR_FRICTION = 0.25

WALLJUMP_COOLDOWN = 35
WALLJUMP_KNOCK = 15

dashspd = 10
DASH_COOLDOWN = 1; // seconds

STAGE_1_LENGTH = 0.7
STAGE_2_LENGTH = 0.9
STAGE_3_LENGTH = 1.0

STAGE_2_ATTACK_WINDOW = 0.4
STAGE_3_ATTACK_WINDOW = 0.5

atk = 1
ATTACK_TIMEOUT = STAGE_2_ATTACK_WINDOW + STAGE_3_ATTACK_WINDOW + STAGE_3_LENGTH
attackcounter = 0
attackpress = 0
attacking = false

// VARIABLES (best not to touch)
hsp = 0
vsp = 0
jumping = false
jumpcounter = 0
canwalljump = true
walljumpcounter = 0
walljumping = false
dashcounter = 0
dashing = false
grav = 0.8

