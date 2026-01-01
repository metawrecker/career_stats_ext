local generalPage = ::CareerStatsExt.Mod.ModSettings.addPage("Page", "General");
local hideCareerStatsExtraLinesWorld = generalPage.addBooleanSetting("HideCareerStatsExtraLinesWorld", false, "Hide Career Stats on the world map");
local hideCareerStatsExtraLinesCombat = generalPage.addBooleanSetting("HideCareerStatsExtraLinesCombat", true, "Hide Career Stats during combat");
