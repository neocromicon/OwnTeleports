/*
 *--------------Tastenzuweisungs Menü--------------
 *
 */
INSTANCE MENUITEM_OWNTELEPORTS_KEY(C_MENU_ITEM_DEF)
{
    text[0]             	=   "Teleport Rune";
    text[1]             	=   "Taste ENTF zum Löschen und RETURN zum definieren";

    onSelAction[0]      	=   OWNTELEPORTS_SEL_ACTION_EXECCOMMANDS;
    onSelAction_S[0]    	=   "RUN MENUITEM_OWNTELEPORTS_INP";
};
INSTANCE MENUITEM_OWNTELEPORTS_INP(C_MENU_ITEM_DEF)
{
    type        			=   OWNTELEPORTS_MENU_ITEM_INPUT;
    text[1]     			=   "Gewünschte Taste betätigen.";

    onChgSetOption          = "OwnTeleports_UseKey";
    onChgSetOptionSection   = "KEYS";
	flags					= flags & ~OWNTELEPORTS_IT_SELECTABLE;
};