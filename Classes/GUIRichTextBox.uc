/*******************************************************************************
	RichTextBox	component												<br />
	TextBox with colored text											<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: GUIRichTextBox.uc,v 1.2 2004/05/11 08:04:41 elmuerte Exp $ -->
*******************************************************************************/

class GUIRichTextBox extends GUIScrollTextBox;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local string tmp;
	tmp = string(class);
	tmp = Left(tmp, InStr(tmp, "."));
	DefaultListClass = repl(DefaultListClass, "%clientpackage%", tmp);
	super.InitComponent(MyController, MyOwner);
}

defaultproperties
{
	bNoTeletype=true
	DefaultListClass="%clientpackage%.GUIRichText"
}
