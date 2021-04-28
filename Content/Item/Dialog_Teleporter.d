const int OwnTeleports_PositionsOne = TRUE;
const int OwnTeleports_PositionsTwo = TRUE;
const int OwnTeleports_PositionsThree = TRUE;
const int OwnTeleports_PosSaveMenu = TRUE;
const int OwnTeleports_SaveMenuBack = TRUE;
const int OwnTeleports_SaveMenuEnd = TRUE;

const int OwnTeleports_dialogHasStarted = FALSE;


//*******************************************************!!!!!
// Dialog Script beginns here
//*******************************************************!!!!!
func void OwnTeleports_startDialog() {
	var C_NPC her; her = Hlp_GetNpc(self);
	if (Hlp_GetInstanceID(self)==Hlp_GetInstanceID(her) && !Npc_HasItems(her, NINJA_ITRU_TELEPORTER)) {
		self.aivar[AIV_INVINCIBLE] = TRUE; //Gegner greifen nicht an, solange der self im Auswahlmodus ist
		OwnTeleports_dialogHasStarted = TRUE;
		Ai_ProcessInfos(her); //Dialog wird gestartet
	};
};

//*******************************************************
// OwnTeleports_lastPosition Dialog Position 1 Teleportieren
//*******************************************************
instance DIA_OwnTeleports_lastPositionOne12345(C_Info) {
	npc = PC_Hero;
	nr = 1;
	condition = DIA_OwnTeleports_lastPositionOne_Condition1234;
	information = DIA_OwnTeleports_lastPositionOne_Info1234;
	permanent	= TRUE;
	description = "Teleport 1";
};

func int DIA_OwnTeleports_lastPositionOne_Condition1234 () {
	if(OwnTeleports_PositionsOne == TRUE) && OwnTeleports_dialogHasStarted {
		return TRUE;
	} else {
		return FALSE;
	};
};

