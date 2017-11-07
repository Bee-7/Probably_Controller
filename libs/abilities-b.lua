-- Initialize tables
if not repli then repli = { } end
---QUEUING FUNCTIONS---
function repli.stancedance()
if IsPlayerSpell(12975) == false
and UnitAffectingCombat("player")
and 100 * UnitHealth("player") / UnitHealthMax("player") < 50
and GetShapeshiftForm() ~= 2
then
	CastShapeshiftForm(2)
end

if IsPlayerSpell(12975) == false
and UnitAffectingCombat("player")
and 100 * UnitHealth("player") / UnitHealthMax("player") >= 60
and GetShapeshiftForm() ~= 1
then
	CastShapeshiftForm(1)
end
return false
end

if not GladiusBear then
	GladiusBear = CreateFrame("FRAME", nil, UIParent)
	GladiusBear:Hide()
end

function GladiusBear_OnEvent(self, event, ...)
	local type, _, sourceGUID, sourceNAME, _, _, destGUID, destNAME = select(2, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		if type == "SPELL_CAST_SUCCESS" then
			if destGUID == UnitGUID("player") then
				local spellId = select(12, ...)
				local listId = {
					110698,		-- Hammer of Justice (Paladin)
					1330,		-- Garrote - Silence
					108194,		-- Asphyxiate
					22570,		-- Maim
					5211,		-- Mighty Bash
					9005,		-- Pounce
					102546,		-- Pounce (Incarnation)
					91800,		-- Gnaw
					91797,		-- Monstrous Blow (Dark Transformation)
					44572,		-- Deep Freeze
					119381,		-- Leg Sweep
					105593,		-- Fist of Justice
					853,		-- Hammer of Justice
					1833,		-- Cheap Shot
					408,		-- Kidney Shot
					30283,		-- Shadowfury
					89766,		-- Axe Toss (Felguard/Wrathguard)
					132168		-- Shockwave
					
				}
				for i = 1, #listId do
					if listId[i] == spellId
					and GetShapeshiftForm() ~= 2 then
						CastShapeshiftForm(2)
						end
				end
			end
		end
	end
end

GladiusBear:SetScript("OnEvent", GladiusBear_OnEvent)
GladiusBear:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-----------------------
------------------------------------------------------------
------------------------------------------------------------
-------------- NORMAL Functions-----------------------------
------------------------------------------------------------
------------------------------------------------------------
if macros == nil then
	-- Macros
	macros = { 
	    ["SingleTarget"]   		= 1, 
	    ["UseCds"]			= 1, 
	   	["AoE"]   			= 1,
	} 
end
if not _singletarget then _singletarget = true
end

--------------------
-- Slash Commands --
--------------------
if SlashMacros == nil then
	SlashMacros = true
	
	--if ProbablyEngine.config.data.button_states.cooldowns then --ProbablyEngine.config.read('button_states', 'MasterToggle', false)
	if ProbablyEngine.config.read('button_states', 'cooldowns', false) then
	macros["UseCds"] = true 
	else macros["UseCds"] = false
	end
		SLASH_SHOUTTOGGLE1 = "/shouttoggle"
	function SlashCmdList.SHOUTTOGGLE(msg, editbox)
		if macros["ShoutToggle"] == false then
			macros["ShoutToggle"] = true
			print("SHOUT: |cFFFFD700Battle Shout")
			--ProbablyEngine.buttons.toggle('cooldowns')	
		else
			print("SHOUT: |cFFFFD700Commanding Shout") 
			--ProbablyEngine.buttons.toggle('cooldowns')
			macros["ShoutToggle"] = false
		end
	end
	
	SLASH_USECDS1 = "/usecds"
	function SlashCmdList.USECDS(msg, editbox)
		if macros["UseCds"] == false then
			macros["UseCds"] = true
			print("COOLDOWNS: |cFFFFD700ENABLED")
			ProbablyEngine.buttons.toggle('cooldowns')	
		else
			print("COOLDOWNS: |cFFFFD700DISABLED") 
			ProbablyEngine.buttons.toggle('cooldowns')
			macros["UseCds"] = false
		end
	end
	if ProbablyEngine.config.read('button_states', 'multitarget', false) then 
	macros["AoE"] = true 
	else macros["AoE"] = false
	end
	SLASH_AOE1 = "/aoe"
	function SlashCmdList.AOE(msg, editbox)
		if macros["AoE"] == false then
			macros["AoE"] = true
			print("AOE: |cFF008000ENABLED")
			ProbablyEngine.buttons.toggle('multitarget')
		else
			print("AOE: |cFF008000DISABLED") 
			ProbablyEngine.buttons.toggle('multitarget')
			macros["AoE"] = false
		end
	end
	
	SLASH_SINGLETARGET1 = "/singletarget"
	function SlashCmdList.SINGLETARGET(msg, editbox)
		if macros["SingleTarget"] == 1 then
		   macros["SingleTarget"] = 2
			print("ROTATION: |cFFFF0000TWO TARGET")	
		elseif macros["SingleTarget"] == 2 then
		  macros["SingleTarget"] = 3
			print("ROTATION: |cFFFF0000THREE TARGET") 
		else 
		macros["SingleTarget"] = 1
		print("ROTATION: |cFFFF0000SINGLE TARGET") 
		end
	end

	SLASH_DECREASETARGET1 = "/decreasetarget"
	function SlashCmdList.DECREASETARGET(msg, editbox)
		if macros["SingleTarget"] == 3 then
		   macros["SingleTarget"] = 2
			print("ROTATION: |cFFFF0000TWO TARGETr")	
		elseif macros["SingleTarget"] == 2 then
		  macros["SingleTarget"] = 1
			print("ROTATION: |cFFFF0000SINGLE TARGET") 
		else 
		macros["SingleTarget"] = 3
		print("ROTATION: |cFFFF0000THREE TARGET") 
		end
	end
end
-----------------------------------
-----------------------------------
-----------TRINKET CHECK-----------

-- Unerring Vision of Lei-Shen
local testEvil = {
	104993, -- EvilEye Raid Finder
	  104744, -- Flexible
	  102298, -- Normal
	  105242, -- Warforged
	  104495, -- Heroic
	  105491, -- Heroic Warforged
}
itemCheck = nil
function itemCheck(tbl)
	local itemCount = 0
	for i=1,#tbl do
		if IsEquippedItem(tbl[i]) then itemCount = itemCount + 1 end
	end
	return itemCount
end


-- Initialize Trinkets
local itemCheck = itemCheck
local testEvil = testEvil
function repli.testor()
if itemCheck(testEvil) == 1 
then
return true
end
end
-----------------------------------
-----------------------------------
-----------------------------------
-----------------------------------
----FUNCTIONS FOR SLASH COMMANDS---
-----------------------------------
-----------------------------------
singletargetrota = nil
function repli.singletargetrota()
if macros["SingleTarget"] == 1 
then
return true
else return false
end
end

twotargetrota = nil
function repli.twotargetrota()
if macros["SingleTarget"] == 2
then
return true
else return false
end
end

threetargetrota = nil
function repli.threetargetrota()
if macros["SingleTarget"] == 3
then
return true
else return false
end
end

-------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
function UnitBuffID(unit, spell, filter)
	if not unit or unit == nil or not UnitExists(unit) then 
		return false 
	end
	if spell then 
		spell = GetSpellInfo(spell) 
	else 
		return false 
	end
	if filter then 
		return UnitBuff(unit, spell, nil, filter) 
	else 
		return UnitBuff(unit, spell) 
	end
end
function UnitDebuffID(unit, spell, filter)
	if not unit or unit == nil or not UnitExists(unit) then 
		return false 
	end
	if spell then 
		spell = GetSpellInfo(spell) 
	else 
		return false 
	end
	if filter then 
		return UnitDebuff(unit, spell, nil, filter) 
	else 
		return UnitDebuff(unit, spell) 
	end
end

function rangeCheck(spellid,unit)
if IsSpellInRange(GetSpellInfo(spellid),unit) == 1
then
	return true
end
return false
end

function getHp(unit)
if UnitExists(unit)
	then
		return 100 * UnitHealth(unit) / UnitHealthMax(unit)
	else return false
	end
end
function cdRemains(spellid)
	if select(2,GetSpellCooldown(spellid)) + (select(1,GetSpellCooldown(spellid)) - GetTime()) > 0
		then return select(2,GetSpellCooldown(spellid)) + (select(1,GetSpellCooldown(spellid)) - GetTime())
	else return 0
	end
end
function HaveBuff(UnitID,SpellID,TimeLeft,Filter) 
  if not TimeLeft then TimeLeft = 0 end
  if type(SpellID) == "number" then SpellID = { SpellID } end 
  for i=1,#SpellID do 
    local spell, rank = GetSpellInfo(SpellID[i])
    if spell then
      local buff = select(7,UnitBuff(UnitID,spell,rank,Filter)) 
      if buff and ( buff == 0 or buff - GetTime() > TimeLeft ) then return true end
      end
  end
end

function HaveDebuff(UnitID,SpellID,TimeLeft,Filter) 
  if not TimeLeft then TimeLeft = 0 end
  if type(SpellID) == "number" then SpellID = { SpellID } end 
  for i=1,#SpellID do 
    local spell, rank = GetSpellInfo(SpellID[i])
    if spell then
      local debuff = select(7,UnitDebuff(UnitID,spell,rank,Filter)) 
      if debuff and ( debuff == 0 or debuff - GetTime() > TimeLeft ) then return true end
     end
  end
end

CheckCastTime = {}
repli.LastCast = nil
function repli.LastCast(spellid, ytime)
	if ytime > 0 then
		if #CheckCastTime > 0 then
			for i=1, #CheckCastTime do
				if CheckCastTime[i].SpellID == spellid then
					if GetTime() - CheckCastTime[i].CastTime > ytime then
						CheckCastTime[i].CastTime = GetTime()
						return true
					else
						return false
					end
				end
			end
		end
		table.insert(CheckCastTime, { SpellID = spellid, CastTime = GetTime() } )
		return true
	elseif ytime <= 0 then
		return true
	end
	return false
end

--Intervene Banner--
function IsHealer(unit)
local class = select(2, UnitClass(unit))
if (class == "DRUID" or class =="PALADIN" or class =="PRIEST" or class =="MONK" or class =="SHAMAN")
and UnitPowerMax(unit) >= 290000
and not UnitBuffID(unit, 24858)
and not UnitBuffID(unit, 15473)
and not UnitBuffID(unit, 324)
then
return true
end
end

---------------------------------------------------------------
function CalculateHP(t)
  incomingheals = UnitGetIncomingHeals(t) or 0
  return 100 * ( UnitHealth(t) + incomingheals ) / UnitHealthMax(t)
end

function CanHeal(t)
  if UnitInRange(t) and UnitCanCooperate("player",t) and not UnitIsEnemy("player",t) 
  and not UnitIsCharmed(t) and not UnitIsDeadOrGhost(t) and UnitExists(t)
  then return true end 
end

function GroupInfo()
  members, group = { { Unit = "player", HP = CalculateHP("player"), IsPlayer = true } }, { low = 0, tanks = { } } 
  group.type = IsInRaid() and "raid" or "party" 
  group.number = GetNumGroupMembers()
  for i=1,group.number do if CanHeal(group.type..i) then 
    local unit, hp = group.type..i, CalculateHP(group.type..i) 
    table.insert( members,{ Unit = unit, HP = hp, IsPlayer = true } ) 
    if hp <= 94 then group.low = group.low + 1 end 
    if UnitGroupRolesAssigned(unit) == "TANK" then table.insert(group.tanks,unit) end   
  end end 
  if group.type == "raid" and #members > 1 then table.remove(members,1) end 
  
  
 -- Checking Pets in the group
 for i=1,group.number do
		if CanHeal(group.type..i.."pet") then
			local memberpet, memberpethp = nil, nil
			if UnitAffectingCombat("player") then
				 memberpet = group.type..i.."pet" 
				 memberpethp = CalculateHP(group.type..i.."pet") 
			else
				 memberpet = group.type..i.."pet"
				 memberpethp = CalculateHP(group.type..i.."pet")
			end
			
			table.insert(members, { Unit = memberpet, HP = memberpethp, IsPlayer = false } )
		end
  end
  
  
  table.sort(members, function(x,y) return x.HP < y.HP end)
  local customtarget = CanHeal("target") and "target" -- or CanHeal("mouseover") and GetMouseFocus() ~= WorldFrame and "mouseover" 
  if customtarget then table.sort(members, function(x) return UnitIsUnit(customtarget,x.Unit) end) end 
end

GroupInfo()


if not interveneSpell then interveneSpell = 0 end

if IsPlayerSpell(114029) == true then interveneSpell=114029 else interveneSpell =3411 end
custTarss = nil
local custTarss = {"target",
			"focus",
			"arena1",
			"arena2",
			"arena3",
			"arena4",
			"arena5"
			}
function repli.InterveneTraps()
if not SIN_InterruptFrame_created then
	SIN_InterruptFrame_created = true	
	local interruptID = {
	[1499] = true,	--Disrupting Shout
	[60192] = true	--Skull Bash
	}
	local SIN_PlayerGUID = UnitGUID("target")
	local SIN_InterruptFrame = CreateFrame("FRAME", nil, UIParent)
	SIN_InterruptFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	SIN_InterruptFrame:SetScript("OnEvent", 
		function(self, event, _, type, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID)
			for i = 1, #custTarss do
			if type == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID(custTarss[i]) and interruptID[spellID] then -- destName == SIN_PlayerGUID
			for i = 1, #members do
				       if cdRemains(interveneSpell) == 0
				       and not UnitBuffID(members[i].Unit,interveneSpell)
				       and not UnitIsUnit(members[i].Unit,"player")
				       and IsHealer(members[i].Unit)
				       then
				       PQR_CustomTarget = members[i].Unit
				         CastSpellByName(GetSpellInfo(interveneSpell),PQR_CustomTarget)
				       print("Casted ")
					   RaidNotice_AddMessage(RaidWarningFrame, "\124cFFF00000\<Trap attempt by "..sourceName..">", ChatTypeInfo["RAID_WARNING"])
				         end
				      end
				
			end	
			end	
		end)
end
return false
end
--Safeguard to banner--
--BattleShout--
function repli.BattleShout()
if macros["ShoutToggle"] == true
then
return true
end
return false
end

function repli.CommandingShout()
if macros["ShoutToggle"] == false
then
return true
end
return false
end


function repli.InterveneBanner()
if select(2,GetTotemInfo(1)) ~= nil
then
	if cdRemains(3411) == 0
	then
	TargetUnit(select(2,GetTotemInfo(1)))
	CastSpellByName(GetSpellInfo(3411),"target")
	end
	if cdRemains(3411) > 0
	and UnitExists("target")
	and UnitIsFriend("player","target")
	then
		RunMacroText("/targetlasttarget")
	end
end

--MockingBanner Throw--
if cdRemains(114192) == 0 and ( cdRemains(114203) <= 150 and cdRemains(114203) > 0 )
and GetCurrentKeyBoardFocus() == nil
then
	CastSpellByName(GetSpellInfo(114192))
		if SpellIsTargeting()
		then 
			CameraOrSelectOrMoveStart()
			CameraOrSelectOrMoveStop()
		end
		--_castSpell(114192)
		CastSpellByName(GetSpellInfo(114192))
end

--DemoBanner Throw--
if cdRemains(114203) == 0
and GetCurrentKeyBoardFocus() == nil
then
	CastSpellByName(GetSpellInfo(114203))
		if SpellIsTargeting() ~= nil
		then 
			CameraOrSelectOrMoveStart()
			CameraOrSelectOrMoveStop()
		end
		--_castSpell(114203)
		CastSpellByName(GetSpellInfo(114203))
end
end

--LEAP
function repli.Leap()
if select(2,GetSpellCooldown(6544)) == 0
then
	CastSpellByName(GetSpellInfo(6544))
		if SpellIsTargeting() ~= nil
		then 
			CameraOrSelectOrMoveStart()
			CameraOrSelectOrMoveStop()
		end
		return true
		else return false
end
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--BloodFury --buff.cooldown_reduction.down&(buff.bloodbath.up|(!talent.bloodbath.enabled&debuff.colossus_smash.up))|buff.cooldown_reduction.up&buff.recklessness.up
--function repli.BloodFury()
--if UnitExists("target") and cdRemains(20572) == 0 then
--if UnitBuffID("player",1719) ~= nil
--then
--return true
--else return false
--end
--end
--end

function repli.BloodFury()
if UnitExists("target") and cdRemains(20572) == 0 then
if not repli.testor()
	and(IsPlayerSpell(12292) == true and UnitBuffID("player",12292) ~= nil
	or (IsPlayerSpell(12292) == false and UnitDebuffID("target",86346,"player") ~= nil))
	or repli.testor() and UnitBuffID("player",1719) ~= nil
then
return true
else return false
end
end
end
	
--buff.skull_banner.down&(((cooldown.colossus_smash.remains<2|debuff.colossus_smash.remains>=5)&target.time_to_die>192&buff.cooldown_reduction.up)|buff.recklessness.up)

--Skull Banner
function repli.Skullbanner()
if UnitExists("target") and cdRemains(114207) == 0 then
if UnitBuffID("player",114207) == nil then
if (((cdRemains(86346) < 2 
	or HaveDebuff("target",86346,5,"player")) and repli.testor())
	or UnitBuffID("player",1719) ~= nil)
then
return true
else return false
end
end
end
end
--RECKLESSNESS
function repli.Recklessness()
if UnitExists("target") and cdRemains(1719) == 0 then
if ((cdRemains(86346) < 2 
		or HaveDebuff("target",86346,5,"player"))
		or getHp("target") < 20) -- wo Bloodbath talent
	or (UnitBuffID("player",12292) ~= nil
		or getHp("target") < 20)
then
return true
else return false
end
end
end

	

---------------------------------------------------------------------------------

function repli.HS() --Heroic Strike
	if UnitExists("target") then
	if ((UnitPower("player") >= 40 and UnitDebuffID("target",86346,"player"))
		and getHp("target") >= 20)
	or UnitPower("player") >= 100
	and UnitBuffID("player",12880)
	then 
		return true
	else
		return false
	end
end
end

function repli.SB() --stormbolt
	if UnitExists("target") then
	if UnitDebuffID("target",86346,"player") and repli.testor()--evil_eye >= 1
	then 
		return true
	else
		return false
	end
end
end

function repli.SBnew() --stormbolt
	if UnitExists("target") then
	if UnitDebuffID("target",86346,"player") and not repli.testor()--evil_eye < 1
	then 
		return true
	else
		return false
	end
end
end
function repli.SBnoevil() --stormbolt
	if UnitExists("target") then
	if not repli.testor()--evil_eye < 1
	then 
		return true
	else
		return false
	end
end
end

function repli.RBhigh() --raging_blow
	if UnitExists("target") then
	if UnitDebuffID("target",86346,"player")
	and getHp("target") >= 20
	then 
		return true
	else
		return false
	end
end
end

function repli.BT() --bloodthirst
	if UnitExists("target") 
	then
	if not (getHp("target") < 20
			and UnitDebuffID("target",86346,"player") ~= nil
			and UnitPower("player") >= 30
			and UnitBuffID("player",12880) ~= nil)
	then 
		return true
	else
		return false
	end
end
end

function repli.WShigh()  --wildstrike
	if UnitExists("target") then
	if UnitBuffID("player",46916) ~= nil 
	   and getHp("target") >= 20
	
	then 
		return true
	else
		return false
	end
end
end

function repli.WAIT()  --wait 
	if UnitExists("target") then
	if not ( getHp("target") < 20 
			and UnitDebuffID("target",86346,"player") ~= nil
			and UnitPower("player") >= 30
			and UnitBuffID("player",12880) ~= nil)
	and (cdRemains(23881) <= 1)
	then 
		return true
	else
		return false
	end
end
end

function repli.Execute()  --execute
	if UnitExists("target") then
	if UnitDebuffID("target",86346,"player") ~= nil
	   or UnitPower("player") > 70
	then 
		return true
	else
		return false
	end
end
end

function repli.RBmid()  --raging_blow
	if UnitExists("target") then
	if getHp("target") < 20
	or (UnitBuffID("player",131116) ~= nil
		and select(4,UnitBuffID("player",131116)) == 2)
	or ( UnitDebuffID("target",86346,"player") ~= nil)
	or not HaveBuff("player",131116,3)
	then 
		return true
	else
		return false
	end
end
end

function repli.Dragonroar() --dragon_roar
if UnitExists("target") and IsSpellInRange(GetSpellInfo(78),"target") == 1 then
if UnitDebuffID("target",86346,"player") == nil
	and ( IsPlayerSpell(12292) == true and UnitBuffID("player",12292) ~= nil
		or IsPlayerSpell(12292) == false) then
return true
else return false
end
end
end

function repli.Bladestorm() --bladestorm /bladestorm,if=enabled&buff.enrage.up&(buff.bloodbath.up|!talent.bloodbath.enabled)
if UnitExists("target") then
if UnitBuffID("player",12880) ~= nil
	and ( IsPlayerSpell(12292) == true and UnitBuffID("player",12292) ~= nil
		or IsPlayerSpell(12292) == false) then
return true
else return false
end
end
end

function repli.Bloodbath()
if UnitExists("target") then
if ( cdRemains(86346) < 2
	or HaveDebuff("target",86346,5,"player"))
then
return true
else return false
end
end
end

-----------------------------------
------TWO TARGET FUNCTIONS---------
-----------------------------------

function repli.Cleavetwo()
if UnitExists("target") then
if (UnitPower("player") >= 60
	and UnitDebuffID("target",86346,"player") ~= nil)
	or UnitPower("player") > 90 then
return true
else return false
end
end
end

function repli.rbtwo() 
if UnitExists("target") then
if (UnitBuffID("player",131116) ~= nil
    and UnitBuffID("player",85739) ~= nil)
	or (UnitBuffID("player",131116) ~= nil
		and getHp("target") < 20)
then
return true 
else return false
end
end
end

---------------------------------------
---------------------------------------
------------PVP STUFF------------------
---------------------------------------
---------------------------------------
bersibrakes = nil
local bersibrakes = {
	"115078", --Monk Para
	"10326", -- Turn Evil Pala
	"5782", -- Fear Wl
	"118699", --Fear WL
	"113004", --Warri Fear
	"113056", --Warri Fear
	"64044", --gwgw
	"8122", 
	"113792", 
	"1776",
	"6770",
	"5484",
	"5246",
	"20511"
}
function repli.breakfear()
for i=1, #bersibrakes do
if UnitDebuffID("player",bersibrakes[i]) ~= nil
then
return true
end
end
return false
end
ArenaTars = nil
local ArenaTars = {
			"target",
			"focus",
			"arena1",
			"arena2",
			"arena3",
			"arena4",
			"arena5"
			}	
function repli.ArenaTargets()
for i = 1, #ArenaTars do
if UnitExists(ArenaTars[i])
and UnitCanAttack("player",ArenaTars[i])
then return true
end
end
return false
end

function repli.ExecuteArenaTars()
for i = 1, #ArenaTars do
if UnitExists(ArenaTars[i])
and UnitCanAttack("player",ArenaTars[i])
and repli.notImmune(ArenaTars[i])
and (100 * UnitHealth(ArenaTars[i]) / UnitHealthMax(ArenaTars[i])) <= 20
and IsSpellInRange(GetSpellInfo(78),ArenaTars[i]) == 1
then
CastSpellByName(GetSpellInfo(5308),ArenaTars[i])
end
end
end

function repli.HarmstringArenaTars()
for i=1, #ArenaTars do
if IsSpellInRange(GetSpellInfo(78),ArenaTars[i]) == 1
and UnitDebuffID(ArenaTars[i],1715) == nil
and repli.notSlowed(ArenaTars[i])
and repli.SlowUnit(ArenaTars[i])
and repli.notImmune(ArenaTars[i])
and not UnitIsUnit("playertarget", ArenaTars[i])
then 
CastSpellByName(GetSpellInfo(1715),ArenaTars[i])
end 
end
end
----------------------
-------SLOWS PVP------
----------------------
if interruptberechner == nil then
	interruptberechner = 0
end

if GetTime() - interruptberechner > 2 then
	interruptberechner = GetTime()

maxMSinterrupt = math.random(45,70) -- max50,80 war standard casttime left for interrupt and spellreflect (0.2 -0.55 ms)

minMSinterrupt = 80  -- min casttime left for interrupt and spellreflect

channelInterruptmin = math.random(10,24) -- min channel left for interrupt

channelInterruptmax = math.random(40,80) -- max channel left for interrupt


end

custTars = nil
local custTars = {
			"target",
			"focus",
			"arena1",
			"arena2",
			"arena3",
			"arena4",
			"arena5"
			}	

channelInt = nil
local channelInt = { 
1120, -- Drain Soul		(channeling cast)
12051, -- Evocation		(channeling cast)
115294, -- Mana Tea		(channeling cast)
115175, -- Soothing Mist	(channeling cast)
64843, -- Divine Hymn		(channeling cast)
64901, -- Hymn of Hope		(channeling cast)
47540 -- Penance
}

castInt = nil
local castInt = { 
116, -- Frostbolt
2637, -- Hibernate
331, -- Healing Wave
5782, --Fear
30108, --Unstable Affliction
33786, -- Cyclone		(cast)
28272, -- Pig Poly		(cast)
118, -- Sheep Poly		(cast)
61305, -- Cat Poly		(cast)
61721, -- Rabbit Poly		(cast)
61780, -- Turkey Poly		(cast)
28271, -- Turtle Poly		(cast)
51514, -- Hex			(cast)
51505, -- Lava Burst		(cast)
117014,		-- Elemental Blast
339, -- Entangling Roots	(cast)
30451, -- Arcane Blast		(cast)
20066, --Repentance		(cast)
116858, --Chaos Bolt		(cast)
113092, --Frost Bomb		(cast)
8092, --Mind Blast		(cast)
48181, --Haunt			(cast)
102051, --Frost Jaw		(cast)
1064, -- Chain Heal		(cast)
77472, -- Greater Healing Wave	(cast)
8004, -- Healing Surge		(cast)
73920, -- Healing Rain		(cast)
51505, -- Lava Burst		(cast)
8936, -- Regrowth		(cast)
2061, -- Flash Heal		(cast)
2060, -- Greater Heal		(cast)
32375, -- Mass Dispel		(cast)
2006, -- Resurrection		(cast)
5185, -- Healing Touch		(cast)
596, -- Prayer of Healing	(cast)
19750, -- Flash of Light	(cast)
635, -- Holy Light		(cast)
7328, -- Redemption		(cast)
2008, -- Ancestral Spirit	(cast)
50769, -- Revive		(cast)
2812, -- Denounce		(cast)
82327, -- Holy Radiance		(cast)
10326, -- Turn Evil		(cast)
82326, -- Divine Light		(cast)
82012, -- Repentance		(cast)
116694, -- Surging Mist		(cast)
124682, -- Enveloping Mist	(cast)
115151, -- Renewing Mist	(cast)
115310, -- Revival		(cast)
126201, -- Frost Bolt		(cast)
133, -- Fireball		(cast)
1513, -- Scare Beast		(cast)
982, -- Revive Pet		(cast)
111771, -- Demonic Gateway			(cast)
124465, -- Vampiric Touch			(cast)
32375 -- Mass Dispel				(cast) 
}
function repli.disrupting()
local castingTarget = nil
for i=1, #custTars do
	if ( select(9,UnitCastingInfo(custTars[i]))==false 
		or select(8,UnitChannelInfo(custTars[i]))==false )
	then
			castingTarget = custTars[i]
	end
end
if UnitExists(castingTarget) and castingTarget ~= nil
--and spellReflect(castingTarget) == nil
and UnitBuffID("player",23920) == nil
then
	local cName, _, _, _, cStart,cEnd = UnitCastingInfo(castingTarget)
	local chName, _, _, _, chStart,chEnd = UnitChannelInfo(castingTarget)
	if chName ~= nil then
		cName = chName
		cStart = chStart
		cEnd = chEnd
	end
	local timeSinceStart = (GetTime() * 1000 - cStart) / 1000
	local timeLeft = ((GetTime() * 1000 - cEnd) * -1) / 1000 
    local castTime = cEnd - cStart 
    local currentPercent = timeSinceStart / castTime * 100000
--DS--
	if (cdRemains(6552) > 0 or rangeCheck(6552,castingTarget) == nil)
	and cdRemains(102060) == 0
	--and not (repli.LastCast(6552, 1))
	and CheckInteractDistance(castingTarget,3) ~= nil
	and UnitIsEnemy("player",castingTarget) ~= nil
	then
	for y=1, #castInt do
	if GetSpellInfo(castInt[y]) == cName and --currentPercent >= intPctDelay 
	currentPercent > maxMSinterrupt  
	and currentPercent < minMSinterrupt
	then
	--and ( PQR_IsOnInterruptList(cName) ~= nil or PQR_IsInterruptAll() ~= nil )
	CastSpellByName(GetSpellInfo(102060))
		end
		end
		end
	--ChannelDS--
	if (cdRemains(6552) > 0 or rangeCheck(6552,castingTarget) == nil)
	and cdRemains(102060) == 0
	--and not (repli.LastCast(1, 1))
	and CheckInteractDistance(castingTarget,3) ~= nil
	and UnitIsEnemy("player",castingTarget) ~= nil
	then
	for c=1, #channelInt do
	if GetSpellInfo(channelInt[c]) == cName and --currentPercent >= intPctDelay 
	currentPercent < channelInterruptmax  
	and currentPercent > channelInterruptmin 

	then
	--and ( PQR_IsOnInterruptList(cName) ~= nil or PQR_IsInterruptAll() ~= nil )
	CastSpellByName(GetSpellInfo(102060))
		end
		end
		end
	end
return false
end


function repli.pummel()
local castingTarget = nil
for i=1, #custTars do
	if ( select(9,UnitCastingInfo(custTars[i]))==false 
		or select(8,UnitChannelInfo(custTars[i]))==false )
	then
			castingTarget = custTars[i]
	end
end

--NORMAL INTERRUPTS--
if UnitExists(castingTarget) and castingTarget ~= nil
--and spellReflect(castingTarget) == nil
and UnitBuffID("player",23920) == nil
then
	local cName, _, _, _, cStart,cEnd = UnitCastingInfo(castingTarget)
	local chName, _, _, _, chStart,chEnd = UnitChannelInfo(castingTarget)
	if chName ~= nil then
		cName = chName
		cStart = chStart
		cEnd = chEnd
	end
	local timeSinceStart = (GetTime() * 1000 - cStart) / 1000
	local timeLeft = ((GetTime() * 1000 - cEnd) * -1) / 1000 
    local castTime = cEnd - cStart 
    local currentPercent = timeSinceStart / castTime * 100000

	
--Pum normal Casts--
	if cdRemains(6552) == 0
	and rangeCheck(6552,castingTarget) == true
	then
    -- ( PQR_IsOnInterruptList(cName) ~= nil or PQR_IsInterruptAll() ~= nil )
    for y=1, #castInt do
	if GetSpellInfo(castInt[y]) == cName and --currentPercent >= intPctDelay 
	currentPercent > maxMSinterrupt  
	and currentPercent < minMSinterrupt
	then
			CastSpellByName(GetSpellInfo(6552),castingTarget)
			--_castSpell(6552,castingTarget)
		end
		end
	end
	--ChannelCasts--
	if cdRemains(6552) == 0
	and rangeCheck(6552,castingTarget) == true
	then
    -- ( PQR_IsOnInterruptList(cName) ~= nil or PQR_IsInterruptAll() ~= nil )
    for c=1, #channelInt do
	if GetSpellInfo(channelInt[c]) == cName and --currentPercent >= intPctDelay 
	currentPercent < channelInterruptmax  
	and currentPercent > channelInterruptmin 
	then
			CastSpellByName(GetSpellInfo(6552),castingTarget)
		end
		end
	end
end
return false
end
--END NORMAL INTERRUPTS--
local immunDispel = {
	45438,		-- Ice Block
	110700,		-- Divine Shield (Paladin)
	110696,		-- Ice Block (Mage)
	45438,		-- Ice Block
	1022, 		--Hand of Protection
	642			-- Divine Shield
}

function iDispel(unit)
	for i=1,#immunDispel do
		if UnitBuffID(unit,immunDispel[i])
			then
				return true
			end
		end
end
function repli.ShatteringThrow()
for i=1, #custTars do
if iDispel(custTars[i]) ~= nil
and IsSpellInRange(GetSpellInfo(57755),custTars[i]) == 1
and UnitExists(custTars[i]) ~= nil
	then
		CustomTarget = custTars[i]
		CastSpellByName(GetSpellInfo(64382),CustomTarget)
	end
end
return false
end

--DISARM--
disarmID = nil
local disarmID = {
				-- DEATH KNIGHT (Pillar of Frost)
					51271,
					49016, -- Unholy Frenzy
					79140, -- Vendetta
				-- DRUID
				-- HUNTER (Bestial Wrath)
					19574,
				-- MAGE
				-- MONK
				-- PALADIN (Avenging Wrath)
					31884,
				-- PRIEST
				-- ROGUE (Shadow Dance / Adrenaline Rush)
					51713,
					13750,
				-- SHAMAN
				-- WARLOCK
				-- WARRIOR (Recklessness / Avatar / Bladestorm)
					1719,
					107574
}
function shouldDisarm(unit)
	for i=1,#disarmID do
		if UnitBuffID(unit,disarmID[i]) ~= nil
			then 
				return true
			end	
		end
	end

function repli.Disarm()
for i=1, #ArenaTars do
if UnitExists(ArenaTars[i]) 
and UnitIsPlayer(ArenaTars[i])
and UnitCanAttack("player",ArenaTars[i]) 
and UnitPowerMax(ArenaTars[i]) < 200000
and cdRemains(676) == 0
and shouldDisarm(ArenaTars[i]) ~= nil 
and rangeCheck(78,ArenaTars[i])
then
CustomTarget = ArenaTars[i]
CastSpellByName(GetSpellInfo(676),CustomTarget)
end
end
return false
end

immuneToSlow = nil
local immuneToSlow	= {
					-- DEATH KNIGHT
					-- DRUID
					-- HUNTER (Master's Call / Bestial Wrath)
						"54216",
						"19574",
					-- MAGE (Ice Block)
						"45438",
					-- MONK
					-- PALADIN (Hand of Freedom / Hand of Protection / Divine Shield)
						"1044",
						"1022",
						"642",
					-- PRIEST (Dispersion)
						"47585",
					-- ROGUE
					-- SHAMAN (Windwalk Totem)
						"114896",
					-- WARLOCK
					-- WARRIOR (Avatar / Bladestorm)
						"107574",
						"46924"
				}	
function repli.SlowUnit(unit)
for i=1,#immuneToSlow do
	if UnitBuffID(unit,immuneToSlow[i]) == nil
		then
	    return true
		end
	end
	return false
end
	
PvPslows = nil
local PvPslows 			= {
	45524,		-- Chains of Ice
	50435,		-- Chilblains
	115000,		-- Remorseless Winter
	50259,		-- Dazed 
	58180,		-- Infected Wounds
	61391,		-- Typhoon
	127797,		-- Ursol's Vortex
	82941,		-- Ice Trap (Hunter)
	135299,		-- IceTrap Debuff
	35101,		-- Concussive Barrage
	5116,		-- Concussive Shot
	61394,		-- Frozen Wake 
	13810,		-- Ice Trap
	50433,		-- Ankle Crack 
	54644,		-- Frost Breath 
	121288,		-- Chilled 
	120,		-- Cone of Cold
	116,		-- Frostbolt
	44614,		-- Frostfire Bolt
	113092,		-- Frost Bomb
	31589,		-- Slow
	116095,		-- Disable
	118585,		-- Leer of the Ox
	123727,		-- Dizzying Haze
	123586,		-- Flying Serpent Kick
	110300,		-- Burden of Guilt
	63529,		-- Dazed - Avenger's Shield
	20170,		-- Seal of Justice
	15407,		-- Mind Flay
	3409,		-- Crippling Poison
	26679,		-- Deadly Throw
	119696,		-- Debilitation
	3600,		-- Earthbind 
	77478,		-- Earthquake 
	8034,		-- Frostbrand Attack
	8056,		-- Frost Shock
	51490,		-- Thunderstorm
	18223,		-- Curse of Exhaustion
	47960,		-- Shadowflame
	1715,		-- Hamstring
	12323,		-- Piercing Howl
	1604		-- Dazed 
}		


function repli.notSlowed(unit)
for i=1, #PvPslows do
if UnitDebuffID(unit,PvPslows[i]) ~= nil
then 
return false 
end
end
return true
end	

local specialtarstotem = "Lightwell"	

function repli.notLightwell()
if repli.ArenaTargets()
and not ( specialtarstotem == UnitName("target") )
then return true
end
return false
end

local function UnitIsPet(unit)
	local guidtype = tonumber(strsub(UnitGUID(unit),5,5),16)%8
	if guidtype==4 then return true end
	return false
end

function repli.notTotem()
if UnitExists("target")
and not (type == "Totem")
and not UnitIsPet("target")
then return true
end
return false
end
----------------
--ImmuneSpells--
----------------
iSpells = nil
local iSpells = {
"33786", -- Cyclone
"113506", -- Cyclone
"45438",	-- Ice Block
"110700",		-- Divine Shield (Paladin)
"110696",		-- Ice Block (Mage)
"19263",		-- Deterrence
"45438",		-- Ice Block
"122464",		-- Dematerialize
"122470",		-- touch of karma
"642"		-- Divine Shield
}
function repli.notImmune(unit)
for i=1 , #iSpells do
if UnitBuffID(unit,iSpells[i]) ~= nil
then
return false
end
end
return true
end

function repli.Overpower()
if (not UnitDebuffID("target",86346,"player") ~= nil or UnitPower("player") <= 34 or (UnitDebuffID("target",86346,"player") ~= nil 
and UnitPower("player") < 35) or HaveBuff("player",139958,0) or HaveBuff("target",5277,0))
and UnitCanAttack("player","target") 
then 
return true
end
return false
end

 if not allesqueue then
 if not fSS then fSS=CreateFrame("Frame") end
function SpellSUCCEEDED(spellID,spellTARGET)
	local spellID = spellID or 0
	local spellTARGET = spellTARGET or "player"	
	fSS:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	function fSSOnEvent(self,event,...)
		if event=="COMBAT_LOG_EVENT_UNFILTERED" then				
			local _, subEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, lspellID, _  = ...				
			if subEvent ~= nil then
				if subEvent=="SPELL_CAST_SUCCESS" then					
					local player=UnitGUID("player") or ""					
					if sourceGUID ~= nil then
						if sourceGUID==player then 							
							local tuid=UnitGUID(spellTARGET) or ""
							if destGUID ~= nil then
								if destGUID==tuid then									
									if lspellID ~= nil then
										if tonumber(lspellID) == tonumber(spellID) then
										if #Queue_Spell > 0 then
										print("\124cFFFF55FFQueue System: succeeded cast "..GetSpellInfo(spellID).." on "..UnitName(spellTARGET).." - Unit: "..spellTARGET)
	RaidNotice_AddMessage(RaidWarningFrame, "\124cFFF00000\Cast "..GetSpellInfo(spellID).." on "..UnitName(spellTARGET).." - Unit: "..spellTARGET, ChatTypeInfo["RAID_WARNING"])
												table.remove(Queue_Spell,1)
												return true
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	fSS:SetScript("OnEvent",fSSOnEvent)
end

--Queue System
SLASH_VQUEUE1 = "/vqueue"
function SlashCmdList.VQUEUE(msg, editbox)		
	local spellid, unit = msg:match("^(%S*)%s*(.-)$");
	if tonumber(spellid) ~= nil and unit ~= "" then 			
		if not UnitExists(tostring(unit)) then			
			print("unit not exist");
		elseif not IsSpellKnown(tonumber(spellid)) then
			print("spell unknown");
		else
			if not Queue_Spell then
				Queue_Spell = { }	
			end				
			table.insert(Queue_Spell, { Unit = unit, SpellID = spellid, Time = GetTime() } )
		end
	else
		print("Syntax: /vqueue spellid unit");
	end
end
function repli.queuespell()
if Queue_Spell then
		if #Queue_Spell > 0 then	
			if GetTime() - Queue_Spell[1].Time >= 2.5 then
				Queue_Spell = { }				
				return true
			end			
			if #Queue_Spell > 1 then			
				if Queue_Spell[1].SpellID == Queue_Spell[2].SpellID and Queue_Spell[1].Unit == Queue_Spell[2].Unit then
					table.remove(Queue_Spell,2)	
					return true	
				end
			end
			
			local qunit = "player"
			
			if cdRemains(tonumber(Queue_Spell[1].SpellID)) == 0
			and UnitExists(qunit)
			then
				if not UnitChannelInfo("player")
				and not UnitCastingInfo("player") 
				then					
				if IsSpellInRange(GetSpellInfo(Queue_Spell[1].SpellID),Queue_Spell[1].Unit) == 1 then
							qunit = Queue_Spell[1].Unit	
				else
							qunit = "player"				
				end
				end
					SpellSUCCEEDED(Queue_Spell[1].SpellID,qunit)
					CastSpellByName(tostring(GetSpellInfo(Queue_Spell[1].SpellID)),qunit)									
					--return true						
				end
			end	
		end	
	return false
end		

	
	if not Setup then
  
   RunMacroText("/vqeue") -- The first time run, it always returns insecure, so getting that first run out of the way
  Setup = true
end

allesqueue = true end

ProbablyEngine.library.register("repli", repli)