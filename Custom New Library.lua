-- Smooth Modular UI Library
local Library = {}
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

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

    local TabHolder = create("Frame", {
        Size = UDim2.new(1, 0, 0, 36),
        Position = UDim2.new(0, 0, 0, 36),
        BackgroundTransparency = 1,
        Parent = Main
    })

    local TabLayout = create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = TabHolder
    })

    local PageContainer = create("Frame", {
        Size = UDim2.new(1, -20, 1, -80),
        Position = UDim2.new(0, 10, 0, 72),
        BackgroundTransparency = 1,
        Parent = Main
    })

    local Pages = {}
    local Tabs = {}

    local Window = {}

    function Window:NewTab(name)
        local Page = create("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 6,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = PageContainer
        })
        local PageLayout = create("UIListLayout", {
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = Page
        })

        local TabBtn = create("TextButton", {
            Text = name,
            Size = UDim2.new(0, 100, 1, -4),
            BackgroundColor3 = colors.ElementColor,
            TextColor3 = colors.TextColor,
            Font = Enum.Font.Gotham,
            TextSize = 14,
            Parent = TabHolder
        })
        create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = TabBtn})

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(Pages) do p.Visible = false end
            Page.Visible = true
        end)

        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)

        Pages[#Pages + 1] = Page

        local Tab = {}

        function Tab:NewSection(title)
            local Section = create("Frame", {
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundTransparency = 1,
                Parent = Page
            })
            create("TextLabel", {
                Size = UDim2.new(1, 0, 0, 24),
                Text = title,
                TextColor3 = colors.SchemeColor,
                Font = Enum.Font.GothamBold,
                TextSize = 16,
                BackgroundTransparency = 1,
                Parent = Section
            })

            local Content = create("Frame", {
                Size = UDim2.new(1, -20, 0, 0),
                Position = UDim2.new(0, 10, 0, 26),
                BackgroundTransparency = 1,
                Parent = Section
            })
            local Layout = create("UIListLayout", {
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = Content
            })
            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Content.Size = UDim2.new(1, -20, 0, Layout.AbsoluteContentSize.Y)
                Section.Size = UDim2.new(1, 0, 0, 26 + Layout.AbsoluteContentSize.Y)
            end)

            local S = {}

            function S:NewButton(text, desc, callback)
                local B = create("TextButton", {
                    Text = text,
                    Size = UDim2.new(0, 200, 0, 32),
                    BackgroundColor3 = colors.ElementColor,
                    TextColor3 = colors.TextColor,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    Parent = Content
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = B})
                B.MouseButton1Click:Connect(callback)
                return {
                    UpdateButton = function(_, newText)
                        B.Text = newText
                    end
                }
            end

            -- More element constructors like toggles, sliders, dropdowns, etc. go here...

            return S
        end

        return Tab
    end

    function Window:ToggleUI()
        Main.Visible = not Main.Visible
    end

    function Window:ChangeColor(prop, color)
        if colors[prop] then
            colors[prop] = color
            -- Color update logic
        end
    end

    return Window
end

return Library
