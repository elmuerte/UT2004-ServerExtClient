/*******************************************************************************
	RichTextBox	component												<br />
	TextBox with colored text											<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: GUIRichTextBox.uc,v 1.1 2004/03/19 10:41:11 elmuerte Exp $ -->
*******************************************************************************/

class GUIRichTextBox extends GUIScrollTextBox;

defaultproperties
{
	bNoTeletype=true
	DefaultListClass="ServerExtClient.GUIRichText"
}
