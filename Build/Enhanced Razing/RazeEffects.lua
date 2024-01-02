-- Lua Script1
-- Author: Nicholas
-- DateCreated: 1/1/2024 4:55:02 PM
--------------------------------------------------------------
-- This function will kill one additional citizen in each razing city if the user has the relevant ideological tenet. 
--It will also distribute bonuses associated with those tenets.

--The bonuses:

function RazeEffects(iPlayer)
	local iFreedomRaze=GameInfo.Policies["POLICY_CROP_QUOTAS"].ID
	local iOrderRaze=GameInfo.Policies["POLICY_INDUSTRIAL_PLUNDER"].ID
	local iAutocracyRaze=GameInfo.Policies["POLICY_LIVING_SPACE"].ID

	local pPlayer= Players[iPlayer]
	--Only perform the main loop if player has one of the relevant policies.
	if pPlayer.HasPolicy(iFreedomRaze) or pPlayer.HasPolicy(iOrderRaze) or pPlayer.HasPolicy(iAutocracyRaze) then
		print("Player has enhanced razing policy- Checking for candidates")
		--local iCiv= pPlayer.getCivilizationType()

		local iLeader= pPlayer.getLeaderType()

		local Trait=GameInfo.Leader_Traits[GameInfo.Civilization_Leaders[iLeader].LeaderheadType].TraitType

		local razeSpeed=1+ GameInfo.Traits[Trait].RazeSpeedModifier/100 --Civilization raze speed, in citizens per turn(Most Firaxis Civs have 1, the Huns have 2)

		local citizensRazed=0
		for pCity in pPlayer.Cities() do
			if pCity.IsRazing() then
				pCity.ChangePopulation(-(razeSpeed),true) --Reduce population by razespeed, in addition to population lost in engine.
				citizensRazed = citizensRazed+ 2*razeSpeed
			end
		end
		
		--citizensRazed should be defined by now
		iGameSpeed= Game.GetGameSpeedType()
		if pPlayer.HasPolicy(iFreedomRaze) then
			food_base=300
		end

		if pPlayer.HasPolicy(iOrderRaze) then
			
		end

		if pPlayer.HasPolicy(iAutocracyRaze) then
			gold_base=400 
		end



	end 
end

GameEvents.PlayerDoTurn.Add(RazeEffects)