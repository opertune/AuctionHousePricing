local f = CreateFrame("Frame")
local Enchanting, Alchemy, Menu

local auctions = {}
local initialQuery
local replicateTimer = nil

-- Table of all Reagents
local reagents = {
    [1] = {
        ["Name"] = "Eternal Crystal",
        ["ID"] = 172232,
        ["minPrice"] = 0
    },
    [2] = {
        ["Name"] = "Sacred Shard",
        ["ID"] = 172231,
        ["minPrice"] = 0
    },
    [3] = {
        ["Name"] = "Soul Dust",
        ["ID"] = 172230,
        ["minPrice"] = 0
    },
    [4] = {
        ["Name"] = "Nightshade",
        ["ID"] = 171315,
        ["minPrice"] = 0
    },
    [5] = {
        ["Name"] = "Rising Glory",
        ["ID"] = 168586,
        ["minPrice"] = 0
    },
    [6] = {
        ["Name"] = "Marrowroot",
        ["ID"] = 168589,
        ["minPrice"] = 0
    },
    [7] = {
        ["Name"] = "Widowbloom",
        ["ID"] = 168583,
        ["minPrice"] = 0
    },
    [8] = {
        ["Name"] = "Vigil's Torch",
        ["ID"] = 170554,
        ["minPrice"] = 0
    },
    [9] = {
        ["Name"] = "Death Blossom",
        ["ID"] = 169701,
        ["minPrice"] = 0
    }
}

-- Table of all enchanting items
local enchantement = {
    [1] = {
        ["Name"] = "Fortified Avoidance",
        ["ID"] = 172411,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 0,
        ["sNB"] = 2,
        ["dNB"] = 4
    },
    [2] = {
        ["Name"] = "Fortified Leech",
        ["ID"] = 172412,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 0,
        ["sNB"] = 2,
        ["dNB"] = 4
    },
    [3] = {
        ["Name"] = "Fortified Speed",
        ["ID"] = 172410,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 0,
        ["sNB"] = 2,
        ["dNB"] = 4
    },
    [4] = {
        ["Name"] = "Soul Vitality",
        ["ID"] = 177660,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 0,
        ["sNB"] = 0,
        ["dNB"] = 4
    },
    [5] = {
        ["Name"] = "Eternal Bounds",
        ["ID"] = 177715,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 1,
        ["sNB"] = 2,
        ["dNB"] = 0
    },
    [6] = {
        ["Name"] = "Eternal Skirmish",
        ["ID"] = 177659,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 1,
        ["sNB"] = 2,
        ["dNB"] = 0
    },
    [7] = {
        ["Name"] = "Eternal Bulwark",
        ["ID"] = 172418,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 1,
        ["sNB"] = 2,
        ["dNB"] = 0
    },
    [8] = {
        ["Name"] = "Eternal insight",
        ["ID"] = 183738,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 1,
        ["sNB"] = 2,
        ["dNB"] = 0
    },
    [9] = {
        ["Name"] = "Eternal stats",
        ["ID"] = 177962,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 1,
        ["sNB"] = 2,
        ["dNB"] = 0
    },
    [10] = {
        ["Name"] = "Eternal intellect",
        ["ID"] = 172415,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 1,
        ["sNB"] = 2,
        ["dNB"] = 0
    },
    [11] = {
        ["Name"] = "Eternal Strength",
        ["ID"] = 172408,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 1,
        ["sNB"] = 2,
        ["dNB"] = 0
    },
    [12] = {
        ["Name"] = "Eternal Agility",
        ["ID"] = 172419,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 1,
        ["sNB"] = 2,
        ["dNB"] = 0
    },
    [13] = {
        ["Name"] = "Tenet of Critical Strike",
        ["ID"] = 172361,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 0,
        ["sNB"] = 3,
        ["dNB"] = 0
    },
    [14] = {
        ["Name"] = "Tenet of Haste",
        ["ID"] = 172362,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 0,
        ["sNB"] = 3,
        ["dNB"] = 0
    },
    [15] = {
        ["Name"] = "Tenet of Mastery",
        ["ID"] = 172363,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 0,
        ["sNB"] = 3,
        ["dNB"] = 0
    },
    [16] = {
        ["Name"] = "Tenet of Versatility",
        ["ID"] = 172364,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 0,
        ["sNB"] = 3,
        ["dNB"] = 0
    },
    [17] = {
        ["Name"] = "Ascended Vigor",
        ["ID"] = 172365,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 2,
        ["sNB"] = 3,
        ["dNB"] = 0
    },
    [18] = {
        ["Name"] = "Eternal Grace",
        ["ID"] = 172367,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 2,
        ["sNB"] = 3,
        ["dNB"] = 0
    },
    [19] = {
        ["Name"] = "Lightless Force",
        ["ID"] = 172370,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 2,
        ["sNB"] = 3,
        ["dNB"] = 0
    },
    [20] = {
        ["Name"] = "Sinful Revelation",
        ["ID"] = 172368,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["cNB"] = 2,
        ["sNB"] = 3,
        ["dNB"] = 0
    }
}

