const int OwnTeleports_Cost = 0; //Mana Cost

var int OwnTeleports_lastPositionOne_X;
var int OwnTeleports_lastPositionOne_Y;
var int OwnTeleports_lastPositionOne_Z;

var int OwnTeleports_lastPositionTwo_X;
var int OwnTeleports_lastPositionTwo_Y;
var int OwnTeleports_lastPositionTwo_Z;

var int OwnTeleports_lastPositionThree_X;
var int OwnTeleports_lastPositionThree_Y;
var int OwnTeleports_lastPositionThree_Z;

func void OwnTeleports_FirstStart() { //Only at very first start of the Game
	PM_BindInt(OwnTeleports_lastPositionOne_X);
	PM_BindInt(OwnTeleports_lastPositionOne_Y);
	PM_BindInt(OwnTeleports_lastPositionOne_Z);
	
	PM_BindInt(OwnTeleports_lastPositionTwo_X);
	PM_BindInt(OwnTeleports_lastPositionTwo_Y);
	PM_BindInt(OwnTeleports_lastPositionTwo_Z);
	
	PM_BindInt(OwnTeleports_lastPositionThree_X);
	PM_BindInt(OwnTeleports_lastPositionThree_Y);
	PM_BindInt(OwnTeleports_lastPositionThree_Z);

	if (!Npc_HasItems(hero, NINJA_ITRU_TELEPORTER)) { //Give Player at very first start a rune
		CreateInvItem(hero, NINJA_ITRU_TELEPORTER);
		Snd_Play("MFX_BreathOfDeath_Cast");
		PrintScreen("Möge Beliar in seiner weißheit, dir diese Rune überreichen.", -1, -1, "FONT_OLD_10_WHITE.tga", 4);
	};
};

func int OwnTeleports_getHeroPos_X() {
	var oCNPC her; her = Hlp_GetNpc(hero);
	var int x_float; x_float = her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_X];
	var int pos; pos = roundf(x_float);
	return pos;
};

func int OwnTeleports_getHeroPos_Y() {
	var oCNPC her; her = Hlp_GetNpc(hero);	
	var int y_float; y_float = her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Y];
	var int pos; pos = roundf(y_float);
	return pos;
};

func int OwnTeleports_getHeroPos_Z() {
	var oCNPC her; her = Hlp_GetNpc(hero);
	var int z_float; z_float = her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Z];
	var int pos; pos = roundf(z_float);
	return pos;
};

func void OwnTeleports_saveHeroPos(var int posX, var int posY, var int posZ, var int lastPosNumber) {
	if (lastPosNumber == 1) {
		OwnTeleports_lastPositionOne_X = posX;
		OwnTeleports_lastPositionOne_Y = posY;
		OwnTeleports_lastPositionOne_Z = posZ;
	} else if (lastPosNumber == 2) {
		OwnTeleports_lastPositionTwo_X = posX;
		OwnTeleports_lastPositionTwo_Y = posY;
		OwnTeleports_lastPositionTwo_Z = posZ;
	} else if (lastPosNumber == 3) {
		OwnTeleports_lastPositionThree_X = posX;
		OwnTeleports_lastPositionThree_Y = posY;
		OwnTeleports_lastPositionThree_Z = posZ;
	};	
};

func void OwnTeleports_AI_TeleportPos(var int posNumber) {	
	var oCNPC her; her = Hlp_GetNpc(hero);
	
	if (posNumber == 1) {
		her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_X] = mkf(OwnTeleports_lastPositionOne_X);
		her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Y] = mkf(OwnTeleports_lastPositionOne_Y);
		her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Z] = mkf(OwnTeleports_lastPositionOne_Z);
	} else if (posNumber == 2) {
		her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_X] = mkf(OwnTeleports_lastPositionTwo_X);
		her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Y] = mkf(OwnTeleports_lastPositionTwo_Y);
		her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Z] = mkf(OwnTeleports_lastPositionTwo_Z);
	} else if (posNumber == 3) {
		her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_X] = mkf(OwnTeleports_lastPositionThree_X);
		her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Y] = mkf(OwnTeleports_lastPositionThree_Y);
		her._zCVob_trafoObjToWorld[zCVob_trafoObjToWorld_Z] = mkf(OwnTeleports_lastPositionThree_Z);
	};
};

func void OwnTeleports_playEndAni() {
	var C_NPC her; her = Hlp_GetNpc(hero);			
	AI_PlayAni(her, "T_HEASHOOT_2_STAND" );
	wld_playeffect("spellFX_Teleport_RING", her, her, 0, 0, 0, false);
	FF_Remove(OwnTeleports_playEndAni);	
};

/*func void OwnTeleport_debugTeleport() {
    if (MEM_KeyState (KEY_J) == KEY_PRESSED) {
		print(IntToString(OwnTeleports_lastPositionOne_X)); 
		print(IntToString(OwnTeleports_lastPositionOne_Y));
		print(IntToString(OwnTeleports_lastPositionOne_Z)); 
	};
};*/