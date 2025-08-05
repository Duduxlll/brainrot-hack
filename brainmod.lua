-- ✅ SCRIPT FINAL – NOCLIP REAL + TELEPORTE FIXO PRA SUA BASE (com GUI)
local lp = game.Players.LocalPlayer
local cg = game:GetService("CoreGui")
local rs = game:GetService("RunService")

-- GUI base
local gui = Instance.new("ScreenGui", cg)
gui.Name = "HackGUI"

-- Criar botão padrão
local function criarBotao(texto, cor, y, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 200, 0, 50)
	b.Position = UDim2.new(0, 20, 0, y)
	b.BackgroundColor3 = cor
	b.TextColor3 = Color3.new(1,1,1)
	b.TextScaled = true
	b.Font = Enum.Font.GothamBold
	b.Text = texto
	b.Parent = gui
	b.MouseButton1Click:Connect(callback)
	return b
end

-- ✅ NOCLIP FIXO E FUNCIONAL
local noclipAtivo = false
local function ativarNoclip()
	noclipAtivo = not noclipAtivo
	noclipBtn.Text = noclipAtivo and "✅ ATRAVESSANDO" or "🚪 ATRAVESSAR"

	if noclipAtivo then
		lp.Character:FindFirstChild("Humanoid").PlatformStand = true
	else
		lp.Character:FindFirstChild("Humanoid").PlatformStand = false
	end
end

-- Física: manter no-clip forçado
rs.Stepped:Connect(function()
	if noclipAtivo and lp.Character then
		for _, part in pairs(lp.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- ✅ TELEPORTAR PARA BASE – busca visual pelo nome da sua base
local function irParaBase()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name:lower():find("duduxlfpsss") then
			local part = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
			if part then
				lp.Character:WaitForChild("HumanoidRootPart").CFrame = part.CFrame + Vector3.new(0, 5, 0)
				break
			end
		end
	end
end

-- Botões
local noclipBtn = criarBotao("🚪 ATRAVESSAR", Color3.fromRGB(255, 85, 0), 300, ativarNoclip)
local baseBtn = criarBotao("🏠 IR PARA BASE", Color3.fromRGB(0, 170, 0), 360, irParaBase)