-- Table of all alchemy items
local alchemy = {
    [1] = {
        ["Name"] = "Spiritual Healing Potion",
        ["ID"] = 171267,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 2
    },
    [2] = {
        ["Name"] = "Spiritual Mana Potion",
        ["ID"] = 171268,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 2
    },
    [3] = {
        ["Name"] = "Potion of Deathly Fixation",
        ["ID"] = 171351,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 3,
        ["vNB"] = 3,
        ["dNB"] = 0
    },
    [4] = {
        ["Name"] = "Potion of Empowered Exorcisms",
        ["ID"] = 171352,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 3,
        ["wNB"] = 3,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [5] = {
        ["Name"] = "Potion of Spectral Agility",
        ["ID"] = 171270,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 5,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [6] = {
        ["Name"] = "Potion of Spectral Intellect",
        ["ID"] = 171273,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 5,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [7] = {
        ["Name"] = "Potion of Spectral Strength",
        ["ID"] = 171275,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 5,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [8] = {
        ["Name"] = "Potion of Divine Awakening",
        ["ID"] = 171350,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 3,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 3,
        ["dNB"] = 0
    },
    [9] = {
        ["Name"] = "Potion of Phantom Fire",
        ["ID"] = 171349,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 3,
        ["mNB"] = 3,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [10] = {
        ["Name"] = "Potion of Sacrificial Anima",
        ["ID"] = 176811,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 6,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [11] = {
        ["Name"] = "Potion of Spiritual Clarity",
        ["ID"] = 171272,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 5,
        ["dNB"] = 0
    },
    [12] = {
        ["Name"] = "Spectral Flask of Power",
        ["ID"] = 171276,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 3,
        ["rNB"] = 4,
        ["mNB"] = 4,
        ["wNB"] = 4,
        ["vNB"] = 4,
        ["dNB"] = 0
    },
    [13] = {
        ["Name"] = "Embalmer's Oil",
        ["ID"] = 171286,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 2
    },
    [14] = {
        ["Name"] = "Shadowcore Oil",
        ["ID"] = 171285,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 2
    },
    [15] = {
        ["Name"] = "Potion of the Psychopomp's Speed",
        ["ID"] = 184090,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 3,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 3,
        ["dNB"] = 0
    },
    [16] = {
        ["Name"] = "Potion of Soul Purity",
        ["ID"] = 171263,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 3,
        ["dNB"] = 2
    },
    [17] = {
        ["Name"] = "Potion of the Hidden Spirit",
        ["ID"] = 171266,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 3,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 2
    },
    [18] = {
        ["Name"] = "Ground Widowbloom",
        ["ID"] = 171289,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 2,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [19] = {
        ["Name"] = "Ground Vigil's torch",
        ["ID"] = 171288,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 2,
        ["dNB"] = 0
    },
    [20] = {
        ["Name"] = "Ground Nightshade",
        ["ID"] = 171292,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 2,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [21] = {
        ["Name"] = "Ground Marrowroot",
        ["ID"] = 171290,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 2,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [22] = {
        ["Name"] = "Ground Rising Glory",
        ["ID"] = 171291,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 2,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 0
    },
    [23] = {
        ["Name"] = "Ground Death Blossom",
        ["ID"] = 171287,
        ["minPrice"] = 0,
        ["craftCost"] = 0,
        ["profit"] = 0,
        ["signe"] = "",
        ["nNB"] = 0,
        ["rNB"] = 0,
        ["mNB"] = 0,
        ["wNB"] = 0,
        ["vNB"] = 0,
        ["dNB"] = 2
    }
}

function f:EnchantingFrame()
    Enchanting = CreateFrame("Frame", "EnchantingFrame", UIParent, "UIPanelDialogTemplate")
    Enchanting:SetSize(810, 550)
    Enchanting:SetPoint("CENTER", UIParent, "CENTER", 295, 155)

    Enchanting.title = Enchanting:CreateFontString(nil, "OVERLAY")
    Enchanting.title:ClearAllPoints();
    Enchanting.title:SetFontObject("GameFontHighlight")
    Enchanting.title:SetPoint("TOPLEFT", EnchantingFrameTitleBG, "TOPLEFT", 10, -3)
    Enchanting.title:SetText("Enchantements")

    -- ScrollFrame
    Enchanting.ScrollFrame = CreateFrame("ScrollFrame", nil, Enchanting, "UIPanelScrollFrameTemplate")
    Enchanting.ScrollFrame:SetPoint("TOPLEFT", EnchantingFrameDialogBG, "TOPLEFT", 4, -8)
    Enchanting.ScrollFrame:SetPoint("BOTTOMRIGHT", EnchantingFrameDialogBG, "BOTTOMRIGHT", -3, 4)
    Enchanting.ScrollFrame:SetClipsChildren(true)
    Enchanting.ScrollFrame:SetClipsChildren(true)
        Enchanting.ScrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local newValue = self:GetVerticalScroll() - (delta * 20)

        if (newValue < 0) then
            newValue = 0
        elseif (newValue > self:GetVerticalScrollRange()) then
            newValue = self:GetVerticalScrollRange()
        end

        self:SetVerticalScroll(newValue)
    end)
            
    Enchanting.ScrollFrame.ScrollBar:ClearAllPoints()
    Enchanting.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", Enchanting.ScrollFrame, "TOPRIGHT", -12, -18)
    Enchanting.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", Enchanting.ScrollFrame, "BOTTOMRIGHT", -7, 18)

    local child = CreateFrame("Frame", nil, Enchanting.ScrollFrame)
    child:SetSize(632, 800) -- scroll frame size
    Enchanting.ScrollFrame:SetScrollChild(child)

    for i = 1, 3 do
        Enchanting.i = f:CreateTxt("TOPLEFT", child, "TOPLEFT",50+(i*220)-200, 0, Enchanting)
        if reagents[i]["minPrice"] ~= 0 then
            Enchanting.i:SetText(reagents[i]["Name"] .. ": " .. GetMoneyString(reagents[i]["minPrice"]))
        else
            Enchanting.i:SetText(reagents[i]["Name"] .. " is not in auction house")
        end
    end

    for i = 1, #enchantement do
        Enchanting.i = f:CreateTxt("CENTER", child, "CENTER", 40, 390+((-i)*30), Enchanting)
        if enchantement[i]["minPrice"] ~= 0 then
            Enchanting.i:SetText(enchantement[i]["Name"] .. ": " .. GetMoneyString(enchantement[i]["minPrice"]) .. "   Craft Cost: " .. GetMoneyString(enchantement[i]["craftCost"]) .. "   Profit: " .. enchantement[i]["signe"] .. GetMoneyString(enchantement[i]["profit"]) .. "|r")
        else
            Enchanting.i:SetText(enchantement[i]["Name"] .. " is not in auction house")
        end
    end

    return Enchanting
end

function f:AlchemyFrame()
    Alchemy = CreateFrame("Frame", "AlchemyFrame", UIParent, "UIPanelDialogTemplate")
    Alchemy:SetSize(810, 550)
    Alchemy:SetPoint("CENTER", UIParent, "CENTER", 295, 155)

    Alchemy.title = Alchemy:CreateFontString(nil, "OVERLAY")
    Alchemy.title:ClearAllPoints();
    Alchemy.title:SetFontObject("GameFontHighlight")
    Alchemy.title:SetPoint("TOPLEFT", AlchemyFrameTitleBG, "TOPLEFT", 10, -3)
    Alchemy.title:SetText("Alchemy")

    -- ScrollFrame
    Alchemy.ScrollFrame = CreateFrame("ScrollFrame", nil, Alchemy, "UIPanelScrollFrameTemplate")
    Alchemy.ScrollFrame:SetPoint("TOPLEFT", AlchemyFrameDialogBG, "TOPLEFT", 4, -8)
    Alchemy.ScrollFrame:SetPoint("BOTTOMRIGHT", AlchemyFrameDialogBG, "BOTTOMRIGHT", -3, 4)
    Alchemy.ScrollFrame:SetClipsChildren(true)
    Alchemy.ScrollFrame:SetClipsChildren(true)
        Alchemy.ScrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local newValue = self:GetVerticalScroll() - (delta * 20)

        if (newValue < 0) then
            newValue = 0
        elseif (newValue > self:GetVerticalScrollRange()) then
            newValue = self:GetVerticalScrollRange()
        end

        self:SetVerticalScroll(newValue)
    end)
            
    Alchemy.ScrollFrame.ScrollBar:ClearAllPoints()
    Alchemy.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", Alchemy.ScrollFrame, "TOPRIGHT", -12, -18)
    Alchemy.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", Alchemy.ScrollFrame, "BOTTOMRIGHT", -7, 18)

    local child = CreateFrame("Frame", nil, Alchemy.ScrollFrame)
    child:SetSize(632, 800) -- scroll frame size
    Alchemy.ScrollFrame:SetScrollChild(child)

    for i = 4, 9 do
        if i > 6 then
            Alchemy.i = f:CreateTxt("TOPLEFT", child, "TOPLEFT", 50+((i-6)*220)-200, -20, Alchemy)
        else
            Alchemy.i = f:CreateTxt("TOPLEFT", child, "TOPLEFT", 50+((i-3)*220)-200, 0, Alchemy)
        end
        if reagents[i]["minPrice"] ~= 0 then
            Alchemy.i:SetText(reagents[i]["Name"] .. ": " .. GetMoneyString(reagents[i]["minPrice"]))
        else
            Alchemy.i:SetText(reagents[i]["Name"] .. " is not in auction house")
        end
    end
    for i = 1, #alchemy do
        Alchemy.i = f:CreateTxt("CENTER", child, "CENTER", 40, 370+((-i)*30), Alchemy)
        if alchemy[i]["minPrice"] ~= 0 then
            Alchemy.i:SetText(alchemy[i]["Name"] .. ": " .. GetMoneyString(alchemy[i]["minPrice"]) .. "   Craft Cost: " .. GetMoneyString(alchemy[i]["craftCost"]) .. "   Profit: " .. alchemy[i]["signe"] .. GetMoneyString(alchemy[i]["profit"]) .. "|r")
        else
            Alchemy.i:SetText(alchemy[i]["Name"] .. " is not in auction house")
        end
    end
    return Alchemy
end

function f:MenuFrame()
    Menu = CreateFrame("Frame", "OpertuneAH", UIParent, "UIPanelDialogTemplate")
    Menu:SetSize(317, 90)
    Menu:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 522, -20)

    Menu.title = Menu:CreateFontString(nil, "OVERLAY")
    Menu.title:ClearAllPoints();
    Menu.title:SetFontObject("GameFontHighlight")
    Menu.title:SetPoint("TOPLEFT", OpertuneAHTitleBG, "TOPLEFT", 10, -3)
    Menu.title:SetText("Auction House Pricing")

    -- Button & Text
    Menu.btnScan = f:CreateButton("TOPLEFT", Menu, "TOPLEFT", 10, -25, "Scan", 70, 30)
    Menu.btnEnchantement = f:CreateButton("TOPLEFT", Menu, "TOPLEFT", 80, -25, "Enchantements", 140, 30)
    Menu.btnAlchemy = f:CreateButton("TOPLEFT", Menu, "TOPLEFT", 220, -25, "Alchemy", 90, 30)

    Menu.text = Menu:CreateFontString(nil, "OVERLAY")
    Menu.text:SetFontObject("GameFontNormalLarge")
    Menu.text:SetPoint("TOPLEFT", Menu, "TOPLEFT", 12, -60)

    -- Timer between two scan
    if replicateTimer == nil or GetTime() >= replicateTimer+900 then
        f:SetButtonEnabled(false) -- false
            Menu.btnScan:SetEnabled(true)
        Menu.text:SetText("Scan is ready")
    else
        Menu.btnScan:SetEnabled(false)
    end
    if replicateTimer ~= nil then
        Menu.text:SetText("Wait " .. SecondsToTime((replicateTimer+900) - GetTime()) .. " for another scan")
    end

    Menu:Hide()
    return Menu
end

function f:CreateButton(point, relativeFrame, relativePoint, xOffset, yOffset, text, xSize, ySize)
    local btn = CreateFrame("Button", nil, Menu, "GameMenuButtonTemplate")
    btn:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset)
    btn:SetSize(xSize, ySize)
    btn:SetText(text)
    btn:SetNormalFontObject("GameFontNormalLarge")
    btn:SetHighlightFontObject("GameFontHighlightLarge")
    return btn
end

function f:CreateTxt(point, relativeFrame, relativePoint, xOffset, yOffset, frame)
    local txt
    if frame == Enchanting or frame == Alchemy then
        txt = frame.ScrollFrame:CreateFontString(nil, "OVERLAY")
    else
        txt = frame:CreateFontString(nil, "OVERLAY")
    end
    txt:SetFontObject("GameFontNormalLarge")
    txt:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset)
    return txt
end

-- Set Button enabled
function f:SetButtonEnabled(bool)
    Menu.btnEnchantement:SetEnabled(bool)
    Menu.btnAlchemy:SetEnabled(bool)
end

-- Scan auction house and add item information in auctions{}
function f:ScanAuctions(callback)
    local continuables = {}
    wipe(auctions)
    for i = 0, C_AuctionHouse.GetNumReplicateItems()-1 do
        auctions[i] = {C_AuctionHouse.GetReplicateItemInfo(i)}
        local item = Item:CreateFromItemID(auctions[i][17]) -- itemID
        continuables[item] = true
 
        item:ContinueOnItemLoad(function()
            auctions[i] = {C_AuctionHouse.GetReplicateItemInfo(i)}
            continuables[item] = nil
            if not next(continuables) then
                Menu.text:SetText("Scan is complete")
                callback()
            end
        end)
    end
end

-- @return min price
function f:GetLowestPrice(itemID)
    local minPrice = math.huge
    for _, v in pairs(auctions) do
        if v[17] == itemID then
            local unitPrice = v[10] / v[3] -- totalPrice / count
            minPrice = min(minPrice, unitPrice)
        end
    end

    if minPrice < math.huge then
        return minPrice
    else
        return 0
    end
end

-- @return Craft cost price
function f:GetCraftCost(cNB, sNB, dNB, nNB, rNB, mNB, wNB, vNB, dNB2) 
    return ((reagents[1]["minPrice"] * cNB) + (reagents[2]["minPrice"] * sNB) + (reagents[3]["minPrice"] * dNB) + (reagents[4]["minPrice"] * nNB) + (reagents[5]["minPrice"] * rNB) + (reagents[6]["minPrice"] * mNB) + (reagents[7]["minPrice"] * wNB) + (reagents[8]["minPrice"] * vNB) + (reagents[9]["minPrice"] * dNB2))
end

--@return profit
function f:GetProfit(index, t)
    if t[index]["minPrice"] ~= nil and t[index]["craftCost"] > t[index]["minPrice"] then
        return "|cffff0000 -", math.abs((t[index]["minPrice"] - t[index]["craftCost"]))
    else
        return "|c0000ff00 +", (t[index]["minPrice"] - t[index]["craftCost"])
    end
end

-- Main function
function f:OnEvent(event)
    if event == "AUCTION_HOUSE_SHOW" then
        Menu = f:MenuFrame()
        Menu:Show()
        -- Button Click
        Menu.btnScan:SetScript("OnClick", function(self, button, down)
            Menu.text:SetText("Scan in progress")
            C_AuctionHouse.ReplicateItems() -- 15 min cd
            Menu.btnScan:SetEnabled(false)
            replicateTimer = GetTime()
            initialQuery = true
            C_Timer.After(15, function()
                if initialQuery then
                    f:ScanAuctions()
                    initialQuery = false
                    f:SetButtonEnabled(true)
                end
            end)
        end)
        Menu.btnEnchantement:SetScript("OnClick", function(self, button, down)
            for i = 1, #reagents do
                reagents[i]["minPrice"] = f:GetLowestPrice(reagents[i]["ID"])
            end
            for i = 1, #enchantement do
                enchantement[i]["minPrice"] = f:GetLowestPrice(enchantement[i]["ID"])
                enchantement[i]["craftCost"] = f:GetCraftCost(enchantement[i]["cNB"], enchantement[i]["sNB"], enchantement[i]["dNB"], 0, 0, 0, 0, 0, 0)
                enchantement[i]["signe"], enchantement[i]["profit"] = f:GetProfit(i, enchantement)
            end
            Enchanting = f:EnchantingFrame()
            Menu.btnEnchantement:SetEnabled(false)
            Menu.btnAlchemy:SetEnabled(true)
            if Alchemy then
                Alchemy:Hide()
            end
        end)
        Menu.btnAlchemy:SetScript("OnClick", function(self, button, down)
            for i = 1, #reagents do
                reagents[i]["minPrice"] = f:GetLowestPrice(reagents[i]["ID"])
            end
            for i = 1, #alchemy do
                alchemy[i]["minPrice"] = f:GetLowestPrice(alchemy[i]["ID"])
                alchemy[i]["craftCost"] = f:GetCraftCost(0, 0, 0, alchemy[i]["nNB"], alchemy[i]["rNB"], alchemy[i]["mNB"], alchemy[i]["wNB"], alchemy[i]["vNB"], alchemy[i]["dNB"])
                alchemy[i]["signe"], alchemy[i]["profit"] = f:GetProfit(i, alchemy)
            end
            Alchemy = f:AlchemyFrame()
            Menu.btnAlchemy:SetEnabled(false)
            Menu.btnEnchantement:SetEnabled(true)
            if Enchanting then
                Enchanting:Hide()
            end
        end)
    end

    if event == "AUCTION_HOUSE_CLOSED" then
        Menu:Hide()
        if Alchemy then
            Alchemy:Hide()
        end
        if Enchanting then
            Enchanting:Hide()
        end
    end 
end

-- Event
f:RegisterEvent("AUCTION_HOUSE_SHOW")
f:RegisterEvent("AUCTION_HOUSE_CLOSED")
f:RegisterEvent("REPLICATE_ITEM_LIST_UPDATE")
f:SetScript("OnEvent", f.OnEvent)