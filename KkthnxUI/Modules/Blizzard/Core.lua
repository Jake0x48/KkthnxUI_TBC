local K = unpack(select(2, ...))
local Module = K:NewModule("Blizzard")

function Module:OnEnable()
	self:CreateUIWidgets()
	-- self:CreateTimerTracker()
	self:CreateMirrorBars()
	-- self:CreateAlertFrames()
	-- self:CreateAltPowerbar()
	-- self:CreateColorPicker()
	-- self:CreateMirrorBars()
	-- self:CreateNoBlizzardTutorials()
	-- self:CreateNoTalkingHead()
	-- self:CreateObjectiveFrame()
	-- self:CreateOrderHallIcon()
	-- self:CreateRaidUtility()
	-- self:CreateTalkingHeadFrame()
end