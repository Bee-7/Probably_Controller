-- Initialize tables
if not cont then cont = { }
end
------------------------------------------------------------
------------------------------------------------------------
-------------- NORMAL Functions-----------------------------
------------------------------------------------------------
------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
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
end


CheckCastTime = {}
cont.LastCast = nil
function cont.LastCast(spellid, ytime)
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

 ---------------------------------------
---------------------------------------
------------PVP STUFF------------------
---------------------------------------
---------------------------------------

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
function cont.ArenaTargets()
for i = 1, #ArenaTars do
if UnitExists(ArenaTars[i])
and UnitCanAttack("player",ArenaTars[i])
then return true
end
end
return false
end

if interruptberechner == nil then
	interruptberechner = 0
end

if GetTime() - interruptberechner > 2 then
	interruptberechner = GetTime()

maxMSinterrupt = math.random(10,90) -- max50,80 war standard casttime left for interrupt and spellreflect (0.2 -0.55 ms)

minMSinterrupt = 95  -- min casttime left for interrupt and spellreflect

channelInterruptmin = math.random(10,36) -- min channel left for interrupt

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
198590, -- Drain Soul		(channeling cast)
231565, -- Evocation		(channeling cast)
12051, -- Evocation			(channeling cast)
197908, -- Mana Tea		(channeling cast)
193884, -- Soothing Mist	(channeling cast)
64843, -- Divine Hymn		(channeling cast)
47540, -- Penance
15407, -- Mind Flay
198013, -- Eye Beam
211053
}

castInt = nil
local castInt = { 
116, -- Frostbolt
84868, -- Hibernate
77472, -- Healing Wave
5782, --Fear
30108, --Unstable Affliction
33786, -- Cyclone			(cast)
209753, --Cyclone			(cast)
28272, -- Pig Poly			(cast)
118, -- Sheep Poly			(cast)
61305, -- Cat Poly			(cast)
61721, -- Rabbit Poly		(cast)
61780, -- Turkey Poly		(cast)
71319, -- Turkey Poly 		(cast)
126819, -- porcupine Poly 	(cast)
161353, -- Bear Poly 		(cast)
161354, -- Monkey Poly 		(cast)
161355, -- penguin Poly 	(cast)
161372, -- peacock Poly 	(cast)
218434, -- Sheep Poly 		(cast)
219393, -- Sheep Poly 		(cast)
219394, -- Turkey Poly 		(cast)
219398, -- Turtle Poly		(cast)
219399, -- Serpent Poly 	(cast)
219400, -- Rabbit Poly		(cast)
219401, -- porcupine Poly 	(cast)
219402, -- Bear Poly 		(cast)
219403, -- Pig Poly			(cast)
219404, -- penguin Poly 	(cast)
219405, -- peacock Poly 	(cast)
219406, -- Monkey Poly 		(cast)
219407, -- Cat Poly			(cast)
28271, -- Turtle Poly		(cast)
61025, -- Serpent Poly 		(cast)
51514, -- Frog Hex			(cast)
219219, -- Spider Hex 		(cast)
219218, -- Snake Hex 		(cast)
219217, -- cockroach Hex 	(cast)
219216, -- compy Hex 		(cast)
219215, -- Frog Hex 		(cast)
211015, -- cockroach Hex 	(cast)
211010, -- Snake Hex 		(cast)
211004, -- Spider Hex 		(cast)
210873, -- compy Hex 		(cast)
196942, -- Frog Hex 		(cast)
51505, -- Lava Burst		(cast)
117014,	-- Elemental Blast	(cast)
339, -- Entangling Roots	(cast)
30451, -- Arcane Blast		(cast)
20066, --Repentance			(cast)
116858, --Chaos Bolt		(cast)
113092, --Frost Bomb		(cast)
112948, -- Frost Bomb 		(cast)
8092, --Mind Blast			(cast)
605, -- Mind Control		(cast)
48181, --Haunt				(cast)
183357,
171788,
32546, -- Binding Heal 		(cast)
1064, -- Chain Heal			(cast)
231780,
77472, -- Healing Wave		(cast)
8004, -- Healing Surge		(cast)
188070,
73920, -- Healing Rain		(cast)
51505, -- Lava Burst		(cast)
8936, -- Regrowth			(cast)
2061, -- Flash Heal			(cast)
2060, -- Heal				(cast)
215960, -- Greater Heal		(cast)

2006, -- Resurrection		(cast)
212036,
5185, -- Healing Touch		(cast)
596, -- Prayer of Healing	(cast)
78966,
30604,
19750, -- Flash of Light	(cast)
82326, -- Holy Light		(cast)
7328, -- Redemption			(cast)
2008, -- Ancestral Spirit	(cast)
212048,
50769, -- Revive			(cast)
82012, -- Repentance		(cast)
20066,
29511,
116694, -- Surging Mist		(cast)
124682, -- Enveloping Mist	(cast)
212414,
227345,
115310, -- Revival			(cast)
133, -- Fireball			(cast)
982, -- Revive Pet			(cast)
111771, -- Demonic Gateway	(cast)
48017,
34914, -- Vampiric Touch	(cast)
32375 -- Mass Dispel		(cast) 

}
function cont.disrupting()
local castingTarget = nil
for i=1, #custTars do
	if ( select(9,UnitCastingInfo(custTars[i]))==false 
		or select(8,UnitChannelInfo(custTars[i]))==false )
	then
			castingTarget = custTars[i]
	end
