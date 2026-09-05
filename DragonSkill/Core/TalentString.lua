-- Dragon Skill - Talent-Loadout-String Decoder (v2.6.0)
--
-- Warum diese Datei existiert:
-- Ein Blizzard-Talent-Import-String ist kein beliebiger Text, sondern ein
-- Bitstrom in Base64. Die ersten 152 Bit sind ein fester Header:
--
--     8 Bit   serializationVersion   (aktuell 2)
--    16 Bit   specID                 (z.B. 102 = Gleichgewicht-Druide)
--   128 Bit   treeHash               (darf komplett 0 sein)
--
-- Blizzard lehnt einen Import kommentarlos bzw. mit einer generischen
-- Fehlermeldung ab, wenn die Version nicht passt ODER die specID nicht der
-- aktuell aktiven Spezialisierung des Spielers entspricht. Genau das war der
-- Bug im Talente-Tab: In den Daten lagen Strings, deren eingebettete specID
-- zu einer anderen Spezialisierung gehoerte (z.B. ein Wiederherstellungs-
-- String unter "Gleichgewicht"). Der Kopieren-Dialog ging auf, der Import in
-- WoW schlug aber immer fehl.
--
-- Mit diesem Decoder pruefen wir den String, BEVOR wir ihn an Blizzard
-- schicken, und koennen dem Spieler sagen, was konkret nicht passt.

local Decoder = {}

local LOADOUT_SERIALIZATION_VERSION = 2

local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

-- Lookup-Tabelle Zeichen -> 6-Bit-Wert (einmalig aufgebaut)
local CHAR_VALUE = {}
for i = 1, #B64 do
    CHAR_VALUE[string.sub(B64, i, i)] = i - 1
end

-- Liest den Header. Blizzard schreibt die Bits LSB-first innerhalb jedes
-- Base64-Zeichens (siehe ExportUtil.MakeExportDataStream), deshalb wird hier
-- genauso gelesen und nicht wie bei "normalem" Base64.
-- Rueckgabe: table oder nil, fehlerText
function Decoder:DecodeHeader(importString)
    if type(importString) ~= "string" or importString == "" then
        return nil, "leerer String"
    end

    local s = importString:gsub("%s", "")

    -- Wir brauchen nur die ersten 152 Bit = 26 Zeichen (26 * 6 = 156 Bit).
    if #s < 26 then
        return nil, "String zu kurz"
    end

    local bits = {}
    for i = 1, 26 do
        local ch = string.sub(s, i, i)
        local v = CHAR_VALUE[ch]
        if not v then
            return nil, "ungueltiges Zeichen '" .. ch .. "' an Position " .. i
        end
        for b = 0, 5 do
            bits[#bits + 1] = math.floor(v / (2 ^ b)) % 2
        end
    end

    local pos = 1
    local function read(width)
        local value = 0
        for i = 0, width - 1 do
            value = value + bits[pos + i] * (2 ^ i)
        end
        pos = pos + width
        return math.floor(value)
    end

    local version = read(8)
    local specID = read(16)

    local hashEmpty = true
    for _ = 1, 16 do
        if read(8) ~= 0 then hashEmpty = false end
    end

    return {
        version = version,
        specID = specID,
        hashEmpty = hashEmpty,
        length = #s,
    }
end

-- Liefert die aktuell aktive specID des Spielers (oder nil).
function Decoder:GetPlayerSpecID()
    local idx = GetSpecialization and GetSpecialization()
    if not idx then return nil end
    local id = select(1, GetSpecializationInfo(idx))
    return id
end

local function SpecName(specID)
    if not specID then return "?" end
    if GetSpecializationInfoByID then
        local _, name = GetSpecializationInfoByID(specID)
        if name and name ~= "" then return name end
    end
    return "Spec " .. tostring(specID)
end

-- Vollstaendige Pruefung gegen den Spieler.
-- Rueckgabe: ok (bool), grundText (string), header (table|nil)
function Decoder:Validate(importString, expectedSpecID)
    local header, err = self:DecodeHeader(importString)
    if not header then
        return false, "Kein gueltiger Talent-String (" .. tostring(err) .. ")", nil
    end

    if header.version ~= LOADOUT_SERIALIZATION_VERSION then
        return false, string.format(
            "String stammt aus einer aelteren Spielversion (Format %d, erwartet %d)",
            header.version, LOADOUT_SERIALIZATION_VERSION
        ), header
    end

    local target = expectedSpecID or self:GetPlayerSpecID()
    if target and header.specID ~= target then
        return false, string.format(
            "String gehoert zu '%s', du spielst gerade '%s'",
            SpecName(header.specID), SpecName(target)
        ), header
    end

    return true, "ok", header
end

Decoder.SERIALIZATION_VERSION = LOADOUT_SERIALIZATION_VERSION
Decoder.SpecName = function(_, id) return SpecName(id) end

DragonSkill = DragonSkill or {}
DragonSkill.TalentString = Decoder
