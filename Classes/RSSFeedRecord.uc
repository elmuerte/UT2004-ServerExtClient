/*******************************************************************************
	RSS Feed Record														<br />
	Contains the data of an RSS File									<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: RSSFeedRecord.uc,v 1.2 2004/05/10 22:10:45 elmuerte Exp $ -->
*******************************************************************************/

class RSSFeedRecord extends LibHTTP2.NewsFeed config(RSS);

/** the color to use when displaying the content of this feed */
var(Config) config color TextColor;

/** set this to the config file used */
var const string ConfigFile;

struct HTMLSpecialCharItem
{
	var string from, to;
};
/** HTML special char replacement table */
var array<HTMLSpecialCharItem> HTMLSpecialChars;

/** update the current feed, needs a HttpSock because we want to make use of the internal caching */
function Update(HttpSock sock)
{
	log("Updating RSS Feed"@rssHost, name);
	if (rssLocation != "") sock.HttpRequest(rssLocation);
	else Log("RSS Location is empty");
}

function ProcessData(HttpSock sock)
{
	local int i;

	if (ParseRDFData(sock.ReturnData) > 0)
	{
		for (i = 0; i < Entries.Length; i++)
		{
			Entries[i].Title = fixHTMLSpecialsChars(Entries[i].Title);
			Entries[i].Link = fixHTMLSpecialsChars(Entries[i].Link);
			Entries[i].Desc = fixHTMLSpecialsChars(Entries[i].Desc);
		}

		LastUpdate = sock.now();
		SaveConfig();
		Log("Updated RSS Feed"@rssHost, name);
	}
	else {
		Log("RSS Feed was empty for "@rssHost, name);
	}
}

/** fill the line buffer */
protected function bool getLine()
{
	local string tmp;
	if (lineno >= data.length) return false;
	tmp = data[lineno];
	tmp = repl(tmp, Chr(9), " ");
	tmp = repl(tmp, "<", " <");
	tmp = repl(tmp, ">", "> ");
	split(tmp, " ", line);
	lineno++;
	wordno = 0;
	return true;
}

/** replaces HTML special chars */
protected function string fixHTMLSpecialsChars(coerce string in)
{
	local int i, j;
	local string tmp;
	// first &#<number>;
	i = InStr(in, "&#");
	while (i > -1)
	{
		tmp = Left(in, i);
		in = Mid(in, i);
		i = InStr(in, ";");
		j = int(Mid(in, 2, i-2));
		if (j < 32) j = 63; // == ?
		tmp $= Chr(j)$Mid(in, i+1);
		in = tmp;
		i = InStr(in, "&#");
	}
	// then lookup table
	for (i = 0; i < HTMLSpecialChars.length; i++)
	{
		in = repl(in, HTMLSpecialChars[i].from, HTMLSpecialChars[i].to);
	}
	in = EscapeQuotes(in);
	return in;
}

/** dirty fix, because of a bug in ExportText not escaping them for structs */
static function string EscapeQuotes(string in)
{
	return repl(in, "\"", "\\\"");
}

defaultproperties
{
	rssEnabled=true
	rssUpdateInterval=45
	TextColor=(R=255,G=255,B=0)

	HTMLSpecialChars(0)=(from="&amp;",to="&")
	HTMLSpecialChars(1)=(from="&quot;",to="\"")
	HTMLSpecialChars(2)=(from="&nbsp;",to=" ")
	HTMLSpecialChars(3)=(from="&lt;",to="<")
	HTMLSpecialChars(4)=(from="&gt;",to=">")
	HTMLSpecialChars(5)=(from="&copy;",to="©")
	HTMLSpecialChars(6)=(from="&reg;",to="®")

	ConfigFile="RSS"
}

