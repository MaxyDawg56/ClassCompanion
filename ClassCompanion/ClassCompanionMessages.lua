local Login_Frame = CreateFrame("Frame")
Login_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
Login_Frame:SetScript("OnEvent", 
function(self, event, ...)
    playerLevel = UnitLevel("player")
    -- Counter to keep track of kills --
    ClassCompanionKillCounter = 1
    -- Cap for the kills, at the cap a message will play --
    ClassCompanionKillMessageCap = 0
    -- Used to index through the list for messages --
    KillMessageRedundancy = 0

    --Sound Files--
    whisperSound = "Interface\\AddOns\\ClassCompanion\\whisper.ogg"
    deathSound1 = "Interface\\AddOns\\ClassCompanion\\DeathSound1.ogg"
    deathSound2 = "Interface\\AddOns\\ClassCompanion\\DeathSound2.ogg"
    levelUpSound = "Interface\\AddOns\\ClassCompanion\\LevelUpSound.ogg"

    --Player Info--
    playerName = UnitName("player")
    playerRealm = GetRealmName()
    playerClass = UnitClass("player")

    --Druid--
    if playerClass == "Druid" then
        --Login--
        druidFirstLoginMessage1 = ("|cffFF7D0AOstmarian whispers: Salutations " .. playerName .. " of the realm " .. playerRealm .. ".|r" ):format()
        druidFirstLoginMessage2 = ("|cffFF7D0AOstmarian whispers: I Ostmarian, fabled archdruid of the ancient realm, am here to guide you.|r" ):format()
        druidRegLoginMessage1 = ("|cffFF7D0AOstmarian whispers: Back again I see. I have been awaiting your arrival since last we met.|r"):format()
        druidRegLoginMessage2 = ("|cffFF7D0AOstmarian whispers: Come, there is much to be done my friend.|r"):format()
        -- Death --
        druidDeathMessage1 = ("|cffFF7D0AOstmarian whispers: Ah... well fret not my dear friend, the fabrics of this world will build you anew.|r"):format()
        --Lvl less than 3--
        druidWrathMessage1 = ("|cffFF7D0AOstmarian whispers: Currently your only spell is Wrath, its baseline cast time is 2 seconds and does moderate damage.|r"):format()
        druidWrathMessage2 = ("|cffFF7D0AOstmarian whispers: You'll be continuously casting this until you gain other abilities.|r"):format()
        --Kills--
        -- The '|cffXXXXXX', '|r', and ':format()' are for message coloring (The X's represent a hex value)
        -- To edit the message, change the text between the formating
        druidKillMessage1 = ("|cffFF7D0AOstmarian whispers: What do you think you're doing?! This is no way a druid behaves!|r"):format()
        druidKillMessage2 = ("|cffFF7D0AOstmarian whispers: For the love of Elune, stop this bloodshed!|r"):format()
        druidKillMessage3 = ("|cffFF7D0AOstmarian whispers: Well let's hope that their passing will contribute to a greater tomorrow, yes?|r"):format()
        druidKillMessage4 = ("|cffFF7D0AOstmarian whispers: Did they start the assault or did you? I don't pay much attention to fighting.|r"):format()
        druidKillMessage5 = ("|cffFF7D0AOstmarian whispers: Oh again with the killing, what would D.E.H.T.A. think of this?|r"):format()
        druidKillMessage6 = ("|cffFF7D0AOstmarian whispers: Is this really what you want to do with your free time?|r"):format()
        druidKillMessage7 = ("|cffFF7D0AOstmarian whispers: I question your sanity..|r"):format()
        -- Stores messages in an 'array' --
        druidKillMessageList = {druidKillMessage1, druidKillMessage2, druidKillMessage3, druidKillMessage4, druidKillMessage5, druidKillMessage6, druidKillMessage7}
        -- Stores length of array --
        druidKillMesssageCount = table.getn(druidKillMessageList)
        -- Shuffles array on login --
        for i = druidKillMesssageCount, 2, -1 do -- backwards
            local r = math.random(i) -- select a random number between 1 and i
            druidKillMessageList[i], druidKillMessageList[r] = druidKillMessageList[r], druidKillMessageList[i] -- swap the randomly selected item to position i
        end
        --LearnSpells--
        -- Moonfire
        druidMoonfireMessage1 = ("|cffFF7D0AOstmarian whispers: You have learned Moonfire! This is a fairly powerful spell at a low level and is instant cast!|r"):format()
        druidMoonfireMessage2 = ("|cffFF7D0AOstmarian whispers: This is a DoT (Damage over time) spell, meaning its damage is spread out over time. Many DoTs on a target will cause them to be overwhelmed.|r"):format()
        -- Rejuvenation
        druidRejuvMessage1 = ("|cffFF7D0AOstmarian whispers: You have learned Rejuvenation, your first healing spell!|r"):format()
        druidRejuvMessage2 = ("|cffFF7D0AOstmarian whispers: This is a instant cast HoT (Healing over time) spell, it functions the same as a DoT but may only be cast on friendly unit to heal them. |r"):format()
        -- Cat form
        druidCatFormMessage1 = ("|cffFF7D0AOstmarian whispers: You have learned Cat Form, your first shapeshift form!|r"):format()
        druidCatFormMessage2 = ("|cffFF7D0AOstmarian whispers: It allows you to shapeshift into, well, a cat! Doing so allows different abilities and restricts others.|r"):format()
        druidCatFormMessage3 = ("|cffFF7D0AOstmarian whispers: In this form you use some abilities to gain combo points and others to spend them.|r"):format()
        druidCatFormMessage4 = ("|cffFF7D0AOstmarian whispers: (P.S. Don't use the gnomes as a scratching post, they don't respond well to it.)|r"):format()
        -- Ferocious Bite
        druidFerociousBiteMessage1 = ("|cffFF7D0AOstmarian whispers: The next move gained from Cat Form is Ferocious Bite. It does higher damage based on higher combo points, up to 5.|r"):format()
        -- Prowl
        druidProwlMessage1 = ("|cffFF7D0AOstmarian whispers: Cat Form also gives you Prowl, an ability that grants you stealth until you're hit or attack. Only usable out of combat.|r"):format()
        -- Shred 
        druidShredMessage1 = ("|cffFF7D0AOstmarian whispers: The last move gained from Cat Form for now is Shred. This moves grants you a combo point.|r"):format()
        druidShredMessage2 = ("|cffFF7D0AOstmarian whispers: Using Shred in stealth grants more damage and doubles the crit chance, also does more damage against targets with bleed on them. |r"):format()
        -- Bear Form
        druidBearFormMessage1 = ("|cffFF7D0AOstmarian whispers: You just gained the ability to use Bear Form, a defensive form used to take reduced damage and hold enemy threat.|r"):format()
        drudiBearFormMessage2 = ("|cffFF7D0AOstmarian whispers: The mightly Ursoc blesssed you with this knowledge, use it wisely.|r"):format()
        -- Growl
        druidGrowlMessage1 = ("|cffFF7D0AOstmarian whispers: With bear form comes the usage of Growl and Mangle.|r"):format()
        druidGrowlMessage2 = ("|cffFF7D0AOstmarian whispers: Using growl on most enemies will make them focus their attacks on you, prevent your allies from taking damage.|r"):format()
        -- Mangle
        druidMangleMessage1 = ("|cffFF7D0AOstmarian whispers: You may also Mangle the target for 400% of your weapon damage in bear form.|r"):format()
        -- Entangling Roots
        druidEntRootsMessage1 = ("|cffFF7D0AOstmarian whispers: You've just gained Entangling Roots, a form of crowd control.|r"):format()
        druidEntRootsMessage2 = ("|cffFF7D0AOstmarian whispers: Using this spell on an enemy will root them for 30 seconds, but damage may break the effect.|r"):format()
        -- Specialization
        druidSpecializationMessage1 = ("|cffFF7D0AOstmarian whispers: Now that you are level 10, you may pick a Specialization.|r"):format()
        druidSpecializationMessage2 = ("|cffFF7D0AOstmarian whispers: You may pick between Feral, Guardian, Balance, or Restoration.|r"):format()
        druidSpecializationMessage3 = ("|cffFF7D0AOstmarian whispers: These do melee damage, damage mitigation, ranged damage, and healing respectively.|r"):format()
        druidSpecializationMessage4 = ("|cffFF7D0AOstmarian whispers: Look these over carefully, it is ultimately your path to choose.|r"):format()
        druidSpecializationMessage5 = ("|cffFF7D0AOstmarian whispers: And now young druid, it is no longer my time to teach you about abilities.|r"):format()
        druidSpecializationMessage6 = ("|cffFF7D0AOstmarian whispers: I will still be at your side, but it is now your responsibility to teach yourself!|r"):format()
    end
end)