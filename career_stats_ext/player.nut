::CareerStatsExt.HooksMod.hook("scripts/entity/tactical/player", function(q) {
	q.getRosterTooltip = @(__original) function()
	{
		local ret = __original();
		local originalLineCount = ret.len();

		try {
			local removeCareerStatsLines = function() {
				ret = ret.filter(function(index, value) {
					if (value != null && value.id != null && value.text != null) {
						return value.id < 6 || (value.id == 6 && (value.text == "In reserve" || value.text == "In the fighting line"));
					}
				});

				if (originalLineCount != ret.len()) {
					::logInfo("Successfully trimmed Career Stats tooltip lines");
				}
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