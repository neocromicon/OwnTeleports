/*
 * Create menu item from script instance name
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func int OwnTeleports_CreateMenuItem(var string scriptName) { // Adjust name
    const int zCMenuItem__Create_G1 = 5052784; //0x4D1970
    const int zCMenuItem__Create_G2 = 5105600; //0x4DE7C0

    var int strPtr; strPtr = _@s(scriptName);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(strPtr));
        CALL_PutRetValTo(_@(ret));
        CALL__cdecl(MEMINT_SwitchG1G2(zCMenuItem__Create_G1,
                                      zCMenuItem__Create_G2));
        call = CALL_End();
    };

    var int ret;
    return +ret;
};

/*
 * Copy essential properties from one to another menu entry
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func void OwnTeleports_CopyMenuItemProperties(var int dstPtr, var int srcPtr) {
    if (!dstPtr) || (!srcPtr) {
        return;
    };

    var zCMenuItem src; src = _^(srcPtr);
    var zCMenuItem dst; dst = _^(dstPtr);

    dst.m_parPosX = src.m_parPosX;
    dst.m_parPosY = src.m_parPosY;
    dst.m_parDimX = src.m_parDimX;
    dst.m_parDimY = src.m_parDimY;
    dst.m_pFont = src.m_pFont;
    dst.m_pFontSel = src.m_pFontSel;
    dst.m_parBackPic = src.m_parBackPic;
};

/*
 * Get maximum menu item height
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func int OwnTeleports_MenuItemGetHeight(var int itmPtr) { // Adjust name
    if (!itmPtr) {
        return 0;
    };

    var zCMenuItem itm; itm = _^(itmPtr);
    var int fontPtr; fontPtr = itm.m_pFont;

    const int zCFont__GetFontY_G1 = 7209472; //0x6E0200
    const int zCFont__GetFontY_G2 = 7902432; //0x7894E0

    var int fontHeight;
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL__thiscall(_@(fontPtr), MEMINT_SwitchG1G2(zCFont__GetFontY_G1,
                                                      zCFont__GetFontY_G2));
        CALL_PutRetValTo(_@(fontHeight));
        call = CALL_End();
    };

    // Transform to virtual pixels
    MEM_InitGlobalInst();
    var zCView screen; screen = _^(MEM_Game._zCSession_viewport);
    fontHeight *= 8192 / screen.psizey;

    if (fontHeight > itm.m_parDimY) {
        return fontHeight;
    } else {
        return itm.m_parDimY;
    };
};

/*
 * Insert value into array at specific position
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func void OwnTeleports_ArrayInsertAtPos(var int zCArray_ptr,
                                             var int pos,
                                             var int value) { // Adjust name
    const int zCArray__InsertAtPos_G1 = 6267728; //0x5FA350
    const int zCArray__InsertAtPos_G2 = 6458144; //0x628B20

    var int valuePtr; valuePtr = _@(value);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(pos));
        CALL_PtrParam(_@(valuePtr));
        CALL__thiscall(_@(zCArray_ptr), MEMINT_SwitchG1G2(zCArray__InsertAtPos_G1,
                                                          zCArray__InsertAtPos_G2));
        call = CALL_End();
    };
};