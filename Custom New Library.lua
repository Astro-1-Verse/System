-- Smooth Modular UI Library
local Library = {}
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local function create(class, props)
    local inst = Instance.new(class)
    for i, v in pairs(props) do
        inst[i] = v
    end
    return inst
end

function Library.CreateLib(title, theme)
    local ScreenGui = create("ScreenGui", {
        Name = "ModularUI",
        Parent = game:GetService("CoreGui"),
        ResetOnSpawn = false
    })

    local colors = (typeof(theme) == "table") and theme or {
        SchemeColor = Color3.fromRGB(0, 170, 255),
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(35, 35, 35),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(40, 40, 40)
    }

    local Main = create("Frame", {
        Size = UDim2.new(0, 480, 0, 350),
        Position = UDim2.new(0.5, -240, 0.5, -175),
        BackgroundColor3 = colors.Background,
        Parent = ScreenGui
    })
    create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Main})

    local Header = create("Frame", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = colors.Header,
        Parent = Main
    })
    create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Header})

    create("TextLabel", {
        Text = title,
        Size = UDim2.new(1, -90, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        TextColor3 = colors.TextColor,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        Parent = Header
    })

    local Close = create("TextButton", {
        Text = "✕",
        Size = UDim2.new(0, 30, 1, 0),
        Position = UDim2.new(1, -30, 0, 0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(255, 90, 90),
        Font = Enum.Font.Gotham,
        TextSize = 18,
        Parent = Header
    })
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Dragging logic
    local dragging, dragInput, dragStart, startPos

    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Container for pages or tabs
    local TabContainer = create("Frame", {
        Size = UDim2.new(1, 0, 1, -36),
        Position = UDim2.new(0, 0, 0, 36),
        BackgroundColor3 = colors.ElementColor,
        Parent = Main
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = TabContainer})

    -- You can return things here to build on tabs/pages later
    return {
        Main = Main,
        TabContainer = TabContainer,
        Colors = colors,
        Create = create
    }
end

return Library
