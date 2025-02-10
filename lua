local HandCuff
local Key = Enum.KeyCode.R
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local lpc = nil
local cuffing = false

local Gui = Instance.new("ScreenGui")
Gui.Parent = player.PlayerGui
local cuffplayer = Instance.new("TextButton")
cuffplayer.Size = UDim2.new(0, 50, 0, 50)
cuffplayer.Position = UDim2.new(0, 10, 0, 10)
cuffplayer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
cuffplayer.TextColor3 = Color3.fromRGB(255, 255, 255)
cuffplayer.TextStrokeTransparency = 0
cuffplayer.Text = "تفعيل سحب الاعبين عند الضفط عليهم"
cuffplayer.Font = Enum.Font.SourceSansBold
cuffplayer.TextScaled = true
cuffplayer.Parent = Gui
local CuffAll = Instance.new("TextButton")
CuffAll.Size = UDim2.new(0, 50, 0, 50)
CuffAll.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CuffAll.TextColor3 = Color3.fromRGB(255, 255, 255)
CuffAll.TextStrokeTransparency = 0
CuffAll.Text = "سحب جميع الاعبين"
CuffAll.Font = Enum.Font.SourceSansBold
CuffAll.TextScaled = true
CuffAll.Parent = Gui
local UnCuffAll = Instance.new("TextButton")
UnCuffAll.Size = UDim2.new(0, 50, 0, 50)
UnCuffAll.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
UnCuffAll.TextColor3 = Color3.fromRGB(255, 255, 255)
UnCuffAll.TextStrokeTransparency = 0
UnCuffAll.Text = "فك جميع الاعبين"
UnCuffAll.Font = Enum.Font.SourceSansBold
UnCuffAll.TextScaled = true
UnCuffAll.Parent = Gui

CuffAll.Position = cuffplayer.Position + UDim2.fromOffset(0,55)
UnCuffAll.Position = CuffAll.Position + UDim2.fromOffset(0,55)

local ms = false

local function FindHandCuff ()

	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr then
			local hd = plr.Character:FindFirstChildWhichIsA("Tool")
			if hd then
				local RemoteEvent = hd:FindFirstChild("RemoteEvent")
				if RemoteEvent then
					HandCuff = hd
					break
				end
			else
				local hd2 = plr.Backpack:FindFirstChildWhichIsA("Tool")
				if hd2 then
					local RemoteEvent = hd2:FindFirstChild("RemoteEvent")
					if RemoteEvent then
						HandCuff = hd2
						break
					end
				end
			end
		end
	end

end
wait(5)
FindHandCuff()

local uis = game.UserInputService

uis.InputBegan:Connect(function(inp)

	if inp.KeyCode == Enum.KeyCode.R then
		if HandCuff then
			local re = HandCuff:FindFirstChild("RemoteEvent")
			if re then
				if not cuffing and mouse.Target and mouse.Target.Parent:FindFirstChildWhichIsA("Humanoid") then
					cuffing = true
					lpc = mouse.Target
					re:FireServer("Cuff", mouse.Target)
				elseif cuffing then
					cuffing = false
					re:FireServer("UnCuff")
					lpc = nil
				end
			end
		end
	end

	if inp.KeyCode == Enum.KeyCode.Zero then
		for _, plr in pairs(game.Players:GetPlayers()) do
			if plr.Name ~= player.Name then
				
				for _, tool in pairs(plr.Backpack:GetChildren()) do
					if tool:IsA("Tool") and tool:FindFirstChildWhichIsA("RemoteEvent") then
						tool:FindFirstChildWhichIsA("RemoteEvent"):FireServer("Cuff", plr.Character.PrimaryPart)

					end
				end
				
				for _, tool in pairs(plr.Character:GetChildren()) do
					if tool:IsA("Tool") and tool:FindFirstChildWhichIsA("RemoteEvent") then
						tool:FindFirstChildWhichIsA("RemoteEvent"):FireServer("Cuff", plr.Character.PrimaryPart)

					end
				end
			end
		end
	end

	if inp.KeyCode == Enum.KeyCode.Nine then

		for _, plr in pairs(game.Players:GetChildren()) do
			if plr then
				for _, tool in pairs(plr.Backpack:GetChildren()) do
					if tool:IsA("Tool") and tool:FindFirstChildWhichIsA("RemoteEvent") then
						tool:FindFirstChildWhichIsA("RemoteEvent"):FireServer("UnCuff")

					end
				end

				for _, tool in pairs(plr.Character:GetChildren()) do
					if tool:IsA("Tool") and tool:FindFirstChildWhichIsA("RemoteEvent") then
						tool:FindFirstChildWhichIsA("RemoteEvent"):FireServer("UnCuff")

					end
				end
			end
		end

	end

end)


cuffplayer.MouseButton1Click:Connect(function()
	if ms then
		ms = false
		cuffplayer.Text = "تفعيل سحب الاعبين عند الضفط عليهم"
	else
		ms = true
		cuffplayer.Text = "إلغاء سحب الاعبين"
	end
end)

mouse.Button1Up:Connect(function()
	if HandCuff and ms then
		local re = HandCuff:FindFirstChild("RemoteEvent")
		if re then
			if not cuffing and mouse.Target and mouse.Target.Parent:FindFirstChildWhichIsA("Humanoid") then
				cuffing = true
				lpc = mouse.Target
				re:FireServer("Cuff", mouse.Target)
			elseif cuffing then
				cuffing = false
				re:FireServer("UnCuff")
				lpc = nil
			end
		end
	end
end)

CuffAll.MouseButton1Click:Connect(function()
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr.Name ~= player.Name then

			for _, tool in pairs(plr.Backpack:GetChildren()) do
				if tool:IsA("Tool") and tool:FindFirstChildWhichIsA("RemoteEvent") then
					tool:FindFirstChildWhichIsA("RemoteEvent"):FireServer("Cuff", plr.Character.PrimaryPart)

				end
			end

			for _, tool in pairs(plr.Character:GetChildren()) do
				if tool:IsA("Tool") and tool:FindFirstChildWhichIsA("RemoteEvent") then
					tool:FindFirstChildWhichIsA("RemoteEvent"):FireServer("Cuff", plr.Character.PrimaryPart)

				end
			end
		end
	end
end)

UnCuffAll.MouseButton1Click:Connect(function()

	for _, plr in pairs(game.Players:GetChildren()) do
		if plr then
			for _, tool in pairs(plr.Backpack:GetChildren()) do
				if tool:IsA("Tool") and tool:FindFirstChildWhichIsA("RemoteEvent") then
					tool:FindFirstChildWhichIsA("RemoteEvent"):FireServer("UnCuff")

				end
			end

			for _, tool in pairs(plr.Character:GetChildren()) do
				if tool:IsA("Tool") and tool:FindFirstChildWhichIsA("RemoteEvent") then
					tool:FindFirstChildWhichIsA("RemoteEvent"):FireServer("UnCuff")

				end
			end
		end
	end
end)
