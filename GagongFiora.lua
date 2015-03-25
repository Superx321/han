if myHero.charName ~= 'Fiora' then return end

assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("VILJNMKINNK")

class "ScriptUpdate"
function ScriptUpdate:__init(LocalVersion, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
    self.LocalVersion = LocalVersion
    self.Host = Host
    self.VersionPath = '/BoL/TCPUpdater/GetScript3.php?script='..self:Base64Encode(self.Host..VersionPath)..'&rand='..math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript3.php?script='..self:Base64Encode(self.Host..ScriptPath)..'&rand='..math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = CallbackUpdate
    self.CallbackNoUpdate = CallbackNoUpdate
    self.CallbackNewVersion = CallbackNewVersion
    self.CallbackError = CallbackError
    AddDrawCallback(function() self:OnDraw() end)
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
end

function ScriptUpdate:OnDraw()
    --    DrawText('Download Status: '..(self.DownloadStatus or 'Unknown'),50,10,50,ARGB(0xFF,0xFF,0xFF,0xFF))
end

function ScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.Socket = self.LuaSocket.connect('sx-bol.eu', 80)
    self.Socket:send("GET "..url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    self.Socket:settimeout(0, 'b')
    self.Socket:settimeout(99999999, 't')
    self.LastPrint = ""
    self.File = ""
end

function ScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        local recv,sent,time = self.Socket:getstats()
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</s'..'ize>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</s'..'ize>')-1)) + self.File:len()
        end
        self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*self.File:len(),2)..'%)'
    end
    if not (self.Receive or (#self.Snipped > 0)) and self.RecvStarted and math.round(100/self.Size*self.File:len(),2) > 95 then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
        local ContentEnd, _ = self.File:find('</sc'..'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion = tonumber(self.File:sub(ContentStart + 1,ContentEnd-1))
            if self.OnlineVersion > self.LocalVersion then
                if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
                    self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
                end
                self:CreateSocket(self.ScriptPath)
                self.DownloadStatus = 'Connect to Server for ScriptDownload'
                AddTickCallback(function() self:DownloadUpdate() end)
            else
                if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
                    self.CallbackNoUpdate(self.LocalVersion)
                end
            end
        end
        self.GotScriptVersion = true
    end
end

function ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        local recv,sent,time = self.Socket:getstats()
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</size>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1)) + self.File:len()
        end
        self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*self.File:len(),2)..'%)'
    end
    if not (self.Receive or (#self.Snipped > 0)) and self.RecvStarted and math.round(100/self.Size*self.File:len(),2) > 95 then
        self.DownloadStatus = 'Downloading Script (100%)'
        local HeaderEnd, ContentStart = self.File:find('<sc'..'ript>')
        local ContentEnd, _ = self.File:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local f = io.open(self.SavePath,"w+")
            f:write(self.File:sub(ContentStart + 1,ContentEnd-1))
            f:close()
            if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
            end
        end
        self.GotScriptUpdate = true
    end
end

class 'Orbwalker'

function Orbwalker:__init(targetSelector)
    self.targetSelector = targetSelector

    self.lastAttack = 0
    self.timeToMove = 0
    self.timeToAttack = 0

    self.holdRange = 57.5 * 57.5
    self.staticRange = myHero.range + 65

    AddTickCallback(function()
        self.dynamicTime = os.clock() + GetLatency() / 1000
        if Menu.Orbwalker.IsActive then
            self.autoAttackTarget = self.targetSelector:getConsideredTarget(0)
            if self.autoAttackTarget and self:canAttack() then
                CastItem(3142)
                myHero:Attack(self.autoAttackTarget)
            elseif self:canMove() and GetDistanceSqr(mousePos) > self.holdRange then
                local moveToVector = Vector(myHero) + (Vector(mousePos) - Vector(myHero)) * 250 / GetDistance(mousePos)
                myHero:MoveTo(moveToVector.x, moveToVector.z)
            end
        end
    end)
    AddRecvPacketCallback(function(packet)
        if Menu.Orbwalker.DetectCancel then
            if packet.header == 24 then
                packet.pos = 2
                if packet:DecodeF() == myHero.networkID then
                    packet.pos = 14
                    if packet:Decode1() == 91 then
                        packet.pos = 19
                        local isAttack = packet:Decode1()
                        if isAttack == 118 or isAttack == 0 then
                            self.timeToMove = 0
                            self.timeToAttack = 0
                            self.afterAttackCheck = false
                            --print("cancelled auto attack")
                        else
                            --print("cancelled random animation")
                        end
                    end
                end
            end
        end
    end)
    AddProcessSpellCallback(function(unit, spell)
        if unit.isMe then
            if spell.name:lower():find('attack') then
                self.lastAttack = os.clock()
                self.timeToMove = self.lastAttack + spell.windUpTime + Menu.Orbwalker.ExtraWindupTime / 1000
                self.timeToAttack = self.lastAttack + spell.animationTime
                self.afterAttackCheck = true
            elseif spell.name:lower():find('flurry') then
                self.timeToMove = 0
                self.timeToAttack = 0
            end
        end
    end)
    return self
end

function Orbwalker:canAttack()
    if self.lastAttack <= os.clock() then
        return self.dynamicTime > self.timeToAttack
    end
    return false
end

function Orbwalker:canMove()
    if self.lastAttack <= os.clock() then
        return self.dynamicTime > self.timeToMove
    end
    return false
end

function Orbwalker:afterAttack()
    if self.dynamicTime > self.timeToMove and self.afterAttackCheck then
        self.afterAttackCheck = false
        return true
    end
    return false
end

function Orbwalker:afterAttackTick()
    return self.dynamicTime > self.timeToMove and self.dynamicTime < self.timeToAttack
end

class 'TargetSelector'

function TargetSelector:__init()
    self.selectRange = 200 * 200
    self.staticRange = myHero.range + 65

    self.consideredTarget = {}
    self.consideredRatios = {}

    self.opponentHeroes = GetEnemyHeroes()

    AddTickCallback(function()
        if self.selectedTarget and not ValidTarget(self.selectedTarget) then
            self.selectedTarget = nil
        end
        for i = 0, 4 do
            self.consideredRatios[i] = 0
            self.consideredTarget[i] = nil
        end
        for _, opponent in pairs(self.opponentHeroes) do
            if not self.selectedTarget or self.selectedTarget == opponent then
                local consideredRange = 600
                while consideredRange >= 200 do
                    if consideredRange >= 300 then
                        if GetDistanceSqr(opponent) < (consideredRange * consideredRange) - 9 and ValidTarget(opponent) then
                            local index = (700 - consideredRange) / 100
                            local currentRatio = myHero.totalDamage / opponent.armor / opponent.health
                            if currentRatio > self.consideredRatios[index] then
                                self.consideredRatios[index] = currentRatio
                                self.consideredTarget[index] = opponent
                            end
                        end
                    else
                        local autoAttackRange = self.staticRange + opponent.boundingRadius
                        if GetDistanceSqr(opponent) < autoAttackRange * autoAttackRange and ValidTarget(opponent) then
                            local currentRatio = myHero.totalDamage / opponent.armor / opponent.health
                            if currentRatio > self.consideredRatios[0] then
                                self.consideredRatios[0] = currentRatio
                                self.consideredTarget[0] = opponent
                            end
                        end
                    end
                    consideredRange = consideredRange - 100
                end
            end
        end
    end)
    AddMsgCallback(function(message, key)
        if message == 514 and Menu.Orbwalker.SelectedTarget then
            self.selectedTarget = nil
            for _, opponent in pairs(self.opponentHeroes) do
                if GetDistanceSqr(opponent, mousePos) < self.selectRange and ValidTarget(opponent) then
                    self.selectedTarget = opponent
                end
            end
        end
    end)
    AddDrawCallback(function()
        if self.selectedTarget and not myHero.dead then
            local barPos = GetUnitHPBarPos(myHero)
            local barPosOffset = GetUnitHPBarOffset(myHero)
            local startX = barPos.x + (barPosOffset.x * 171)
            local startY = barPos.y + (barPosOffset.y * 46)
            DrawText(self.selectedTarget.charName, 18, startX - 28.5, startY + 126.6, ARGB(255, 0, 0, 0))
            DrawText(self.selectedTarget.charName, 18, startX - 30, startY + 125, ARGB(255, 0, 139, 139))
            DrawCircle2(self.selectedTarget.x, self.selectedTarget.y, self.selectedTarget.z, 150, ARGB(255, 0, 139, 139))
        end
    end)

    return self
end

function TargetSelector:getConsideredTarget(i)
    return self.consideredTarget[i]
end

class 'W'

function W:__init()
    self.activeAttacks = {}

    AddTickCallback(function()
        for i, attack in pairs(self.activeAttacks) do
            if attack and os.clock() + GetLatency() / 1000 > attack then
                if myHero:CanUseSpell(1) == 0 then
                    CastSpell(1)
                end
                self.activeAttacks[i] = nil
            end
        end
    end)
    AddRecvPacketCallback(function(packet)
        if packet.header == 24 then
            for id, attack in pairs(self.activeAttacks) do
                packet.pos = 2
                if packet:DecodeF() == id then
                    packet.pos = 14
                    if packet:Decode1() == 91 then
                        packet.pos = 19
                        local registered = packet:Decode1()
                        if registered == 188 or registered == 0 then
                            --print("enemy cancelled")
                            self.activeAttacks[id] = nil
                        end
                    end
                end
            end
        end
    end)
    AddProcessSpellCallback(function(unit, spell)
        if unit.type == myHero.type and unit.team ~= myHero.team then
            if spell.name:lower():find('attack') and spell.target == myHero then
                if unit.range > 300 then
                    self.activeAttacks[unit.networkID] = os.clock() + spell.windUpTime + GetLatency() / 2000
                else
                    self.activeAttacks[unit.networkID] = os.clock() + spell.windUpTime - GetLatency() / 1000 - 0.025
                end
            end
        end
    end)

    return self
end

class 'R'
function R:__init(targetSelector)
    self.targetSelector = targetSelector

    AddTickCallback(function()
        if Menu.Gagong.MagneticTouch and myHero:CanUseSpell(_R) == READY then
            local bestTarget = self.targetSelector:getConsideredTarget(3)
            if bestTarget then
                CastSpell(_R, bestTarget)
            end
        end
    end)

    return self
end

class 'Combo'

function Combo:__init(orbwalker, targetSelector)
    self.orbwalker = orbwalker
    self.targetSelector = targetSelector

    self.secondActive = false

    AddTickCallback(function()
        if self.secondActive and os.clock() - self.secondActive > 4 then
            self.secondActive = nil
        end
        self.afterAttackTarget = self.targetSelector:getConsideredTarget(0)
        if self.orbwalker:afterAttack() then
            if Menu.Orbwalker.IsActive and self.afterAttackTarget then
                local canCastE = myHero:CanUseSpell(2) == 0
                local canCastQ = myHero:CanUseSpell(0) == 0 and ((Menu.Gagong.AfterAttackFirst and not self.secondActive) or (Menu.Gagong.AfterAttackSecond and self.secondActive))
                if canCastE then
                    if canCastQ then
                        CastSpell(0, self.afterAttackTarget)
                    end
                    CastSpell(2)
                elseif canCastQ then
                    CastSpell(0, self.afterAttackTarget)
                    if true then
                        CastItem(3077)
                        CastItem(3074)
                    end
                else
                    CastItem(3077)
                    CastItem(3074)
                end
            end
        elseif not self.afterAttackTarget and self.orbwalker:afterAttackTick() then
            self.afterAttackTarget = self.targetSelector:getConsideredTarget(4)
            if Menu.Orbwalker.IsActive and self.afterAttackTarget then
                local canCastQ = myHero:CanUseSpell(0) == 0 and ((Menu.Gagong.AfterAttackFirst and not self.secondActive) or (Menu.Gagong.AfterAttackSecond and self.secondActive))
                if canCastQ then
                    CastSpell(0, self.afterAttackTarget)
                else
                    CastItem(3077)
                    CastItem(3074)
                end
            end
        end
        if Menu.Orbwalker.IsActive then
            self.gapCloseTarget = self.targetSelector:getConsideredTarget(1)
            if self.gapCloseTarget and myHero:CanUseSpell(0) == 0 then
                local currentDistance = GetDistanceSqr(self.gapCloseTarget)
                if currentDistance > Menu.Gagong.GapcloseRange * Menu.Gagong.GapcloseRange then
                    CastSpell(0, self.gapCloseTarget)
                    local dynamicRange = 600 - (0.672 * myHero.attackSpeed) * 60
                    if currentDistance > dynamicRange * dynamicRange then
                        CastItem(3077)
                        CastItem(3074)
                    end
                end
            end
        end
    end)

    AddProcessSpellCallback(function(unit, spell)
        if unit.isMe and spell.name:lower():find('fioraq') and not self.secondActive then
            self.secondActive = os.clock() - GetLatency() / 2000
        end
    end)

    return self
end

function OnDraw()
    if myHero.dead then return end
    if Menu.Drawing.AutoAttackRange then
        DrawCircle2(myHero.x, myHero.y, myHero.z, myHero.range + 120, ARGB(255, 255, 255, 255))
    end
    if Menu.Drawing.RRange then
        DrawCircle2(myHero.x, myHero.y, myHero.z, 400, ARGB(255, 255, 255, 255))
    end
    if Menu.Drawing.QRange then
        DrawCircle2(myHero.x, myHero.y, myHero.z, 600, ARGB(255, 0, 200, 200))
    end
    if Menu.Drawing.QCastRange then
        DrawCircle2(myHero.x, myHero.y, myHero.z, Menu.Gagong.GapcloseRange, ARGB(255, 0, 200, 200))
    end
    if Menu.Drawing.ComboAwareness then
        local barPos = GetUnitHPBarPos(myHero)
        local barPosOffset = GetUnitHPBarOffset(myHero)
        local startX = barPos.x + (barPosOffset.x * 171) - 42
        local startY = barPos.y + (barPosOffset.y * 46) + 14
        if Menu.Gagong.AfterAttackFirst then
            DrawLine(startX, startY, startX + 15, startY, 14, ARGB(255, 99, 99, 99))
            DrawText('1', 14, startX + 5, startY - 6.5, ARGB(255, 255, 255, 255))
        end
        if Menu.Gagong.AfterAttackSecond then
            DrawLine(startX+15, startY, startX + 66, startY, 14, ARGB(255, 0, 139, 139))
            DrawText('GAGONG', 14, startX + 17, startY - 6.5, ARGB(255, 255, 255, 255))
        end
    end
end

-- vadash etc
function DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
    radius = radius or 300
    quality = math.max(8,math.floor(180/math.deg((math.asin((chordlength/(2*radius)))))))
    quality = 2 * math.pi / quality
    radius = radius*.92
    local points = {}
    for theta = 0, 2 * math.pi + quality, quality do
        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
    end
    DrawLines2(points, 1, color or 4294967295)
end

function DrawCircle2(x, y, z, radius, color)
    local vPos1 = Vector(x, y, z)
    local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
    local tPos = vPos1 - (vPos1 - vPos2):normalized() * radius
    local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
    if OnScreen({ x = sPos.x, y = sPos.y }, { x = sPos.x, y = sPos.y }) then
        DrawCircleNextLvl(x, y, z, radius, 2, color, 75)
    end
end

function OnLoad()
    if VIP_USER then HookPackets() end

    local ToUpdate = {}
    ToUpdate.Version = 1.04
    ToUpdate.Host = "raw.githubusercontent.com"
    ToUpdate.VersionPath = "/Superx321/han/master/GagongFiora.Version"
    ToUpdate.ScriptPath =  "/Superx321/han/master/GagongFiora.lua"
    ToUpdate.SavePath = SCRIPT_PATH.._ENV.FILE_NAME
    ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#F0Ff8d\"><b>Gagong Fiora: </b></font> <font color=\"#FF0F0F\">Updated to "..NewVersion..". Please Reload with 2x F9</b></font>") end
    ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#F0Ff8d\"><b>Gagong Fiora: </b></font> <font color=\"#FF0F0F\">No Updates Found</b></font>") end
    ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#F0Ff8d\"><b>Gagong Fiora Ex: </b></font> <font color=\"#FF0F0F\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
    ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#F0Ff8d\"><b>Gagong Fiora Ex: </b></font> <font color=\"#FF0F0F\">Error while Downloading. Please try again.</b></font>") end
    ScriptUpdate(ToUpdate.Version, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)

    Menu = scriptConfig('Gagong Fiora', 'GagongFiora_1')
    Menu:addSubMenu('Drawing', 'Drawing')
    Menu.Drawing:addParam('QRange', 'Q Range', SCRIPT_PARAM_ONOFF, true)
    Menu.Drawing:addParam('QCastRange', 'Q Cast Range', SCRIPT_PARAM_ONOFF, true)
    Menu.Drawing:addParam('RRange', 'R Range', SCRIPT_PARAM_ONOFF, false)
    Menu.Drawing:addParam('AutoAttackRange', 'AA Range', SCRIPT_PARAM_ONOFF, true)
    Menu.Drawing:addParam('ComboAwareness', 'Combo Awareness', SCRIPT_PARAM_ONOFF, true)

    Menu:addSubMenu('Orbwalker', 'Orbwalker')
    Menu.Orbwalker:addParam('DetectCancel', 'Detect Cancel', SCRIPT_PARAM_ONOFF, false)
    Menu.Orbwalker:addParam('SelectedTarget', 'Focus Left Clicked Target', SCRIPT_PARAM_ONOFF, true)
    Menu.Orbwalker:addParam('ExtraWindupTime', 'Additional Windup Time', SCRIPT_PARAM_SLICE, 25, 0, 100)
    Menu.Orbwalker:addParam('IsActive', 'Orbwalk Key', SCRIPT_PARAM_ONKEYDOWN, false, 32)

    Menu:addSubMenu('Gagong Fiora', 'Gagong')
    Menu.Gagong:addParam('GapcloseRange', 'Min Range To Cast Q', SCRIPT_PARAM_SLICE, 325, 0, 600)
    Menu.Gagong:addParam('AfterAttackFirst', 'Q1 in AfterAttackCombo', SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte('C'))
    Menu.Gagong:addParam('AfterAttackSecond', 'Q2 in AfterAttackCombo', SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte('V'))
    Menu.Gagong:addParam('MagneticTouch', 'Cast R on Best Target', SCRIPT_PARAM_ONKEYDOWN, false, string.byte('R'))

    local targetSelector = TargetSelector()
    local orbwalker = Orbwalker(targetSelector)
    W()
    R(targetSelector)
    Combo(orbwalker, targetSelector)
    print('<font color=\"#98F5FF\">Gagong Fiora: Testversion loaded. No Autoupdate yet, so check the forum for updates for now')
    print('<font color=\"#98F5FF\">Gagong Fiora: Pressing v will enable the GAGONG mode')
end