/*******************************************************************************
	Displays on screen when a player has been muted						<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: CFMutedHud.uc,v 1.1 2004/05/05 10:02:33 elmuerte Exp $ -->
*******************************************************************************/

class CFMutedHud extends interaction config;

/** the image to use */
var config string LogoImage;

var Texture Logo;
var float IconScale;
var string msg;

event Initialized()
{
	logo = texture(DynamicLoadObject(LogoImage, class'Texture'));
}

simulated function PostRender( canvas Canvas )
{
	local float X,Y;
	Canvas.Reset();
	Canvas.style = 5; //ERenderStyle.STY_Alpha;
	Canvas.Font = class'HudBase'.static.GetMediumFontFor(Canvas);
	Canvas.StrLen(msg, X, Y);
	IconScale = Y/Logo.VSize;
	X = (Canvas.SizeX-X-(Logo.USize*IconScale))/2;
	Y = 0;
	Canvas.SetPos(X, Y);
	Canvas.DrawIcon(Logo, IconScale);
	Canvas.SetDrawColor(255,0,0,127);
	Canvas.SetPos(X+(Logo.USize*IconScale), Y);
	Canvas.DrawText(msg, false);
}

simulated function NotifyLevelChange ()
{
 	Master.RemoveInteraction(Self);
}

defaultproperties
{
	msg=" ChatFilter: Muted"
	IconScale=0.5
	LogoImage="ServerExtClient.ChatFilterLogoImage"
	bVisible=true
	bActive=true
	bRequiresTick=True
}