end

if UnitExists(castingTarget) and castingTarget ~= nil

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
--DB--
	if cdRemains(2139) > 0 
	and cdRemains(31661) == 0
	and CheckInteractDistance(castingTarget,3) ~= nil
	and UnitIsEnemy("player",castingTarget) ~= nil
	then
	for y=1, #castInt do
	if GetSpellInfo(castInt[y]) == cName and --currentPercent >= intPctDelay 
	currentPercent > maxMSinterrupt  
	and currentPercent < minMSinterrupt
	then
	
	CastSpellByName(GetSpellInfo(31661))
		end
		end
		end
	--ChannelDS--
	if cdRemains(2139) > 0 
	and cdRemains(31661) == 0
	and CheckInteractDistance(castingTarget,3) ~= nil
	and UnitIsEnemy("player",castingTarget) ~= nil
	then
	for c=1, #channelInt do
	if GetSpellInfo(channelInt[c]) == cName and --currentPercent >= intPctDelay 
	currentPercent < channelInterruptmax  
	and currentPercent > channelInterruptmin 

	then
	CastSpellByName(GetSpellInfo(31661))
		end
		end
		end
	end
return false
end

function cont.Counter()
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

	
--Counter normal Casts--
	if cdRemains(2139) == 0
	and rangeCheck(2139,castingTarget) == true
	then
    for y=1, #castInt do
	if GetSpellInfo(castInt[y]) == cName and
	currentPercent > maxMSinterrupt  
	and currentPercent < minMSinterrupt
	then
			CastSpellByName(GetSpellInfo(2139),castingTarget)
			end
		end
	end
	--ChannelCasts--
	if cdRemains(2139) == 0
	and rangeCheck(2139,castingTarget) == true
	then
    for c=1, #channelInt do
	if GetSpellInfo(channelInt[c]) == cName and 
	currentPercent < channelInterruptmax  
	and currentPercent > channelInterruptmin 
	then
			CastSpellByName(GetSpellInfo(2139),castingTarget)
		end
		end
	end
end
return false
end
--END NORMAL INTERRUPTS--

----------------
--ImmuneSpells--
----------------
iSpells = nil
local iSpells = {
"33786", -- Cyclone
"209753", -- Cyclone
"88010",
"45438",	-- Ice Block
"145533",
"41590",
"36911",
"27619",
"63148",		-- Divine Shield (Paladin)
"133093",
"186265",		-- Deterrence
"122464",		-- Dematerialize
"122465",
"122470",
"124280",
"125174",		-- touch of karma
"205727",
"48707",
"51052",
"23920",	-- Spell Reelction
"216890",
"213915",
"31224",
"39666",
"81549",
"642"		-- Divine Shield
}
function cont.notImmune(unit)
for i=1 , #iSpells do
if UnitBuffID(unit,iSpells[i]) ~= nil
then
return false
end
end
return true
end
--------------------------------------------------------------------

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
function cont.queuespell()
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

ProbablyEngine.library.register("cont", cont)
