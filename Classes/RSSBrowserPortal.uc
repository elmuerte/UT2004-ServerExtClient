/*******************************************************************************
	client server portal to send feeds to the RSS Browser				<br />
	this one will actually be used										<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: RSSBrowserPortal.uc,v 1.1 2004/03/19 21:40:44 elmuerte Exp $ -->
*******************************************************************************/
class RSSBrowserPortal extends RSSBrowserPortalBase;

var MutRSSBrowser Browser;

simulated function AddFeed(int id, string ChannelName)
{
	Browser.cbFeed.AddItem(ChannelName,, string(id));
}

simulated function FeedDesc(int id, string desc)
{
	Browser.lbBrowser.AddText(desc$"ÿ-----ÿ");
}

simulated function FeedLink(int id, string link);

simulated function AddEntry(int id, string Title, string Link)
{
	Browser.lbBrowser.AddText(Title$"ÿ"$Link$"ÿ");
}

simulated function AddEntryDesc(int id, string desc)
{
	Browser.lbBrowser.AddText(desc$"ÿ-----ÿ");
}

defaultproperties
{
	BrowserMenu="ServerExtClient.MutRSSBrowser"
}
