// Version des Patches
const string OwnTeleports_Version = "Teleport 1.0";
const int OwnTeleports_FirstRun = 0;

/*
 * Menu initialization function called by Ninja every time a menu is opened
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func void Ninja_OwnTeleports_Menu(var int menuPtr) {
    MEM_InitAll();
	
	// Version check
    if (NINJA_VERSION < 2409) {
        MEM_SendToSpy(zERR_TYPE_FATAL, "Teleport requires at least Ninja 2.4.09 or higher. Teleport benoetigt Ninja 2.4.09 oder hoeher. Download: https://bit.ly/2XFFFEn");
    };

	const int OwnTeleports_setKeysOnce = 0;
    if (!OwnTeleports_setKeysOnce) 
	{
		if (!MEM_GothOptExists("KEYS", "OwnTeleports_UseKey"))
		{ MEM_SetKeys("OwnTeleports_UseKey", KEY_J, KEY_L); };

        OwnTeleports_setKeysOnce = 1;
    };
    // Get menu and menu item list, corresponds to C_MENU_DEF.items[]
    var zCMenu menu; menu = _^(menuPtr);
    var int items; items = _@(menu.m_listItems_array);

	// Modify each menu by its name
    if (Hlp_StrCmp(menu.name, "MENU_OPT_CONTROLS")) {

		// Language
        var string itm1Str; var string itm2Str;
		itm1Str = "MENUITEM_OWNTELEPORTS_KEY";
        itm2Str = "MENUITEM_OWNTELEPORTS_INP";

        // Get new items
        var int itm1; itm1 = MEM_GetMenuItemByString(itm1Str);
        var int itm2; itm2 = MEM_GetMenuItemByString(itm2Str);

        // If the new ones do not exist yet, create them the first time
        if (!itm1) {
            var zCMenuItem itm;
            itm1 = OwnTeleports_CreateMenuItem(itm1Str);
            itm2 = OwnTeleports_CreateMenuItem(itm2Str);

            // Copy properties of first key binding entry (left column)
            var int itmF_left; itmF_left = MEM_ArrayRead(items, 1);
            OwnTeleports_CopyMenuItemProperties(itm1, itmF_left);
            itm = _^(itmF_left);
            var int ypos_l; ypos_l = itm.m_parPosY;

            // Retrieve right column entry and copy its properties too
            var string rightname; rightname = itm.m_parOnSelAction_S;
            rightname = STR_SubStr(rightname, 4, STR_Len(rightname)-4);
            var int itmF_right; itmF_right = MEM_GetMenuItemByString(rightname);
            if (itmF_right) {
                OwnTeleports_CopyMenuItemProperties(itm2, itmF_right);
            } else { // If not found, copy from left column
                OwnTeleports_CopyMenuItemProperties(itm2, itmF_left);
                itm = _^(itm2);
                itm.m_parPosX += 2700; // Default x position
            };
            itm = _^(itmF_right);
            var int ypos_r; ypos_r = itm.m_parPosY;

            // Find "BACK" menu item by its action (to add the new ones above)
            const int index = 0;
            repeat(index, MEM_ArraySize(items));
                itm = _^(MEM_ArrayRead(items, index));
                if (itm.m_parOnSelAction == /*SEL_ACTION_BACK*/ 1)
                && (itm.m_parItemFlags & /*IT_SELECTABLE*/ 4) {
                    break;
                };
            end;
            var int y; y = itm.m_parPosY; // Obtain vertical position

            // Adjust height of new entries (just above the "BACK" option)
            itm = _^(itm1);
            itm.m_parPosY = y;
            itm = _^(itm2);
            itm.m_parPosY = y + (ypos_r - ypos_l); // Maintain possible difference

            // Get maximum height of new entries
            var int ystep; ystep = OwnTeleports_MenuItemGetHeight(itm1);
            var int ystep_r; ystep_r = OwnTeleports_MenuItemGetHeight(itm2);
            if (ystep_r > ystep) {
                ystep = ystep_r;
            };

            // Shift vertical positions of all following menu items below
            repeat(i, MEM_ArraySize(items) - index); var int i;
                itm = _^(MEM_ArrayRead(items, i + index));
                itm.m_parPosY += ystep;
            end;
        };

        // Add new entries at the correct position
        OwnTeleports_ArrayInsertAtPos(items, index, itm1);
        OwnTeleports_ArrayInsertAtPos(items, index+1, itm2);
    };
};

/*
 * Initialization function called by Ninja after "Init_Global" (G2) / "Init_<Levelname>" (G1)
 */
func void Ninja_OwnTeleports_Init() {
	LeGo_MergeFlags(LeGo_FrameFunctions);
    MEM_Info(ConcatStrings(ConcatStrings("Initialize ", OwnTeleports_Version), "."));
	if (!OwnTeleports_FirstRun) {	
		FF_ApplyExt(OwnTeleports_FirstStart, 0, 1);
		PM_BindInt(OwnTeleports_FirstRun);
		OwnTeleports_FirstRun = 1;
	};	
	FF_ApplyExt(OwnTeleports_giveRuneToPlayer, 100, -1);
    MEM_Info(ConcatStrings(OwnTeleports_Version, " was initialized successfully."));
};

func void OwnTeleports_giveRuneToPlayer() {
	if (MEM_KeyState(MEM_GetKey("OwnTeleports_UseKey")) == KEY_PRESSED || MEM_KeyState(MEM_GetSecondaryKey("OwnTeleports_UseKey")) == KEY_PRESSED) {
        if (!Npc_HasItems(hero, NINJA_ITRU_TELEPORTER)) {
			CreateInvItem(hero, NINJA_ITRU_TELEPORTER);
			Snd_Play("MFX_BreathOfDeath_Cast");
			PrintScreen("Möge Beliar in seiner weißheit, dir diese Rune überreichen.", -1, -1, "FONT_OLD_10_WHITE.tga", 4);
            FF_Remove(OwnTeleports_giveRuneToPlayer);
		} else {
			PrintScreen("Du besitzt bereits eine Rune.", -1, -1, "FONT_OLD_10_WHITE.tga", 2);
            FF_Remove(OwnTeleports_giveRuneToPlayer);
		};
    };
};