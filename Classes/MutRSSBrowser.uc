/*******************************************************************************
	Mut RSS GUI Browser													<br />
	Allows you to browse the RSS feeds via a GUI						<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: MutRSSBrowser.uc,v 1.5 2004/05/11 08:04:41 elmuerte Exp $ -->
*******************************************************************************/

class MutRSSBrowser extends FloatingWindow;

var automated GUIRichTextBox lbBrowser;
var automated GUIComboBox cbFeed;

var protected RSSBrowserPortal portal;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	super.InitComponent(MyController, MyOwner);
	cbFeed.Edit.CaptionAlign = TXTA_Center;
	cbFeed.MyListBox.List.TextAlign = TXTA_Center;
	cbFeed.MyListBox.bSorted = true;
}

function AssignPortal(RSSBrowserPortal newportal)
{
	cbFeed.Clear();
	portal = newportal;
	if (portal == none) return;
	portal.browser = self;
 	portal.GetFeeds();
}

function onSelectFeed(GUIComponent sender)
{
	lbBrowser.SetContent("", "ÿ");
	if (portal != none) portal.GetFeed(int(cbFeed.GetExtra()));
}

function OnWindowClose(bool bCanceceled)
{
	if (portal != none) portal.Destroy();
}

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
		bReadOnly=true
		OnChange=onSelectFeed
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
		bStripColors=false
	End Object
	lbBrowser=MRBlbBrowser

	bAllowedAsLast=True
	WindowName="RSS Feed Browser"
	OnClose=OnWindowClose

	WinWidth=0.5
	WinHeight=0.5
	WinLeft=0.25
	WinTop=0.25
}
