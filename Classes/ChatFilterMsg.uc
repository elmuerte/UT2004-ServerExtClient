/*******************************************************************************
	Friendly message about what just happened							<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: ChatFilterMsg.uc,v 1.2 2004/05/05 20:51:36 elmuerte Exp $ -->
*******************************************************************************/

class ChatFilterMsg extends FloatingWindow;

var automated GUIButton btnOk;
var automated GUIImage imgLogo;
var automated GUIScrollTextBox sbText;

#exec TEXTURE IMPORT NAME=ChatFilterLogoImage FILE=TEXTURES\ChatFilter.dds

var localized string messages[8];

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);
	OnPreDraw = PreDraw;
}

event HandleParameters(string Param1, string Param2)
{
	SetText(int(Param1));
}

function SetText(int msg)
{
	sbText.SetContent(messages[msg]);
	sbText.MyScrollText.EndScrolling();
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
	Begin Object Class=GUIScrollTextBox Name=BadText
		WinWidth=0.7
		WinHeight=0.6
		WinLeft=0.25
		WinTop=0.2
		CharDelay=0.0025
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
		WinHeight=0.6
		WinLeft=0.05
		WinTop=0.20
		bBoundToParent=true
		bScaleToParent=true
	ImageStyle=ISTY_Scaled
	End Object
	imgLogo=ChatFilterLogo

	Begin Object class=GUIButton Name=BadOK
		WinWidth=0.2
		WinHeight=0.12
		WinLeft=0.4
		WinTop=0.82
		Caption="OK"
		bBoundToParent=true
		bScaleToParent=true
		OnClick=Ok
	End Object
	btnOk=BadOK

	bRequire640x480=false
	bAllowedAsLast=false
	WinLeft=0.175
	WinWidth=0.65
	WinTop=0.35
	WinHeight=0.3
	bDisconnectOnOpen=true
	WindowName="chat Filter"

	messages(0)="Your nickname contains foul language||To play on this server you MUST change your nickname."
	messages(1)="You have been kicked from the server because of abusive chatting."
	messages(2)="You have been banned from the server because of abusive chatting."
	messages(3)="You have been banned from this game because of abusive chatting."
	messages(4)="You have been kicked from the server because of abusive chatting.|As requested by the the players."
	messages(5)="You have been banned from the server because of abusive chatting.|As requested by the the players."
	messages(6)="You have been banned from this game because of abusive chatting.|As requested by the the players."
	messages(7)="Your nickname is not allowed||To play on this server you MUST change your nickname."
}
