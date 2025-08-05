-- ✅ TELEPORTADOR DE BRAINS COM GUI - ATRAVESSA PAREDE
local lp = game.Players.LocalPlayer
local cg = game:GetService("CoreGui")

-- Criar GUI
local gui = Instance.new("ScreenGui", cg)
local btn = Instance.new("TextButton", gui)

btn.Text = "🧠 TELEPORTAR"
btn.Size = UDim2.new(0, 180, 0, 50)
btn.Position = UDim2.new(0, 15, 0, 300)
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
btn.TextColor3 = Color3.new(1,1,1)
btn.TextScaled = true
btn.Font = Enum.Font.GothamBold

-- Localizar base do jogador
local function encontrarBase()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj:FindFirstChild("Owner") and obj.Owner.Value == lp then
			return obj
		end
	end
	return nil
end

-- TELEPORTA brainrots para a base
local function teleportarBrains()
	local base = encontrarBase()
	if not base then return end

	local basePos = base:FindFirstChild("HumanoidRootPart") or base:FindFirstChildWhichIsA("BasePart")
	if not basePos then return end

	for _, brain in pairs(workspace:GetDescendants()) do
		if brain:IsA("Model") and brain.Name:lower():find("brain") then
			local part = brain:FindFirstChild("HumanoidRootPart") or brain:FindFirstChildWhichIsA("BasePart")
			if part then
				-- TELETRANSPORTE DIRETO COM CFrame (atravessa parede)
				part.CFrame = CFrame.new(basePos.Position + Vector3.new(math.random(-5, 5), 5, math.random(-5, 5)))
			end
		end
	end
end

-- Conectar botão
btn.MouseButton1Click:Connect(teleportarBrains)
