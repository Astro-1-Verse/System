-- Custom UI Lib with drag, minimize, and smooth toggle switch

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Library = {}
Library.ElementColor = Color3.fromRGB(40, 40, 40)
Library.TextColor = Color3.fromRGB(230, 230, 230)

function Library:CreateWindow(title)
    local Window = {}
    
    -- Main frame
    Window.Main = Instance.new("Frame")
    Window.Main.Size = UDim2.new(0, 400, 0, 300)
    Window.Main.Position = UDim2.new(0.5, -200, 0.5, -150)
    Window.Main.BackgroundColor3 = self.ElementColor
    Window.Main.BorderSizePixel = 0
    Window.Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.Main.Parent = game.CoreGui -- or wherever you want
    
    -- Title bar
    Window.Header = Instance.new("Frame")
    Window.Header.Size = UDim2.new(1, 0, 0, 30)
    Window.Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Window.Header.Parent = Window.Main
    
    -- Title label
    Window.Title = Instance.new("TextLabel")
    Window.Title.Text = title or "UI Window"
    Window.Title.Size = UDim2.new(1, -60, 1, 0)
    Window.Title.BackgroundTransparency = 1
    Window.Title.TextColor3 = self.TextColor
    Window.Title.Font = Enum.Font.SourceSansBold
    Window.Title.TextSize = 18
    Window.Title.TextXAlignment = Enum.TextXAlignment.Left
    Window.Title.Position = UDim2.new(0, 10, 0, 0)
    Window.Title.Parent = Window.Header
    
    -- Minimize button
    local minimized = false
    local originalSize = Window.Main.Size
    local originalPosition = Window.Main.Position

    Window.MinimizeButton = Instance.new("TextButton")
    Window.MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
    Window.MinimizeButton.Position = UDim2.new(1, -35, 0, 2)
    Window.MinimizeButton.Text = "-"
    Window.MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Window.MinimizeButton.TextColor3 = Color3.new(1,1,1)
    Window.MinimizeButton.BorderSizePixel = 0
    Window.MinimizeButton.Parent = Window.Header

    Window.MinimizeButton.MouseButton1Click:Connect(function()
        if not minimized then
            originalSize = Window.Main.Size
            originalPosition = Window.Main.Position
            Window.Main.Size = UDim2.new(0, 40, 0, 40)
            Window.Main.Position = UDim2.new(0, 10, 0, 10)
            for _, child in pairs(Window.Main:GetChildren()) do
                if child ~= Window.MinimizeButton and child ~= Window.Header then
                    child.Visible = false
                end
            end
            minimized = true
        else
            Window.Main.Size = originalSize
            Window.Main.Position = originalPosition
            for _, child in pairs(Window.Main:GetChildren()) do
                child.Visible = true
            end
            minimized = false
        end
    end)

    -- Make window draggable
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        Window.Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    Window.Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.Main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Window.Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Container frame for sections/buttons/toggles below header
    Window.Container = Instance.new("Frame")
    Window.Container.Size = UDim2.new(1, 0, 1, -30)
    Window.Container.Position = UDim2.new(0, 0, 0, 30)
    Window.Container.BackgroundTransparency = 1
    Window.Container.Parent = Window.Main

    -- Section creation
    function Window:NewSection(title)
        local Section = {}

        Section.Frame = Instance.new("Frame")
        Section.Frame.Size = UDim2.new(1, -20, 0, 100)
        Section.Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Section.Frame.Position = UDim2.new(0, 10, 0, #self.Container:GetChildren()*110) -- stacked
        Section.Frame.Parent = self.Container

        Section.Title = Instance.new("TextLabel")
        Section.Title.Text = title or "Section"
        Section.Title.Size = UDim2.new(1, 0, 0, 20)
        Section.Title.BackgroundTransparency = 1
        Section.Title.TextColor3 = Library.TextColor
        Section.Title.Font = Enum.Font.SourceSansBold
        Section.Title.TextSize = 16
        Section.Title.Parent = Section.Frame

        -- Container for buttons/toggles inside section
        Section.Container = Instance.new("Frame")
        Section.Container.Size = UDim2.new(1, 0, 1, -20)
        Section.Container.Position = UDim2.new(0, 0, 0, 20)
        Section.Container.BackgroundTransparency = 1
        Section.Container.Parent = Section.Frame

        -- New Button
        function Section:NewButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -20, 0, 30)
            Button.Position = UDim2.new(0, 10, 0, #self.Container:GetChildren()*35)
            Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Button.Text = text
            Button.TextColor3 = Library.TextColor
            Button.Font = Enum.Font.SourceSans
            Button.TextSize = 16
            Button.Parent = self.Container

            Button.MouseButton1Click:Connect(function()
                callback()
            end)
        end

        -- New Toggle with smooth iOS style animation
        function Section:NewToggle(text, callback)
            local Toggle = Instance.new("Frame")
            Toggle.Size = UDim2.new(1, 0, 0, 30)
            Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Toggle.Position = UDim2.new(0, 0, 0, #self.Container:GetChildren()*35)
            Toggle.Parent = self.Container

            local Label = Instance.new("TextLabel")
            Label.Text = text
            Label.Size = UDim2.new(0.7, 0, 1, 0)
            Label.BackgroundTransparency = 1
            Label.TextColor3 = Library.TextColor
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Font = Enum.Font.SourceSans
            Label.TextSize = 16
            Label.Parent = Toggle

            local ToggleButton = Instance.new("Frame")
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Parent = Toggle
            ToggleButton.ClipsDescendants = true
            ToggleButton.AnchorPoint = Vector2.new(1, 0.5)

            local Ball = Instance.new("Frame")
            Ball.Size = UDim2.new(0, 18, 0, 18)
            Ball.Position = UDim2.new(0, 1, 0.5, -9)
            Ball.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
            Ball.BorderSizePixel = 0
            Ball.Parent = ToggleButton
            Ball.AnchorPoint = Vector2.new(0, 0.5)
            Ball.ZIndex = 2
            Ball.Name = "Ball"

            local toggled = false

            local onBgColor = Color3.fromRGB(0, 200, 0)
            local offBgColor = Color3.fromRGB(150, 150, 150)
            local onBallColor = Color3.fromRGB(255, 255, 255)
            local offBallColor = Color3.fromRGB(120, 120, 120)

            local onPosition = UDim2.new(1, -20, 0.5, -9)
            local offPosition = UDim2.new(0, 1, 0.5, -9)

            local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

            local function updateToggle(state)
                if state then
                    TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = onBgColor}):Play()
                    TweenService:Create(Ball, tweenInfo, {BackgroundColor3 = onBallColor, Position = onPosition}):Play()
                else
                    TweenService:Create(ToggleButton, tweenInfo, {BackgroundColor3 = offBgColor}):Play()
                    TweenService:Create(Ball, tweenInfo, {BackgroundColor3 = offBallColor, Position = offPosition}):Play()
                end
            end

            Toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                updateToggle(toggled)
                callback(toggled)
            end)

            -- Init to off
            updateToggle(false)

            return Toggle
        end

        return Section
    end

    return Window
end