func void DIA_OwnTeleports_lastPositionOne_Info1234() {
	if (!OwnTeleports_lastPositionOne_X == 0) {
		if (self.attribute[ATR_MANA] > OwnTeleports_Cost - 1) {
			AI_StopProcessInfos(self);
			wld_playeffect("spellFX_Teleport_RING", self, self, 0, 0, 0, false);	
			AI_PlayAni (self,"T_MAGRUN_2_HEASHOOT");
			FF_ApplyExtData(OwnTeleports_AI_TeleportPos, 2000, 1, 1);
			FF_ApplyExt(OwnTeleports_playEndAni, 2000, 1);		
			wld_playeffect("FX_EarthQuake", self, self, 0, 0, 0, false);
			wld_playeffect("SFX_Circle", self, self, 0, 0, 0, false);
			Snd_Play ("MFX_TELEPORT_CAST");

			self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - OwnTeleports_Cost;
			self.aivar[AIV_INVINCIBLE] = FALSE; //Gegner greifen wieder an

			CreateInvItem(self, NINJA_ITRU_TELEPORTER);
			OwnTeleports_dialogHasStarted = FALSE;
		} else {
			PrintScreen("Nicht genug Mana", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
		};
	} else {
		PrintScreen("Keine Position gespeichert", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
	};
};


//*******************************************************
// OwnTeleports_lastPosition Dialog Position 2 Teleportieren
//*******************************************************
instance DIA_OwnTeleports_lastPositionTwo(C_Info) {
	npc = PC_Hero;
	nr = 2;
	condition = DIA_OwnTeleports_lastPositionTwo_Condition;
	information = DIA_OwnTeleports_lastPositionTwo_Info;
	permanent	= TRUE;
	description = "Teleport 2";
};

func int DIA_OwnTeleports_lastPositionTwo_Condition () {
	if(OwnTeleports_PositionsTwo == TRUE && OwnTeleports_dialogHasStarted) {
		return TRUE;
	} else {
		return FALSE;
	};
};

func void DIA_OwnTeleports_lastPositionTwo_Info() {
	if (!OwnTeleports_lastPositionTwo_X == 0) {
		if (self.attribute[ATR_MANA] > OwnTeleports_Cost - 1) {
			AI_StopProcessInfos(self);

			wld_playeffect("spellFX_Teleport_RING", self, self, 0, 0, 0, false);	
			AI_PlayAni (self,"T_MAGRUN_2_HEASHOOT");
			FF_ApplyExtData(OwnTeleports_AI_TeleportPos, 2000, 1, 2);
			FF_ApplyExt(OwnTeleports_playEndAni, 2000, 1);		
			wld_playeffect("FX_EarthQuake", self, self, 0, 0, 0, false);
			wld_playeffect("SFX_Circle", self, self, 0, 0, 0, false);
			Snd_Play("MFX_TELEPORT_CAST");

			self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - OwnTeleports_Cost;
			self.aivar[AIV_INVINCIBLE] = FALSE; //Gegner greifen wieder an

			CreateInvItem(self, NINJA_ITRU_TELEPORTER);
			OwnTeleports_dialogHasStarted = FALSE;
		} else {
			PrintScreen("Nicht genug Mana", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
		};
	} else {
		PrintScreen("Keine Position gespeichert", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
	};
};



//*******************************************************
// OwnTeleports_lastPosition Dialog Position 3 Teleportieren
//*******************************************************
instance DIA_OwnTeleports_lastPositionThree(C_Info) {
	npc = PC_Hero;
	nr = 3;
	condition = DIA_OwnTeleports_lastPositionThree_Condition;
	information = DIA_OwnTeleports_lastPositionThree_Info;
	permanent	= TRUE;
	description = "Teleport 3";
};

func int DIA_OwnTeleports_lastPositionThree_Condition () {
	if(OwnTeleports_PositionsThree == TRUE && OwnTeleports_dialogHasStarted) {
		return TRUE;
	} else {
		return FALSE;
	};
};

func void DIA_OwnTeleports_lastPositionThree_Info() {
	if (!OwnTeleports_lastPositionThree_X == 0) {
		if (self.attribute[ATR_MANA] > OwnTeleports_Cost - 1) {
			AI_StopProcessInfos(self);

			wld_playeffect("spellFX_Teleport_RING", self, self, 0, 0, 0, false);	
			AI_PlayAni (self,"T_MAGRUN_2_HEASHOOT");
			FF_ApplyExtData(OwnTeleports_AI_TeleportPos, 2000, 1, 3);
			FF_ApplyExt(OwnTeleports_playEndAni, 2000, 1);		
			wld_playeffect("FX_EarthQuake", self, self, 0, 0, 0, false);
			wld_playeffect("SFX_Circle", self, self, 0, 0, 0, false);
			Snd_Play ("MFX_TELEPORT_CAST");

			self.attribute[ATR_MANA] = self.attribute[ATR_MANA] - OwnTeleports_Cost;
			self.aivar[AIV_INVINCIBLE] = FALSE; //Gegner greifen wieder an

			CreateInvItem(self, NINJA_ITRU_TELEPORTER);
			OwnTeleports_dialogHasStarted = FALSE;
		} else {
			PrintScreen("Nicht genug Mana", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
		};
	} else {
		PrintScreen("Keine Position gespeichert", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
	};
};



//*******************************************************
// OwnTeleports_getLastPosition Dialog Aktuelle Position Speichern
//*******************************************************
instance DIA_OwnTeleports_getLastPosition(C_Info) {
	npc = PC_Hero;
	nr = 4;
	condition = DIA_OwnTeleports_getLastPosition_Condition;
	information = DIA_OwnTeleports_getLastPosition_Info;
	permanent	= TRUE;
	description = "Positionen Speichern";
};

func int DIA_OwnTeleports_getLastPosition_Condition () {
	if(OwnTeleports_PosSaveMenu == TRUE && OwnTeleports_dialogHasStarted) {
		return TRUE;
	} else {
		return FALSE;
	};
};

func void DIA_OwnTeleports_getLastPosition_Info() {
	OwnTeleports_PositionsOne = FALSE;
	OwnTeleports_PositionsTwo = FALSE;
	OwnTeleports_PositionsThree = FALSE;
	OwnTeleports_PosSaveMenu = FALSE;
	OwnTeleports_SaveMenuBack = FALSE;
	OwnTeleports_SaveMenuEnd = FALSE;
};


//*******************************************************
// OwnTeleports_getLastPosition Dialog Aktuelle Position EINS Speichern
//*******************************************************
instance DIA_OwnTeleports_getLastPositionOne(C_Info) {
	npc = PC_Hero;
	nr = 5;
	condition = DIA_OwnTeleports_getLastPositionOne_Condition;
	information = DIA_OwnTeleports_getLastPositionOne_Info;
	permanent	= TRUE;
	description = "Aktuelle Position 1 Speichern";
};

func int DIA_OwnTeleports_getLastPositionOne_Condition () {
	if (OwnTeleports_PosSaveMenu == FALSE && OwnTeleports_dialogHasStarted) 
	{
		return TRUE;	
	};
};

func void DIA_OwnTeleports_getLastPositionOne_Info() {
	OwnTeleports_saveHeroPos(OwnTeleports_getHeroPos_X(), OwnTeleports_getHeroPos_Y(), OwnTeleports_getHeroPos_Z(), 1);
	PrintScreen("Position 1 gespeichert", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
};


//*******************************************************
// OwnTeleports_getLastPosition Dialog Aktuelle Position ZWEI Speichern
//*******************************************************
instance DIA_OwnTeleports_getLastPositionTwo(C_Info) {
	npc = PC_Hero;
	nr = 6;
	condition = DIA_OwnTeleports_getLastPositionTwo_Condition;
	information = DIA_OwnTeleports_getLastPositionTwo_Info;
	permanent	= TRUE;
	description = "Aktuelle Position 2 Speichern";
};

func int DIA_OwnTeleports_getLastPositionTwo_Condition () {
	if (OwnTeleports_PosSaveMenu == FALSE && OwnTeleports_dialogHasStarted) 
	{
		return TRUE;	
	};
};

func void DIA_OwnTeleports_getLastPositionTwo_Info() {
	OwnTeleports_saveHeroPos(OwnTeleports_getHeroPos_X(), OwnTeleports_getHeroPos_Y(), OwnTeleports_getHeroPos_Z(), 2);
	PrintScreen("Position 2 gespeichert", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
};


//*******************************************************
// OwnTeleports_getLastPosition Dialog Aktuelle Position DREI Speichern
//*******************************************************
instance DIA_OwnTeleports_getLastPositionThree(C_Info) {
	npc = PC_Hero;
	nr = 7;
	condition = DIA_OwnTeleports_getLastPositionThree_Condition;
	information = DIA_OwnTeleports_getLastPositionThree_Info;
	permanent	= TRUE;
	description = "Aktuelle Position 3 Speichern";
};

func int DIA_OwnTeleports_getLastPositionThree_Condition () {
	if (OwnTeleports_PosSaveMenu == FALSE && OwnTeleports_dialogHasStarted) 
	{
		return TRUE;	
	};
};

func void DIA_OwnTeleports_getLastPositionThree_Info() {
	OwnTeleports_saveHeroPos(OwnTeleports_getHeroPos_X(), OwnTeleports_getHeroPos_Y(), OwnTeleports_getHeroPos_Z(), 3);
	PrintScreen("Position 3 gespeichert", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
};


//*******************************************************
// OwnTeleports_Back Dialog Zurück
//*******************************************************
instance DIA_OwnTeleports_Back(C_Info) {
	npc = PC_Hero;
	nr = 998;
	condition = DIA_OwnTeleports_Back_Condition;
	information = DIA_OwnTeleports_Back_Info;
	permanent = TRUE;
	description = "(Zurück)";
};

func int DIA_OwnTeleports_Back_Condition () {
	if(OwnTeleports_SaveMenuBack == FALSE && OwnTeleports_dialogHasStarted) {
		return TRUE;
	} else {
		return FALSE;
	};
};

func void DIA_OwnTeleports_Back_Info() {
	OwnTeleports_PositionsOne = TRUE;
	OwnTeleports_PositionsTwo = TRUE;
	OwnTeleports_PositionsThree = TRUE;
	OwnTeleports_PosSaveMenu = TRUE;
	OwnTeleports_SaveMenuBack = TRUE;
	OwnTeleports_SaveMenuEnd = TRUE;
}; 


//*******************************************************
// OwnTeleports_Exit Dialog abbrechen
//*******************************************************
instance DIA_OwnTeleports_Exit(C_Info)
{
npc = PC_Hero;
nr = 999;
condition = DIA_OwnTeleports_Exit_Condition;
information = DIA_OwnTeleports_Exit_Info;
permanent = TRUE;
description = DIALOG_ENDE;
};

func int DIA_OwnTeleports_Exit_Condition () {
	if(OwnTeleports_SaveMenuEnd == TRUE && OwnTeleports_dialogHasStarted) {
		return TRUE;
	} else {
		return FALSE;
	};
};

func void DIA_OwnTeleports_Exit_Info() {
	CreateInvItem(self, NINJA_ITRU_TELEPORTER);
	self.aivar[AIV_INVINCIBLE] = FALSE; //Gegner greifen wieder an
	AI_StopProcessInfos(self);
	OwnTeleports_dialogHasStarted = FALSE;
};
