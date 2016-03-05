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
            --Increments the index value--
            KillMessageRedundancy = KillMessageRedundancy + 1
            -- Sets counter back to 1 after cap is hit --
            ClassCompanionKillCounter = 1
            -- Message redundancy check --
            wait(0, fillerWaitFunction, druidKillMessageList[KillMessageRedundancy], whisperSound)
            if (KillMessageRedundancy >= druidKillMesssageCount) then
              -- Resets redundancy --
              KillMessageRedundancy = 0
              -- Shuffles message list --
              for i = druidKillMesssageCount, 2, -1 do -- backwards
                  local r = math.random(i) -- select a random number between 1 and i
                  druidKillMessageList[i], druidKillMessageList[r] = druidKillMessageList[r], druidKillMessageList[i] -- swap the randomly selected item to position i
              end
            end
        end
        -- Increments the kills --
        ClassCompanionKillCounter = ClassCompanionKillCounter + 1
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
    levelUpMessage = ("|cffFF7D0AOstmarian whispers: Congratulations " .. playerName .. ", you are " .. (100 - playerLevel - 1) .. " levels from your maximum potential!"):format()
    -- DRUID CLASS --
    if (playerClass == "Druid") then
      wait(0, fillerWaitFunction, levelUpMessage, whisperSound)
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
        wait(6, fillerWaitFunction, druidCatFormMessage2, whisperSound)
        wait(11, fillerWaitFunction, druidCatFormMessage3, whisperSound)
        wait(16, fillerWaitFunction, druidCatFormMessage4, whisperSound)
      end
      -- Ferocious Bite --
      if (spellID == 22568) then
        wait(21, fillerWaitFunction, druidFerociousBiteMessage1, whisperSound)
      end
      -- Prowl --
      if (spellID == 5215) then
        wait(26, fillerWaitFunction, druidProwlMessage1, whisperSound)
      end
      -- Shred --
      if (spellID == 5221) then
        wait(31, fillerWaitFunction, druidShredMessage1, whisperSound)
        wait(36, fillerWaitFunction, druidShredMessage2, whisperSound)
      end
      -- Bear form --
      if (spellID == 5487) then
        wait(3, fillerWaitFunction, druidBearFormMessage1, whisperSound)
        wait(6, fillerWaitFunction, druidBearFormMessage2, whisperSound)
      end
      -- Growl --
      if (spellID == 6795) then
        wait(9, fillerWaitFunction, druidGrowlMessage1, whisperSound)
        wait(11, fillerWaitFunction, druidGrowlMessage2, whisperSound)
      end
      -- Mangle --
      if (spellID == 33917) then
        wait(14, fillerWaitFunction, druidMangleMessage1, whisperSound)
      end
      -- Entangling Roots --
      if (spellID == 339) then
        wait(3, fillerWaitFunction, druidEntRootsMessage1, whisperSound)
        wait(6, fillerWaitFunction, druidEntRootsMessage1, whisperSound)
      end
      -- Specializations --
      if (playerLevel == 10) then
        wait(9, fillerWaitFunction, druidSpecializationMessage1, whisperSound)
        wait(12, fillerWaitFunction, druidSpecializationMessage2, whisperSound)
        wait(15, fillerWaitFunction, druidSpecializationMessage3, whisperSound)
        wait(18, fillerWaitFunction, druidSpecializationMessage4, whisperSound)
        wait(21, fillerWaitFunction, druidSpecializationMessage5, whisperSound)
        wait(24, fillerWaitFunction, druidSpecializationMessage6, whisperSound)
      end
    end
end)

-- Death --
local Death_Frame = CreateFrame("Frame")
Death_Frame:RegisterEvent("PLAYER_DEAD")
Death_Frame:SetScript("OnEvent", 
  function(self, event, ...)
    wait(0, fillerWaitFunction, druidDeathMessage1, whisperSound)
    wait(0.5, fillerWaitFunction, nil, deathSound1)
    wait(0.5, fillerWaitFunction, nil, deathSound2)
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