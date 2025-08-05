-- ✅ CORRIGIDO: GUI com atravessar parede + ir pra base
local lp = game.Players.LocalPlayer
local cg = game:GetService("CoreGui")
local rs = game:GetService("RunService")

-- Criar GUI base
local gui = Instance.new("ScreenGui", cg)
gui.Name = "BrainHackGUI"

-- Criador de botões
local function criarBotao(texto, cor, posY, callback)
	local botao = Instance.new("TextButton")
	botao.Size = UDim2.new(0, 200, 0, 50)
	botao.Position = UDim2.new(0, 15, 0, posY)
	botao.BackgroundColor3 = cor
	botao.TextColor3 = Color3.new(1, 1, 1)
	botao.TextScaled = true
	botao.Font = Enum.Font.GothamBold
	botao.Text = texto
	botao.Parent = gui
	botao.MouseButton1Click:Connect(callback)
	return botao
end

-- 🟠 ATRAVESSAR PAREDE (noclip)
local noclipAtivo = false
local function toggleNoclip()
	noclipAtivo = not noclipAtivo
	noclipBotao.Text = noclipAtivo and "✅ ATRAVESSANDO" or "🚪 ATRAVESSAR"
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

-- 🟢 IR PARA BASE
local function irParaBase()
	for _, model in pairs(workspace:GetDescendants()) do
		if model:IsA("Model") and model:FindFirstChild("Owner") and model.Owner.Value == lp then
			local pos = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
			if pos then
				lp.Character:WaitForChild("HumanoidRootPart").CFrame = pos.CFrame + Vector3.new(0, 5, 0)
				return
			end
		end
	end
end

-- Criar botões
local noclipBotao = criarBotao("🚪 ATRAVESSAR", Color3.fromRGB(255, 85, 0), 300, toggleNoclip)
local baseBotao = criarBotao("🏠 IR PARA BASE", Color3.fromRGB(0, 170, 0), 360, irParaBase)
