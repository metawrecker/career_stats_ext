/*

	I enjoy using the Career Stats mod by Endurial but I don't like the extra 10 or so lines that are added when I'm in combat and trying to look through the
	character roster really quickly. It adds unnecessary visual noise in my opinion.

	The goal of this mod is to give you, the player, control for when the extra lines are displayed during combat.
		This setting applies to looking at the player roster during combat and also when hovering over bros on the after-combat screen.

*/

::CareerStatsExt <- {
	ID = "mod_career_stats_ext",
	Name = "Career Stats Ext",
	Version = "1.0.0"
}

local requiredMods = [
	"vanilla >= 1.5.1-6",
	"mod_msu >= 1.2.0",
	"mod_modern_hooks >= 0.4.10",
	"mod_career_stats >= 1.0.2"
];

::CareerStatsExt.HooksMod <- ::Hooks.register(::CareerStatsExt.ID, ::CareerStatsExt.Version, ::CareerStatsExt.Name);
::CareerStatsExt.HooksMod.require(requiredMods);

::CareerStatsExt.userGivesPermission <- function (settingName)
{
	return ::CareerStatsExt.Mod.ModSettings.getSetting(settingName).getValue();
}

local modLoadOrder = [];
foreach (mod in requiredMods) {
	local idx = mod.find(" ");
	modLoadOrder.push(">" + (idx == null ? mod : mod.slice(0, idx)));
}

::CareerStatsExt.HooksMod.queue(modLoadOrder, function() {
	::CareerStatsExt.Mod <- ::MSU.Class.Mod(::CareerStatsExt.ID, ::CareerStatsExt.Version, ::CareerStatsExt.Name);

	local generalPage = ::CareerStatsExt.Mod.ModSettings.addPage("Page", "General");
	local hideCareerStatsExtraLinesWorld = generalPage.addBooleanSetting("HideCareerStatsExtraLinesWorld", false, "Hide Career Stats while on the world map");
	local hideCareerStatsExtraLinesCombat = generalPage.addBooleanSetting("HideCareerStatsExtraLinesCombat", true, "Hide Career Stats during combat");

	::include("career_stats_ext/player");
});