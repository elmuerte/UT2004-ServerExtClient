/*******************************************************************************
	Friendly message about what just happened							<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: ChatFilterMsg.uc,v 1.1 2004/05/05 10:02:33 elmuerte Exp $ -->
*******************************************************************************/

class ChatFilterMsg extends GUIPage;

#exec TEXTURE IMPORT NAME=ChatFilterLogoImage FILE=TEXTURES\ChatFilter.dds

var localized string messages[8];

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	GUIButton(Controls[3]).OnClick=Ok;
	OnPreDraw = PreDraw;
}

event HandleParameters(string Param1, string Param2)
{
	SetText(int(Param1));
}

function SetText(int msg)
{
	GUIScrollTextBox(Controls[2]).SetContent(messages[msg]);
	GUIScrollTextBox(Controls[2]).MyScrollText.EndScrolling();
}

function bool PreDraw(Canvas Canvas)
{
	if (Controller.ActivePage != Self)
	Controller.CloseMenu();
	return false;
}

function bool Ok(GUIComponent Sender)
{
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
		WinHeight=0.6
		WinLeft=0.25
		WinTop=0.2
		CharDelay=0.0025
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
		WinHeight=0.6
		WinLeft=0.05
		WinTop=0.20
		bBoundToParent=true
		bScaleToParent=true
	ImageStyle=ISTY_Scaled
	End Object
	Controls(4)=GUIImage'ChatFilterLogo'

	Begin Object class=GUIButton Name=BadOK
		WinWidth=0.2
		WinHeight=0.12
		WinLeft=0.4
		WinTop=0.82
		Caption="OK"
		bBoundToParent=true
		bScaleToParent=true
	End Object
	Controls(3)=GUIButton'BadOK'

	bRequire640x480=false
	bAllowedAsLast=false
	WinLeft=0.175
	WinWidth=0.65
	WinTop=0.35
	WinHeight=0.3
	bDisconnectOnOpen=true

	messages(0)="Your nickname contains foul language||To play on this server you MUST change your nickname."
	messages(1)="You have been kicked from the server because of abusive chatting."
	messages(2)="You have been banned from the server because of abusive chatting."
	messages(3)="You have been banned from this game because of abusive chatting."
	messages(4)="You have been kicked from the server because of abusive chatting.|As requested by the the players."
	messages(5)="You have been banned from the server because of abusive chatting.|As requested by the the players."
	messages(6)="You have been banned from this game because of abusive chatting.|As requested by the the players."
	messages(7)="Your nickname is not allowed||To play on this server you MUST change your nickname."
}
