/*******************************************************************************
	Mut RSS GUI Browser													<br />
	Allows you to browse the RSS feeds via a GUI						<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: MutRSSBrowser.uc,v 1.1 2004/03/19 10:41:11 elmuerte Exp $ -->
*******************************************************************************/

class MutRSSBrowser extends FloatingWindow;

var automated GUIRichTextBox lbBrowser;
var automated GUIComboBox cbFeed;

defaultproperties
{
	Begin Object Class=GUIComboBox Name=MRBcbFeed
		WinWidth=0.937500
		WinHeight=0.060000
		WinLeft=0.031250
		WinTop=0.080556
		bBoundToParent=true
		bScaleToParent=true
		FontScale=FNS_Small
	End Object
	cbFeed=MRBcbFeed

	Begin Object Class=GUIRichTextBox Name=MRBlbBrowser
		WinWidth=0.958333
		WinHeight=0.766667
		WinLeft=0.020833
		WinTop=0.150000
		StyleName="NoBackground"
		bNoTeletype=true
		TextAlign=TXTA_Left
		bBoundToParent=true
		bScaleToParent=true
		FontScale=FNS_Small
		Separator="ÿ"
	End Object
	lbBrowser=MRBlbBrowser

	bAllowedAsLast=True
	WindowName="RSS Feed Browser"

	WinWidth=0.5
	WinHeight=0.5
	WinLeft=0.25
	WinTop=0.25
}
