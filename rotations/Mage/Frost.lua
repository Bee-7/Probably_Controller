ProbablyEngine.rotation.register_custom(64, "Contmage - A Mage pvp CR",
  --In combat

 {
 {"pause", { 
 "@cont.queuespell()",}},
 {"pause", "modifier.lshift"},

   -- Survivability
  { "122", { "!target.state.immune.spell", "!target.state.disorient","@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.incapacitate","target.range <= 9", "!target.debuff(122)", "!target.state.snare", "target.enemy" } }, -- Frost Nova
  { "120", { "!target.state.immune.spell", "!target.state.disorient","@cont.notImmune('target')", "!target.state.incapacitate","target.range <= 9", "!target.debuff(122)", "!target.state.snare", "target.enemy" } },
  { "113724", { "talent(5, 2)", "modifier.lcontrol" }, "ground" }, -- Ring of Frost
  { "11426", "!player.buff(11426)" },
  { "118", { "modifier.lalt", "!player.lastcast(118)"}, "focus" },
  { "118", "modifier.ralt", "target" },
  { "118", { "focus.debuff(118)", "focus.debuff(118).duration <= 3", "!focus.immune.polly", "!player.lastcast(118)" }, "focus" },
  { "190356", { "modifier.lcontrol" }, "ground" },
  { "30449", { "target.buff(198111)", "@cont.ArenaTargets()" } },
  { "30449", { "target.buff(12472)", "@cont.ArenaTargets()" } },
  { "30449", { "target.buff(1044)", "@cont.ArenaTargets()" } },
  { "235219", "player.spell(Ice Block).cooldown" },

  --Cooldowns
  { "Icy Veins", "modifier.cooldowns" }, -- Icy Veins
  { "Mirror Image", { "talent(3, 1)", "modifier.cooldowns" } }, -- Mirror Image
  { "Ice Block", { "player.health <= 18" } }, -- Ice Block
  { "Summon Water Elemntal", { "!talent(1, 2)", "modifier.cooldowns" } }, -- Summon Water Elemntal
  { "33702", "modifier.cooldowns" },


  -- Rotation
  --{ "Ice Floes", { "talent(5, 1)", "player.moving" } },-- Ice Floes
  { "Glacial Spike", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "talent(7, 2)", "player.buff(Glacial Spike!)", "!lastcast(Glacial Spike)" } },-- Glacial Spike
  { "Ice Nova", { "talent(4, 1)", "player.lastcast(Glacial Spike)", "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate" } },
  { "Ice Lance", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "target.debuff(Freeze)"} },-- Ice Lance 
  { "Ice Lance", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "target.debuff(Frost Nova)", "target.range > 12"} },-- Ice Lance 
  { "Ice Lance", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "player.lastcast(Flurry)" } },-- Ice Lance  
  { "Ice Lance", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "target.debuff(Glacial Spike).duration > 0.5" } },-- Ice Lance
  { "Flurry", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "player.buff(Brain Freeze)" } },--  Flurry "target.debuff(228358).duration > 0.5"
  { "Ice Lance", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "player.moving"} },

  

  { "84714" , { "modifier.cooldowns" }, "target.ground"},-- Frozen Orb
  
  { "Ebonbolt", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "player.buff(Fingers of Frost).count < 2" } },-- Ebonbolt
  { "Ice Lance", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "player.buff(Fingers of Frost).count > 0" } },-- Ice Lance
  { "Comet Storm", { "@cont.notImmune('target')", "@cont.ArenaTargets()", "!target.state.disorient", "!target.state.incapacitate", "talent(7, 3)" } },-- Comet Storm
  { "Frostbolt" },-- Frostbolt
  



  {"pause", {   --Counter
  "!@cont.LastCast(2139,1)",
  "@cont.disrupting()",
  },},
  
     {"pause", { 
  "@cont.Counter()",
  },}

},{
{ "118", {"modifier.lalt", "!player.lastcast(118)"}, "focus" },
{ "118", { "focus.debuff(118)", "focus.debuff(118).duration <= 3", "!focus.immune.polly", "!player.lastcast(118)" }, "focus" },
{ "11426", "!player.buff(11426)" },
{ "190356", { "modifier.lcontrol" }, "ground" }
})