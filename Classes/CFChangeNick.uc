/*******************************************************************************
    Friendly nick change request                                        <br />

    (c) 2004, Michiel "El Muerte" Hendriks                              <br />
    Released under the Open Unreal Mod License                          <br />
    http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense

    <!-- $Id: CFChangeNick.uc,v 1.3 2004/10/20 14:01:33 elmuerte Exp $ -->
*******************************************************************************/

class CFChangeNick extends FloatingWindow;

var automated GUIButton btnOk, btnCancel;
var automated GUIEditBox edNewNick;
var automated GUIImage imgLogo;
var automated GUIScrollTextBox sbText;
var automated GUILabel lblNick;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);
    edNewNick.TextStr = "";
    OnPreDraw = PreDraw;
}

event HandleParameters(string Param1, string Param2)
{
    SetText(int(Param1));
}

function SetText(int msg)
{
    sbText.SetContent(class'ChatFilterMsg'.default.messages[msg]);
    sbText.MyScrollText.EndScrolling();
}

function bool PreDraw(Canvas Canvas)
{
    if (Controller.ActivePage != Self) Controller.CloseMenu();
    return false;
}

function string Trim(string line)
{
    while (Left(line, 1) == " ") line = Mid(line, 1);
    return line;
}

function bool Ok(GUIComponent Sender)
{
    local string newname;
    newname = Trim(edNewNick.TextStr);
    if (newname == "") return false;
    if (Caps(newname) == Caps(PlayerOwner().PlayerReplicationInfo.PlayerName)) return false;
    PlayerOwner().SetName(newname);
    Controller.CloseMenu();
    return true;
}

function bool Cancel(GUIComponent Sender)
{
    Controller.CloseMenu(true);
    return true;
}

function OnWClose(optional bool bCancelled)
{
    if (bCancelled) PlayerOwner().ConsoleCommand("Disconnect");
}

defaultproperties
{
    Begin Object Class=GUIScrollTextBox Name=BadText
        WinWidth=0.7
        WinHeight=0.46
        WinLeft=0.25
        WinTop=0.2
        EOLDelay=0
        bBoundToParent=true
        bScaleToParent=true
        StyleName="NoBackground"
        bNoTeletype=true
    End Object
    sbText=BadText

    Begin Object class=GUIImage Name=ChatFilterLogo
        Image=Texture'ChatFilterLogoImage'
        WinWidth=0.2
        WinHeight=0.46
        WinLeft=0.05
        WinTop=0.2
        bBoundToParent=true
        bScaleToParent=true
        ImageStyle=ISTY_Scaled
    End Object
    imgLogo=ChatFilterLogo

    Begin Object class=GUIButton Name=BadOK
        WinWidth=0.200000
        WinHeight=0.09
        WinLeft=0.285
        WinTop=0.85
        Caption="OK"
        bBoundToParent=true
        bScaleToParent=true
        OnClick=Ok
    End Object
    btnOk=BadOk

    Begin Object class=GUIButton Name=BadCancel
        WinWidth=0.200000
        WinHeight=0.09
        WinLeft=0.51
        WinTop=0.85
        Caption="Cancel"
        bBoundToParent=true
        bScaleToParent=true
        OnClick=Cancel
    End Object
    btnCancel=BadCancel

    Begin Object class=GUIEditBox Name=NewNick
        WinWidth=0.700000
        WinHeight=0.082440
        WinLeft=0.250000
        WinTop=0.716276
        bBoundToParent=true
        bScaleToParent=true
    End Object
    edNewNick=NewNick

    Begin Object class=GUILabel Name=NewNickTitle
        Caption="New nickname"
        TextALign=TXTA_Left
        TextColor=(R=255,G=255,B=255,A=255)
        WinWidth=0.23
        WinHeight=0.12
        WinLeft=0.02
        WinTop=0.7
        bBoundToParent=true
        bScaleToParent=true
        StyleName="TextLabel"
    End Object
    lblNick=NewNickTitle

    bRequire640x480=false
    bAllowedAsLast=true
    WinLeft=0.175
    WinWidth=0.65
    WinTop=0.3
    WinHeight=0.4
    bDisconnectOnOpen=false
    WindowName="Chat Filter: Bad Name"
    OnClose=OnWClose
}
