/*******************************************************************************
	client server portal to send feeds to the RSS Browser				<br />
	this one will actually be used										<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: RSSBrowserPortal.uc,v 1.2 2004/03/20 08:35:07 elmuerte Exp $ -->
*******************************************************************************/

class RSSBrowserPortal extends Info;

var string BrowserMenu;
var MutRSS RSSSource;
var MutRSSBrowser Browser;

replication
{
	reliable if (Role == ROLE_Authority)
		AddFeed, FeedDesc, FeedLink, AddEntry, AddEntryDesc;

	reliable if (Role < ROLE_Authority)
		GetFeeds, GetFeed;
}

/** called my MutRSS when this info object is created */
event Created()
{
	foreach DynamicActors(class'MutRSS', RSSSource)
	{
		if (RSSSource != none) break;
	}
	PlayerController(Owner).ClientOpenMenu(BrowserMenu);
}

/** add a RSS Feed to the selection list */
simulated function AddFeed(int id, string ChannelName)
{
	Browser.cbFeed.AddItem(ChannelName,, string(id));
}

/** add the feed description */
simulated function FeedDesc(int id, string desc)
{
	Browser.lbBrowser.AddText(desc$"ÿ-----ÿ");
}

/** add the feed's link */
simulated function FeedLink(int id, string link);

/** add a feed entry */
simulated function AddEntry(int id, string Title, string Link)
{
	Browser.lbBrowser.AddText(Title$"ÿ"$Link$"ÿ");
}

/** add a feed entry's description, only if available */
simulated function AddEntryDesc(int id, string desc)
{
	Browser.lbBrowser.AddText(desc$"ÿ-----ÿ");
}

// Client side functions
/** request to send the feeds */
function GetFeeds()
{
	local int i;
	local string tmp;
	for (i = 0; i < RSSSource.Feeds.Length; i++)
	{
		tmp = RSSSource.Feeds[i].ChannelTitle;
		if (tmp == "") tmp = RSSSource.Feeds[i].rssHost;
		AddFeed(i, tmp);
	}
}

/** get the feed content of feed 'id' */
function GetFeed(int id)
{
	local int i;
	if (id >= RSSSource.Feeds.Length) return;
	if (id < 0) return;
	FeedLink(id, RSSSource.Feeds[id].ChannelLink);
	FeedDesc(id, RSSSource.Feeds[id].ChannelDescription);
	for (i = 0; i < RSSSource.Feeds[id].Entries.length; i++)
	{
		AddEntry(i, RSSSource.Feeds[id].Entries[i].Title, RSSSource.Feeds[id].Entries[i].Link);
		if (RSSSource.Feeds[id].Entries[i].Desc != "") AddEntryDesc(i, RSSSource.Feeds[id].Entries[i].Desc);
	}
}

defaultproperties
{
	RemoteRole=ROLE_AutonomousProxy
	BrowserMenu="ServerExtClient.MutRSSBrowser"
}
