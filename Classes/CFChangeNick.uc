/*******************************************************************************
	Friendly nick change request										<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: CFChangeNick.uc,v 1.1 2004/05/05 10:02:33 elmuerte Exp $ -->
*******************************************************************************/

class CFChangeNick extends GUIPage;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	GUIButton(Controls[3]).OnClick=Ok;
	GUIButton(Controls[5]).OnClick=Cancel;
	GUIEditBox(Controls[6]).TextStr = "";
	OnPreDraw = PreDraw;
}

event HandleParameters(string Param1, string Param2)
{
	SetText(int(Param1));
}

function SetText(int msg)
{
	GUIScrollTextBox(Controls[2]).SetContent(class'ChatFilterMsg'.default.messages[msg]);
	GUIScrollTextBox(Controls[2]).MyScrollText.EndScrolling();
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
	newname = Trim(GUIEditBox(Controls[6]).TextStr);
	if (newname == "") return false;
	if (Caps(newname) == Caps(PlayerOwner().PlayerReplicationInfo.PlayerName)) return false;
	PlayerOwner().SetName(newname);
	Controller.CloseMenu();
	return true;
}

function bool Cancel(GUIComponent Sender)
{
	PlayerOwner().ConsoleCommand("Disconnect");
	Controller.CloseMenu();
	return true;
}

defaultproperties
{
	Begin Object Class=GUIImage name=BadBackground
		bAcceptsInput=false
		bNeverFocus=true
		Image=Material'InterfaceContent.Menu.SquareBoxA'
		ImageStyle=ISTY_Stretched
		WinWidth=1
		WinLeft=0
		WinHeight=1
		WinTop=0
		bBoundToParent=true
		bScaleToParent=true
	End Object
	Controls(0)=GUIImage'BadBackground'

	Begin Object class=GUILabel Name=BadTitle
		Caption="Chat Filter"
		TextALign=TXTA_Center
		TextColor=(R=255,G=0,B=0,A=255)
		WinWidth=1
		WinHeight=32.000000
		WinLeft=0
		WinTop=0.02
		bBoundToParent=true
		bScaleToParent=true
		TextFont="UT2MenuFont"
	End Object
	Controls(1)=GUILabel'BadTitle'

	Begin Object Class=GUIScrollTextBox Name=BadText
 		WinWidth=0.7
		WinHeight=0.46
		WinLeft=0.25
		WinTop=0.2
		EOLDelay=0
		bBoundToParent=true
		bScaleToParent=true
		StyleName="RoundButton"
		bNoTeletype=true
	End Object
	Controls(2)=GUIScrollTextBox'BadText'

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
	Controls(4)=GUIImage'ChatFilterLogo'

	Begin Object class=GUIButton Name=BadOK
 		WinWidth=0.200000
		WinHeight=0.09
		WinLeft=0.285
		WinTop=0.85
		Caption="OK"
		bBoundToParent=true
		bScaleToParent=true
	End Object
	Controls(3)=GUIButton'BadOK'

	Begin Object class=GUIButton Name=BadCancel
		WinWidth=0.200000
		WinHeight=0.09
		WinLeft=0.51
		WinTop=0.85
		Caption="Cancel"
		bBoundToParent=true
		bScaleToParent=true
	End Object
	Controls(5)=GUIButton'BadCancel'

	Begin Object class=GUIEditBox Name=NewNick
 		WinWidth=0.7
		WinHeight=0.12
		WinLeft=0.25
		WinTop=0.7
		bBoundToParent=true
		bScaleToParent=true
	End Object
	Controls(6)=GUIButton'NewNick'

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
		TextFont="UT2MenuFont"
	End Object
	Controls(7)=GUILabel'NewNickTitle'

	bRequire640x480=false
	bAllowedAsLast=true
	WinLeft=0.175
	WinWidth=0.65
	WinTop=0.3
	WinHeight=0.4
	bDisconnectOnOpen=false
}
