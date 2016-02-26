-- Login Event --
local Login_Frame = CreateFrame("Frame")
Login_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
Login_Frame:SetScript("OnEvent", 
  function(self, event, ...)
    print("ClassCompanion has loaded successfully!")

    if hasLoggedIn == nil then
      -- Druid class --
      if playerClass == "Druid" then
        -- Calls wait function for login message --
        -- Change integer to increase or decrease delay (in seconds) -- 
        wait(5, fillerWaitFunction , druidFirstLoginMessage1, whisperSound)
        wait(10, fillerWaitFunction , druidFirstLoginMessage2, whisperSound)
        if playerLevel < 3 then
          wait(15, fillerWaitFunction, druidWrathMessage1, whisperSound)
          wait(20, fillerWaitFunction, druidWrathMessage2, whisperSound)
        end
      end
      hasLoggedIn = true
    else
      wait(5, fillerWaitFunction, druidRegLoginMessage1, whisperSound)
      wait(10, fillerWaitFunction, druidRegLoginMessage2, whisperSound)
    end
end)

-- OnKill Event --
local Kill_frame = CreateFrame("Frame");
Kill_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
Kill_frame:SetScript("OnEvent", 
  function(self, event, ...)
    -- DRUID CLASS --
    if(event=="COMBAT_LOG_EVENT_UNFILTERED" and playerClass == "Druid") then
      local time, type, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags=...
      -- If player kills something --
      if(type=="PARTY_KILL" and sourceFlags == playerName)then
        -- If the kills hit the cap --
        if ClassCompanionKillCounter >= ClassCompanionKillMessageCap then
            -- Sets the kill limit on the message event --
            ClassCompanionKillMessageCap = math.random(10, 15)
            -- Sets counter back to 1 after cap is hit --
            ClassCompanionKillCounter = 1
            ClassCompanionKillMessageChoice = math.random(1,7)
            -- Message redundancy check --
            while (ClassCompanionKillMessageRedundancy == ClassCompanionKillMessageChoice) do
              ClassCompanionKillMessageChoice = math.random(1,7)
            end
            -- Message 1 --
            if(ClassCompanionKillMessageChoice == 1) then
              wait(0, fillerWaitFunction, druidKillMessage1, whisperSound)
            end
             -- Message 2 --
            if(ClassCompanionKillMessageChoice == 2) then
              wait(0, fillerWaitFunction, druidKillMessage2, whisperSound)
            end
             -- Message 3 --
            if(ClassCompanionKillMessageChoice == 3) then
              wait(0, fillerWaitFunction, druidKillMessage3, whisperSound)
            end
             -- Message 4 --
            if(ClassCompanionKillMessageChoice == 4) then
              wait(0, fillerWaitFunction, druidKillMessage4, whisperSound)
            end
             -- Message 5 --
            if(ClassCompanionKillMessageChoice == 5) then
              wait(0, fillerWaitFunction, druidKillMessage5, whisperSound)
            end
             -- Message 6 --
            if(ClassCompanionKillMessageChoice == 6) then
              wait(0, fillerWaitFunction, druidKillMessage6, whisperSound)
            end
             -- Message 7 --
            if(ClassCompanionKillMessageChoice == 7) then
              wait(0, fillerWaitFunction, druidKillMessage7, whisperSound)
            end
        end
        -- Increments the kills --
        ClassCompanionKillCounter = ClassCompanionKillCounter + 1
        -- Sets redundancy --
        ClassCompanionKillMessageRedundancy = ClassCompanionKillMessageChoice
      end
    end
end)

-- Level up --
local Level_Up_Frame = CreateFrame("Frame")
Level_Up_Frame:RegisterEvent("PLAYER_LEVEL_UP")
Level_Up_Frame:SetScript("OnEvent", 
  function(self, event, ...)
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...
    playerLevel = UnitLevel("player")
    -- DRUID CLASS --
    if (playerClass == "Druid") then
      print(levelUpMessage)
    end
    wait(0, fillerWaitFunction, nil, levelUpSound)
end)

-- Learned spell --
local Learned_Spell_Frame = CreateFrame("Frame")
Learned_Spell_Frame:RegisterEvent("LEARNED_SPELL_IN_TAB")
Learned_Spell_Frame:SetScript("OnEvent",
  function(self, event, ...)
    local spellID, tabID = ...
    -- DRUID CLASS --
    if (playerClass == "Druid") then
      -- Moonfire --
      if (spellID == 8921) then
        wait(3, fillerWaitFunction, druidMoonfireMessage1, whisperSound)
        wait(8, fillerWaitFunction, druidMoonfireMessage2, whisperSound)
      end
      -- Rejuvenation --
      if (spellID == 774) then
        wait(3, fillerWaitFunction, druidRejuvMessage1, whisperSound)
        wait(8, fillerWaitFunction, druidRejuvMessage2, whisperSound)
      end
      -- Cat Form --
      if (spellID == 768) then
        wait(3, fillerWaitFunction, druidCatFormMessage1, whisperSound)
        wait(8, fillerWaitFunction, druidCatFormMessage2, whisperSound)
        wait(11, fillerWaitFunction, druidCatFormMessage3, whisperSound)
        wait(14, fillerWaitFunction, druidCatFormMessage4, whisperSound)
      end
      -- Feline Grace --
      if (spellID == 125972) then
        wait(17, fillerWaitFunction, druidFelineGraceMessage1, whisperSound)
        wait(20, fillerWaitFunction, druidFelineGraceMessage2, whisperSound)
        wait(23, fillerWaitFunction, druidFelineGraceMessage2, whisperSound)
      end
      -- Ferocious Bite --
      if (spellID == 22568) then
        wait(26, fillerWaitFunction, druidFerociousBiteMessage1, whisperSound)
      end
      -- Prowl --
      if (spellID == 5215) then
        wait(29, fillerWaitFunction, druidProwlMessage1, whisperSound)
      end
      -- Shred --
      if (spellID == 5221) then
        wait(32, fillerWaitFunction, druidShredMessage1, whisperSound)
        wait(35, fillerWaitFunction, druidShredMessage2, whisperSound)
      end
    end
end)

-- Death --
local Death_Frame = CreateFrame("Frame")
Death_Frame:RegisterEvent("PLAYER_DEAD")
Death_Frame:SetScript("OnEvent", 
  function(self, event, ...)
    wait(0, fillerWaitFunction, druidDeathMessage1, whisperSound, deathSound)
  end)

-- Filler function for wait --
function fillerWaitFunction(str, ...)
  if str ~= nil then
    print (str)
  end
  PlaySoundFile(..., "Master")
end

-- Wait function -- 
local waitTable = {};
local waitFrame = nil;
function wait(delay, func, ...)
  if(type(delay)~="number" or type(func)~="function") then
    return false;
  end
  if(waitFrame == nil) then
    waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
    waitFrame:SetScript("onUpdate",function (self,elapse)
      local count = #waitTable;
      local i = 1;
      while(i<=count) do
        local waitRecord = tremove(waitTable,i);
        local d = tremove(waitRecord,1);
        local f = tremove(waitRecord,1);
        local p = tremove(waitRecord,1);
        if(d>elapse) then
          tinsert(waitTable,i,{d-elapse,f,p});
          i = i + 1;
        else
          count = count - 1;
          f(unpack(p));
        end
      end
    end);
  end
  tinsert(waitTable,{delay,func,{...}});
  return true;
end