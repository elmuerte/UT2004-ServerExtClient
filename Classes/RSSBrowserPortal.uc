/*******************************************************************************
	client server portal to send feeds to the RSS Browser				<br />
	this one will actually be used										<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: RSSBrowserPortal.uc,v 1.4 2004/05/10 22:10:45 elmuerte Exp $ -->
*******************************************************************************/

class RSSBrowserPortal extends Info;

var string BrowserMenu;
var array<RSSFeedRecord> RSSFeeds;
var MutRSSBrowser Browser;

replication
{
	reliable if (Role == ROLE_Authority)
		AddFeed, FeedDesc, FeedLink, AddEntry, AddEntryDesc, EndGetFeeds,
		EndGetFeed;

	reliable if (Role < ROLE_Authority)
		GetFeeds, GetFeed;
}

/** called my MutRSS when this info object is created */
event Created()
{
	local RSSFeedRecord RSSSource;
	super.Created();
	foreach AllObjects(class'RSSFeedRecord', RSSSource)
	{
		RSSFeeds[RSSFeeds.length] = RSSSource;
	}
	PlayerController(Owner).ClientOpenMenu(BrowserMenu);
}

/** add a RSS Feed to the selection list */
simulated function AddFeed(int id, string ChannelName)
{
	Browser.cbFeed.AddItem(ChannelName,, string(id));
}

/** called at the end of the GetFeeds() call */
simulated function EndGetFeeds();

/** add the feed description */
simulated function FeedDesc(int id, string desc)
{
	Browser.lbBrowser.AddText(desc$"ÿ-----");
}

/** add the feed's link */
simulated function FeedLink(int id, string link)
{
	Browser.lbBrowser.AddText(link);
}

/** add a feed entry */
simulated function AddEntry(int id, string Title, string Link)
{
	Browser.lbBrowser.AddText(Title$"ÿ"$Link$"ÿ");
}

/** add a feed entry's description, only if available */
simulated function AddEntryDesc(int id, string desc)
{
	Browser.lbBrowser.AddText(desc$"ÿ-----");
}

/** called at the end of the GetFeed() call */
simulated function EndGetFeed()
{
	Browser.lbBrowser.MyList.SetTopItem(0);
}

// Client side functions
/** request to send the feeds */
function GetFeeds()
{
	local int i;
	local string tmp;
	for (i = 0; i < RSSFeeds.Length; i++)
	{
		tmp = RSSFeeds[i].ChannelTitle;
		if (tmp == "") tmp = RSSFeeds[i].rssHost;
		AddFeed(i, tmp);
	}
	EndGetFeeds();
}

/** get the feed content of feed 'id' */
function GetFeed(int id)
{
	local int i;
	if (id >= RSSFeeds.Length) return;
	if (id < 0) return;
	FeedLink(id, RSSFeeds[id].ChannelLink);
	FeedDesc(id, RSSFeeds[id].ChannelDescription);
	for (i = 0; i < RSSFeeds[id].Entries.length; i++)
	{
		AddEntry(i, RSSFeeds[id].Entries[i].Title, RSSFeeds[id].Entries[i].Link);
		if (RSSFeeds[id].Entries[i].Desc != "") AddEntryDesc(i, repl(RSSFeeds[id].Entries[i].Desc, "\\\"", "\""));
	}
	EndGetFeed();
}

defaultproperties
{
	RemoteRole=ROLE_AutonomousProxy
	BrowserMenu="%clientpackage%.MutRSSBrowser"
}
