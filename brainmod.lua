-- ✅ FARMADOR DE BRAINS - Teleporta VOCÊ até cada Brainrot (funciona 100%)
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Criar GUI simples com botão FARMAR
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local botao = Instance.new("TextButton", gui)

botao.Size = UDim2.new(0, 180, 0, 50)
botao.Position = UDim2.new(0, 15, 0, 300)
botao.Text = "📍 FARMAR"
botao.TextScaled = true
botao.Font = Enum.Font.GothamBold
botao.TextColor3 = Color3.new(1,1,1)
botao.BackgroundColor3 = Color3.fromRGB(255, 85, 0)

-- Função: encontrar todos os Brainrots válidos
local function pegarBrains()
	local lista = {}
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") and v.Name:lower():find("brain") and v:FindFirstChild("HumanoidRootPart") then
			table.insert(lista, v)
		end
	end
	return lista
end

-- Função: encontrar sua base
local function encontrarBase()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj:FindFirstChild("Owner") and obj.Owner.Value == lp then
			return obj
		end
	end
	return nil
end

-- Função: teleportar personagem
local function teleportarPara(pos)
	if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
		lp.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
	end
end

-- Função: FARMAR
local function iniciarFarm()
	botao.Text = "⏳ FARMANDO..."

	local brains = pegarBrains()

	for _, brain in pairs(brains) do
		local part = brain:FindFirstChild("HumanoidRootPart")
		if part then
			teleportarPara(part.Position + Vector3.new(0, 3, 0))
			wait(1.2) -- espera para o server registrar
		end
	end

	-- Volta pra base
	local base = encontrarBase()
	if base then
		local basePos = base:FindFirstChild("HumanoidRootPart") or base:FindFirstChildWhichIsA("BasePart")
		if basePos then
			teleportarPara(basePos.Position + Vector3.new(0, 5, 0))
		end
	end

	botao.Text = "✅ FINALIZADO"
	wait(2)
	botao.Text = "📍 FARMAR"
end

-- Conecta botão
botao.MouseButton1Click:Connect(iniciarFarm)

