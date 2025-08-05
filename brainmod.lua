-- ✅ MOD MENU: atravessar parede + ir pra base | 100% Delta Mobile
local lp = game.Players.LocalPlayer
local cg = game:GetService("CoreGui")
local char = lp.Character or lp.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI base
local gui = Instance.new("ScreenGui", cg)

-- Criador de botões
local function criarBotao(texto, cor, posY, func)
	local btn = Instance.new("TextButton", gui)
	btn.Size = UDim2.new(0, 200, 0, 50)
	btn.Position = UDim2.new(0, 15, 0, posY)
	btn.BackgroundColor3 = cor
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.Text = texto
	btn.MouseButton1Click:Connect(func)
	return btn
end

-- 🚪 Botão: Atravessar parede
local noClip = false
local function ativarNoClip()
	noClip = not noClip
	if noClip then
		gui:FindFirstChild("noclipBtn").Text = "✅ ATRAVESSANDO"
	else
		gui:FindFirstChild("noclipBtn").Text = "🚪 ATRAVESSAR"
	end
end

-- Ativar/desativar colisão em loop
game:GetService("RunService").Stepped:Connect(function()
	if noClip and lp.Character then
		for _, part in pairs(lp.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide == true then
				part.CanCollide = false
			end
		end
	end
end)

-- 🏠 Botão: Ir para base
local function irParaBase()
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") and v:FindFirstChild("Owner") and v.Owner.Value == lp then
			local part = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart")
			if part then
				lp.Character:MoveTo(part.Position + Vector3.new(0, 5, 0))
				break
			end
		end
	end
end

-- Criar botões
local b1 = criarBotao("🚪 ATRAVESSAR", Color3.fromRGB(255, 85, 0), 0.35, ativarNoClip)
b1.Name = "noclipBtn"

local b2 = criarBotao("🏠 IR PARA BASE", Color3.fromRGB(0, 170, 0), 0.45, irParaBase)
