/// @description Player variables

MAX_SPEED = 15
MIN_SPEED = 3
SPEED_REGENERATE = .5
// CONSTANTS (modifiable)
spd = 15
jumpspd = 14

//-- stunning mechanics --//
stunned = false;
// number of seconds before thistle can move again
STUN_RECOVER = .5;
stun_counter = 0;

VSP_CAP = 30
HSP_CAP = 20

GROUND_FRICTION = 0.75
AIR_FRICTION = 0.25

WALLJUMP_COOLDOWN = 35
WALLJUMP_KNOCK = 15

dashspd = 10
DASH_COOLDOWN = 1; // seconds

STAGE_1_LENGTH = 0.7
STAGE_2_LENGTH = 1.1
STAGE_3_LENGTH = 2.0

STAGE_2_ATTACK_WINDOW = 0.25
STAGE_3_ATTACK_WINDOW = 0.75


atk = 1
ATTACK_TIMEOUT = STAGE_2_ATTACK_WINDOW + STAGE_3_ATTACK_WINDOW + STAGE_3_LENGTH
//ATTACK_TIMEOUT = STAGE_1_LENGTH + STAGE_2_LENGTH
attackcounter = 0
attackpress = 0
attacking = false

// VARIABLES (best not to touch)

max_hp = 3;
hpiece_count = 0;
hp = 3;

hit_cooldown = 0;

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

// HURTBOX
hurtbox = draw_hurtbox(64, 64, -32, -32, true);