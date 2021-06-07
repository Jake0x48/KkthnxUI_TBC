local K = unpack(select(2, ...))
local Module = K:NewModule("DevCore")

local GUI = K["GUI"]

function Module:OnEnable()
	local gui = CreateFrame("Button", "KKUI_GameMenuFrame", GameMenuFrame, "GameMenuButtonTemplate, BackdropTemplate")
	gui:SetText(K.InfoColor.."KkthnxUI|r")
	gui:SetPoint("TOP", GameMenuButtonAddons, "BOTTOM", 0, -21)
	GameMenuFrame:HookScript("OnShow", function(self)
		GameMenuButtonLogout:SetPoint("TOP", gui, "BOTTOM", 0, -21)
		self:SetHeight(self:GetHeight() + gui:GetHeight() + 22)
	end)

	gui:SetScript("OnClick", function()
		if InCombatLockdown() then
			UIErrorsFrame:AddMessage(K.InfoColor..ERR_NOT_IN_COMBAT)
			return
		end

		GUI:Toggle()
		HideUIPanel(GameMenuFrame)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
	end)
end

do
	if IsAddOnLoaded("Anti-Deluxe") then
		local function FuckYou_AntiDeluxe() -- Dont let others hook and change this
			local buffs, i = { }, 1
			local buff = UnitBuff("target", i)
			local check = ""
			local setEmotes = {"CHEER", "HUG", "CLAP", "CONGRATS", "GLAD"} -- make it interesting

			while buff do
				buffs[#buffs + 1] = buff
				i = i + 1
				buff = UnitBuff("target", i)
			end

			buffs = table.concat(buffs, ", ")
			if string.match(buffs, "Reawakened") then
				Check = "False"
				DeluxeAndy = GetUnitName("target")

				if DeluxeAndy == K.Name then -- Dont cheer yourself -.-
					return
				end

				for _, v in pairs(MountOwners) do
					if v == DeluxeAndy then
						Check = "True"
						break
					end
				end

				if Check == "False" then -- No Need to keep emoting the same person
					DoEmote(setEmotes[math.random(1, #setEmotes)])
					table.insert(MountOwners, DeluxeAndy)
				end
			end
		end

		BuffCheck = FuckYou_AntiDeluxe -- Hook this shitty addon to fix the shitty choices this dev has made
	end
end

do
	local SpitterEmotes = {
		"VIOLIN", "CHUCKLE", "FLEX", "PITY", "SLAP", "BONK"
	}

	local function EmoteOnSpitters(_, _, msg, spitter)
		if string.find(msg, "spits on you") then
			DoEmote(SpitterEmotes[math.random(1, #SpitterEmotes)], spitter)
		end
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", EmoteOnSpitters)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", EmoteOnSpitters)
end