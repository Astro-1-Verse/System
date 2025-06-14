local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local library = {}

function library:CreateLib(title, theme)
	local AstroLib = Instance.new("ScreenGui", game.CoreGui)
	AstroLib.Name = "AstroLib"

	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0, 600, 0, 350)
	MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
	MainFrame.BackgroundColor3 = theme.Background
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = AstroLib

	local Header = Instance.new("TextLabel")
	Header.Size = UDim2.new(1, 0, 0, 40)
	Header.BackgroundColor3 = theme.Header
	Header.Text = title
	Header.TextColor3 = theme.TextColor
	Header.Font = Enum.Font.GothamBold
	Header.TextSize = 18
	Header.Parent = MainFrame

	local TabHolder = Instance.new("Frame")
	TabHolder.Size = UDim2.new(0, 100, 1, -40)
	TabHolder.Position = UDim2.new(0, 0, 0, 40)
	TabHolder.BackgroundColor3 = theme.ElementColor
	TabHolder.BorderSizePixel = 0
	TabHolder.Parent = MainFrame

	local ContentHolder = Instance.new("Frame")
	ContentHolder.Size = UDim2.new(1, -100, 1, -40)
	ContentHolder.Position = UDim2.new(0, 100, 0, 40)
	ContentHolder.BackgroundColor3 = theme.Background
	ContentHolder.BorderSizePixel = 0
	ContentHolder.Parent = MainFrame

	local tabs = {}

	local function switchTab(tab)
		for i,v in pairs(ContentHolder:GetChildren()) do
			if v:IsA("ScrollingFrame") then
				v.Visible = false
			end
		end
		tab.Visible = true
	end

	local function createToggle(text, callback)
		local toggle = Instance.new("Frame")
		toggle.Size = UDim2.new(1, -10, 0, 30)
		toggle.BackgroundTransparency = 1

		local toggleText = Instance.new("TextLabel")
		toggleText.Size = UDim2.new(1, -50, 1, 0)
		toggleText.Position = UDim2.new(0, 10, 0, 0)
		toggleText.BackgroundTransparency = 1
		toggleText.Text = text
		toggleText.TextColor3 = theme.TextColor
		toggleText.Font = Enum.Font.Gotham
		toggleText.TextSize = 14
		toggleText.TextXAlignment = Enum.TextXAlignment.Left
		toggleText.Parent = toggle

		local switch = Instance.new("TextButton")
		switch.Size = UDim2.new(0, 40, 0, 20)
		switch.Position = UDim2.new(1, -50, 0.5, -10)
		switch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		switch.BorderSizePixel = 0
		switch.Text = ""
		switch.AutoButtonColor = false
		switch.Parent = toggle

		local knob = Instance.new("Frame")
		knob.Size = UDim2.new(0, 16, 0, 16)
		knob.Position = UDim2.new(0, 2, 0, 2)
		knob.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
		knob.BorderSizePixel = 0
		knob.Parent = switch

		local toggled = false
		switch.MouseButton1Click:Connect(function()
			toggled = not toggled
			if toggled then
				switch.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
				knob:TweenPosition(UDim2.new(1, -18, 0, 2), "Out", "Sine", 0.2, true)
				knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			else
				switch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
				knob:TweenPosition(UDim2.new(0, 2, 0, 2), "Out", "Sine", 0.2, true)
				knob.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
			end
			callback(toggled)
		end)

		return toggle
	end

	function library.CreateTab(tabName)
		local tabButton = Instance.new("TextButton")
		tabButton.Size = UDim2.new(1, 0, 0, 40)
		tabButton.Text = tabName
		tabButton.BackgroundColor3 = theme.Header
		tabButton.TextColor3 = theme.TextColor
		tabButton.Font = Enum.Font.Gotham
		tabButton.TextSize = 14
		tabButton.BorderSizePixel = 0
		tabButton.Parent = TabHolder

		local tabContent = Instance.new("ScrollingFrame")
		tabContent.Size = UDim2.new(1, 0, 1, 0)
		tabContent.CanvasSize = UDim2.new(0, 0, 5, 0)
		tabContent.BackgroundTransparency = 1
		tabContent.Visible = false
		tabContent.Parent = ContentHolder

		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.Padding = UDim.new(0, 6)
		UIListLayout.Parent = tabContent

		tabButton.MouseButton1Click:Connect(function()
			switchTab(tabContent)
		end)

		switchTab(tabContent)

		return {
			CreateButton = function(text, callback)
				local button = Instance.new("TextButton")
				button.Size = UDim2.new(1, -10, 0, 30)
				button.Position = UDim2.new(0, 5, 0, 0)
				button.BackgroundColor3 = theme.ElementColor
				button.TextColor3 = theme.TextColor
				button.Font = Enum.Font.Gotham
				button.TextSize = 14
				button.Text = text
				button.BorderSizePixel = 0
				button.Parent = tabContent
				button.MouseButton1Click:Connect(callback)
			end,
			CreateToggle = function(text, callback)
				local toggle = createToggle(text, callback)
				toggle.Parent = tabContent
			end,
			CreateSlider = function(text, min, max, default, callback)
				local frame = Instance.new("Frame")
				frame.Size = UDim2.new(1, -10, 0, 30)
				frame.BackgroundTransparency = 1
				frame.Parent = tabContent

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(0.3, 0, 1, 0)
				label.Position = UDim2.new(0, 10, 0, 0)
				label.BackgroundTransparency = 1
				label.Text = text
				label.TextColor3 = theme.TextColor
				label.Font = Enum.Font.Gotham
				label.TextSize = 14
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = frame

				local slider = Instance.new("TextButton")
				slider.Size = UDim2.new(0.5, 0, 0, 10)
				slider.Position = UDim2.new(0.4, 0, 0.5, -5)
				slider.BackgroundColor3 = theme.ElementColor
				slider.BorderSizePixel = 0
				slider.Text = ""
				slider.Parent = frame

				local fill = Instance.new("Frame")
				fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
				fill.BackgroundColor3 = theme.SchemeColor
				fill.BorderSizePixel = 0
				fill.Parent = slider

				local dragging = false

				slider.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
					end
				end)

				slider.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						local pos = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
						fill.Size = UDim2.new(pos, 0, 1, 0)
						local value = math.floor(min + (max - min) * pos)
						callback(value)
					end
				end)
			end
		}
	end

	-- Draggable support
	local dragging, dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	MainFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	MainFrame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	return library
end

return library
