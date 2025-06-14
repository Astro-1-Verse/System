-- Smooth Modular UI Library (Modified for full width UI elements)
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
                Size = UDim2.new(1, 0, 0, 0), -- full width now (was 1,-20)
                Position = UDim2.new(0, 0, 0, 26), -- adjusted to align with label height
                BackgroundTransparency = 1,
                Parent = Section
            })
            local Layout = create("UIListLayout", {
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = Content
            })
            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Content.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y)
                Section.Size = UDim2.new(1, 0, 0, 26 + Layout.AbsoluteContentSize.Y)
            end)

            local S = {}

            function S:NewButton(text, desc, callback)
                local B = create("TextButton", {
                    Text = text,
                    Size = UDim2.new(1, 0, 0, 32),  -- full width
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

            -- Placeholders for toggles, sliders, dropdowns, textboxes with fixed sizes updated

            function S:NewToggle(text, callback)
                local toggled = false

                local ToggleFrame = create("Frame", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundColor3 = colors.ElementColor,
                    Parent = Content
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ToggleFrame})

                local Label = create("TextLabel", {
                    Text = text,
                    Size = UDim2.new(0.8, 0, 1, 0),
                    BackgroundTransparency = 1,
                    TextColor3 = colors.TextColor,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = ToggleFrame
                })

                local ToggleBtn = create("TextButton", {
                    Size = UDim2.new(0.2, -8, 0, 24),
                    Position = UDim2.new(0.8, 8, 0, 4),
                    BackgroundColor3 = Color3.fromRGB(70, 70, 70),
                    AutoButtonColor = false,
                    Parent = ToggleFrame
                })
                create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = ToggleBtn})

                local ToggleCircle = create("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 4, 0, 4),
                    BackgroundColor3 = colors.SchemeColor,
                    Parent = ToggleBtn
                })
                create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ToggleCircle})

                ToggleBtn.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    if toggled then
                        ToggleCircle.Position = UDim2.new(1, -20, 0, 4)
                    else
                        ToggleCircle.Position = UDim2.new(0, 4, 0, 4)
                    end
                    callback(toggled)
                end)

                return {
                    SetState = function(_, state)
                        toggled = state
                        ToggleCircle.Position = toggled and UDim2.new(1, -20, 0, 4) or UDim2.new(0, 4, 0, 4)
                    end
                }
            end

            function S:NewSlider(text, min, max, default, callback)
                local SliderFrame = create("Frame", {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = colors.ElementColor,
                    Parent = Content
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = SliderFrame})

                local Label = create("TextLabel", {
                    Text = text,
                    Size = UDim2.new(1, 0, 0, 14),
                    BackgroundTransparency = 1,
                    TextColor3 = colors.TextColor,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = SliderFrame
                })

                local SliderBar = create("Frame", {
                    Size = UDim2.new(1, -20, 0, 12),
                    Position = UDim2.new(0, 10, 0, 24),
                    BackgroundColor3 = Color3.fromRGB(70, 70, 70),
                    Parent = SliderFrame
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = SliderBar})

                local SliderFill = create("Frame", {
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = colors.SchemeColor,
                    Parent = SliderBar
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = SliderFill})

                local dragging = false

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)

                SliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                SliderBar.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local relativeX = math.clamp(input.Position.X - SliderBar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
                        local value = min + (relativeX / SliderBar.AbsoluteSize.X) * (max - min)
                        SliderFill.Size = UDim2.new(relativeX / SliderBar.AbsoluteSize.X, 0, 1, 0)
                        callback(value)
                    end
                end)

                return {
                    SetValue = function(_, val)
                        local clamped = math.clamp(val, min, max)
                        SliderFill.Size = UDim2.new((clamped - min) / (max - min), 0, 1, 0)
                        callback(clamped)
                    end
                }
            end

            function S:NewTextbox(text, placeholder, callback)
                local TextboxFrame = create("Frame", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundColor3 = colors.ElementColor,
                    Parent = Content
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = TextboxFrame})

                local Label = create("TextLabel", {
                    Text = text,
                    Size = UDim2.new(0.3, 0, 1, 0),
                    BackgroundTransparency = 1,
                    TextColor3 = colors.TextColor,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = TextboxFrame
                })

                local TextBox = create("TextBox", {
                    PlaceholderText = placeholder or "",
                    Size = UDim2.new(0.65, 0, 0.8, 0),
                    Position = UDim2.new(0.33, 0, 0.1, 0),
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                    TextColor3 = colors.TextColor,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    ClearTextOnFocus = false,
                    Parent = TextboxFrame
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = TextBox})

                TextBox.FocusLost:Connect(function()
                    callback(TextBox.Text)
                end)

                return {
                    SetText = function(_, val)
                        TextBox.Text = val
                    end
                }
            end

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
            -- Color update logic (you can add your theme update here)
        end
    end

    return Window
end

return Library
