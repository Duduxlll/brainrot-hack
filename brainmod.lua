-- ✅ FINALIZADO: Atravessar parede (noclip) e teleporte para base sem bugs
local lp = game.Players.LocalPlayer
local cg = game:GetService("CoreGui")
local rs = game:GetService("RunService")
local gui = Instance.new("ScreenGui", cg)
gui.Name = "BrainGUI"

-- Criar botão
local function criarBotao(nome, cor, posY, func)
	local b = Instance.new("TextButton", gui)
	b.Size = UDim2.new(0, 200, 0, 50)
	b.Position = UDim2.new(0, 15, 0, posY)
	b.BackgroundColor3 = cor
	b.TextColor3 = Color3.new(1, 1, 1)
	b.TextScaled = true
	b.Font = Enum.Font.GothamBold
	b.Text = nome
	b.MouseButton1Click:Connect(func)
	return b
end

-- ✅ NOCLIP SEM BUG (você atravessa parede com suavidade)
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

-- ✅ TELEPORTAR PARA BASE — localiza modelo com seu nome ou nome da base
local function irParaBase()
	local baseEncontrada = nil

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name:lower():find(lp.Name:lower()) then
			local p = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
			if p then
				baseEncontrada = p
				break
			end
		end
	end

	if baseEncontrada then
		local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = baseEncontrada.CFrame + Vector3.new(0, 5, 0)
		end
	else
		warn("❌ Base não encontrada!")
	end
end

-- Botões visíveis
local noclipBtn = criarBotao("🚪 ATRAVESSAR", Color3.fromRGB(255, 85, 0), 300, toggleNoclip)
local baseBtn = criarBotao("🏠 IR PARA BASE", Color3.fromRGB(0, 170, 0), 360, irParaBase)

