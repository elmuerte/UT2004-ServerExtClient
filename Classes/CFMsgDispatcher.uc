/*******************************************************************************
	ChatFilter message dispatcher, for each player controller in a level.
	This actor will dispatch the client side messages/gui elements		<br />

	(c) 2004, Michiel "El Muerte" Hendriks								<br />
	Released under the Open Unreal Mod License							<br />
	http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense				<br />

	<!-- $Id: CFMsgDispatcher.uc,v 1.1 2004/05/05 10:02:33 elmuerte Exp $ -->
*******************************************************************************/

class CFMsgDispatcher extends Info;

#include ../ServerExt/classes/const.inc

replication
{
	reliable if( Role==ROLE_Authority )
		Dispatch, ChangeNamerequest, MutedHud;
}

simulated function Dispatch(PlayerController PC, int Msg)
{
	//log("Dispatch message");
	if (PC == none) return;
	if (PC.Player == none) return;
	if (PC.Player.GUIController == none) return;
	if (ChatFilterMsg(GUIController(PC.Player.GUIController).ActivePage) == none)
	PC.ClientOpenMenu(ClientSidePackage$".ChatFilterMsg", true, String(Msg));
}

simulated function ChangeNamerequest(PlayerController PC, int Msg)
{
	//log("Name request");
	if (PC == none) return;
	if (PC.Player == none) return;
	if (PC.Player.GUIController == none) return;
	if (CFChangeNick(GUIController(PC.Player.GUIController).ActivePage) == none)
	PC.ClientOpenMenu(ClientSidePackage$".CFChangeNick", false, String(Msg));
}

simulated function MutedHud(PlayerController PC)
{
	//log("Muted hud");
	if (PC == none) return;
	if (PC.Player == none) return;
	if (PC.Player.InteractionMaster == none) return;
	PC.Player.InteractionMaster.AddInteraction(ClientSidePackage$".CFMutedHud", PC.Player);
}

defaultproperties
{
	bHidden=true
	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=True
}
