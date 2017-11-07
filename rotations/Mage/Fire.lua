ProbablyEngine.rotation.register_custom(63, "Contmage - A Mage pvp CR",
  --In combat

 {
 {"pause", { 
 "@cont.queuespell()",}},
 {"pause", "modifier.lshift"},

   -- Survivability
  { "212653", { "talent(2, 1)" }, "target.range <= 3" }, -- Shimmer
  { "235313", "player.buff(235313).duration <= 1" }, --Blazing Barrier
  { "66", "player.health <= 10" }, -- Invisibility
  --{ "130", { "player.falling.duration > 2", "!player.buff(130)"} },
  -- { "31661", { "!target.state.immune.spell", "!target.state.disorient", "!target.state.incapacitate", "target.range <= 5"} },
  { "122", { "!target.state.immune.spell", "!target.state.disorient", "!target.state.incapacitate","target.range <= 9", "!player.lastcast(Dragon's Breath)", "!player.lastcast(118)", "player.spell(118).charges > 1" } }, -- Frost Nova
  { "118", { "focus.debuff(118)", "focus.debuff(118).duration <= 3", "!focus.immune.polly", "!player.lastcast(118)" }, "focus" },
  
  --{ "Blink", { "!talent(2, 1)" }, "target.range <= 3" }, -- Blink

  -- Cooldowns
  { "190319", "modifier.cooldowns" }, -- Combustion
  { "55342", { "talent(3, 1)", "modifier.cooldowns" } }, -- Mirror Image
  { "45438", "player.health <= 18" }, -- Ice Block

  -- Time Warp Logic
  --{ "Time Warp", { "player.buff(Arcane Power)", "toggle.warp" } }, -- Time Warp



  -- AoE
  { "Rune of Power", { "talent(3, 2)", "modifier.rshift" }, "ground" }, -- Rune of Power
  { "113724", { "talent(5, 2)", "modifier.ralt" }, "ground" }, -- Ring of Frost
  { "31661", "modifier.lshift" }, -- Dragon's Breath
  { "118", "modifier.lalt", "focus"},
  -- { "118", "modifier.ralt", "target"},

  
  
  -- Rotation
  --{"pause", {"!@cont.notImmune('target')"} },
  { "Ice Floes", { "talent(5, 1)", "@cont.ArenaTargets()", "player.moving" } },-- Ice Floes  
  { "Pyroblast", { "player.buff(Hot Streak!)", "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate" } },-- Pyroblast
  { "Scorch", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "player.moving"} },-- Scorch
  { "Flamestrike", { "player.buff(Hot Streak!)", "!player.buff(Combustion)", "modifier.multitarget" }, "target.ground" },-- Flamestrike
  { "Phoenix's Flames", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.immune.spell", "!target,state.disorient", "!target.state.incapacitate" } },-- Phoenix's Flames
  { "Meteor", { "talent(7, 3)", "@cont.notImmune('target')", "modifier.lcontrol" }, "target.ground" },-- Meteor
  { "Cinderstorm", { "talent(7, 2)" } },-- Cinderstorm
  { "Living Bomb", { "talent(6, 1)" } },-- Living Bomb
  { "Blast Wave", { "talent(4, 1)" } },-- Blast Wave
  
  --{ "Flame On", { "talent(4, 2)", "player.spell(Fire Blast).charges = 0" } },-- Flame On
  
  { "Fire Blast", { "player.buff(Heating Up)", "!target.state.immune.spell", "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate" } },-- Fire Blast 
  { "Fireball", { "!target.state.immune.spell", "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate" } },-- Fireball

  {"pause", {   --Counter
  "!@cont.LastCast(2139,1)",
  "@cont.disrupting()",
  },},
  
     {"pause", {    --Countercont.db()
  "@cont.Counter()",
  },}

},{
{ "118", {"modifier.lalt", "!player.lastcast(118)"}, "focus" },
{ "118", { "focus.debuff(118)", "focus.debuff(118).duration <= 3", "!focus.immune.polly", "!player.lastcast(118)" }, "focus" },
--{ "130", { "player.falling", "!player.buff(130)"} },
{ "235313", "!player.buff(235313)" }
})