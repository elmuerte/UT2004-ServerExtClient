/*******************************************************************************
	RichText	component												<br />
	TextBox with colored text											<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: GUIRichText.uc,v 1.3 2004/03/24 11:39:32 elmuerte Exp $ -->
*******************************************************************************/

class GUIRichText extends GUIScrollText;

function DrawTextItem(Canvas Canvas, int Item, float X, float Y, float W, float HT, bool bSelected, bool bPending)
{
	if (StringElements[Item] == "-----")
	{
		Canvas.Reset();
		Canvas.SetPos(X, Y);
		Canvas.DrawColor = Style.FontColors[MenuState];
		Canvas.DrawHorizontal(Y+(HT/2)-1, W);
	}
	else Style.DrawText(Canvas, MenuState, X, Y, W, HT, TextAlign, StringElements[Item], FontScale);
}

defaultproperties
{
	OnDrawItem=DrawTextItem
}
