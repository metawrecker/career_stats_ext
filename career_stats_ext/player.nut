::CareerStatsExt.HooksMod.hook("scripts/entity/tactical/player", function(q) {
	q.getRosterTooltip = @(__original) function()
	{
		local ret = __original();
		local originalLineCount = ret.len();
		local careerStatsLinesStartWith = [
			"DMG Dealt",
			"Avg DMG/Battle",
			"DMG Received",
			"Avg DMG/Battle Received",
			"Heaviest Hit",
			"Hit Chance",
			"Headshot Chance",
			"Dodge Chance",
			"Lucky 5",
			"Unlucky 95"
		];

		try {
			local removeCareerStatsLines = function() {
				ret = ret.filter(function(index, value) {
					if (value != null && value.id != null && value.text != null) {
						if (value.id < 6 || (value.id == 6 && (value.text == "In reserve" || value.text == "In the fighting line")))
							return true;

						foreach (index, item in careerStatsLinesStartWith) {
							if (value.text.find(item) != null) {
								return false;
							}
						}

						return true;
					}
				});
			}

			if (::MSU.Utils.getActiveState().ClassName == "world_state" && ::CareerStatsExt.userGivesPermission("HideCareerStatsExtraLinesWorld")) {
				removeCareerStatsLines();
			}
			else if (::MSU.Utils.getActiveState().ClassName == "tactical_state" && ::CareerStatsExt.userGivesPermission("HideCareerStatsExtraLinesCombat")) {
				removeCareerStatsLines();
			}
		} catch (exception){
			::logInfo("Career Stats Ext ran into an error while modifying the tooltip lines.");
			::logError(exception);
		}

		return ret;
	}
});