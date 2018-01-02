/// @description Global game event listeners.

//FIXME: !!!!!! SHOULD BE USED FOR DEBUGGING ONLY !!!!!
quit = gamepad_button_check(0, gp_select) || keyboard_check_pressed(vk_escape);
if (quit) game_end();