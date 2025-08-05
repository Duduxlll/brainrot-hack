-- ✅ MOD FINALIZADO - FUNCIONA TUDO (atravessar, voltar pra base, speed)
local lp = game.Players.LocalPlayer
local cg = game:GetService("CoreGui")
local rs = game:GetService("RunService")
local gui = Instance.new("ScreenGui", cg)
gui.Name = "BrainHackGUIvFinal"

-- Criar botão
local function criarBotao(nome, cor, posY, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 200, 0, 50)
	b.Position = UDim2.new(0, 20, 0, posY)
	b.BackgroundColor3 = cor
	b.TextColor3 = Color3.new(1, 1, 1)
	b.TextScaled = true
	b.Font = Enum.Font.GothamBold
	b.Text = nome
	b.Parent = gui
	b.MouseButton1Click:Connect(callback)
	return b
end

-- ✅ NOCLIP FUNCIONAL
local noclipAtivo = false
local function toggleNoclip()
	noclipAtivo = not noclipAtivo
	noclipBtn.Text = noclipAtivo and "✅ ATRAVESSANDO" or "🚪 ATRAVESSAR"
end

rs.Stepped:Connect(function()
	if noclipAtivo and lp.Character then
		for _, part in pairs(lp.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- ✅ TELEPORTAR PARA A BASE REAL
local function irParaBase()
	local base = nil
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj:FindFirstChild("Owner") and obj.Owner.Value == lp then
			local p = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
			if p then
				base = p
				break
			end
		end
	end

	if base then
		local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = base.CFrame + Vector3.new(0, 5, 0)
		end
	else
		warn("❌ Base não encontrada.")
	end
end

-- ✅ ALTERAR VELOCIDADE FUNCIONANDO
local function setSpeed(multiplicador)
	local hum = lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid")
	if hum then
		hum.WalkSpeed = 16 * multiplicador
	end
end

-- Criar os botões
local noclipBtn = criarBotao("🚪 ATRAVESSAR", Color3.fromRGB(255, 85, 0), 250, toggleNoclip)
criarBotao("🏠 IR PARA BASE", Color3.fromRGB(0, 170, 0), 310, irParaBase)

criarBotao("💨 SPEED x2", Color3.fromRGB(50, 150, 255), 370, function() setSpeed(2) end)
criarBotao("💨 SPEED x4", Color3.fromRGB(50, 150, 255), 430, function() setSpeed(4) end)
criarBotao("💨 SPEED x8", Color3.fromRGB(50, 150, 255), 490, function() setSpeed(8) end)
criarBotao("💨 SPEED x16", Color3.fromRGB(50, 150, 255), 550, function() setSpeed(16) end)

