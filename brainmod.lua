-- ✅ GUI HACK - Roube um Brainrot | Criado por você ;)

local lp = game.Players.LocalPlayer
local cg = game:GetService("CoreGui")
local rs = game:GetService("RunService")

-- GUI
local ScreenGui = Instance.new("ScreenGui", cg)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 180, 0, 200)
Frame.Position = UDim2.new(0, 10, 0, 250)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

-- Criar botão
local function criarBotao(txt, cor, callback)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, #Frame:GetChildren() * 45)
	btn.BackgroundColor3 = cor
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = txt
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.MouseButton1Click:Connect(callback)
end

-- Função: Encontrar base
local function encontrarBase()
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Model") and v:FindFirstChild("Owner") and v.Owner.Value == lp then
			return v
		end
	end
	return nil
end

-- 🧠 ROUBAR
local function roubarBrains()
	local base = encontrarBase()
	if not base then return end
	local basePos = base:FindFirstChild("HumanoidRootPart") or base:FindFirstChildWhichIsA("BasePart")
	if not basePos then return end

	for _, brain in pairs(workspace:GetDescendants()) do
		if brain:IsA("Model") and brain.Name:lower():find("brain") and brain:FindFirstChild("HumanoidRootPart") then
			brain:MoveTo(basePos.Position + Vector3.new(0, 5, 0))
		end
	end
end

-- 🚀 AUTO-FARM
local autoFarmAtivo = false
local function toggleAutoFarm()
	autoFarmAtivo = not autoFarmAtivo
	while autoFarmAtivo do
		roubarBrains()
		wait(5) -- intervalo em segundos
	end
end

-- 👁️ ESP
local espAtivo = false
local function toggleESP()
	espAtivo = not espAtivo

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name:lower():find("brain") and obj:FindFirstChild("HumanoidRootPart") then
			if espAtivo then
				local bill = Instance.new("BillboardGui", obj.HumanoidRootPart)
				bill.Name = "BrainESP"
				bill.Size = UDim2.new(0, 100, 0, 40)
				bill.AlwaysOnTop = true

				local txt = Instance.new("TextLabel", bill)
				txt.Size = UDim2.new(1, 0, 1, 0)
				txt.Text = "🧠 BRAIN"
				txt.TextScaled = true
				txt.BackgroundTransparency = 1
				txt.TextColor3 = Color3.new(1, 0.4, 0)
			else
				local esp = obj.HumanoidRootPart:FindFirstChild("BrainESP")
				if esp then esp:Destroy() end
			end
		end
	end
end

-- ❌ FECHAR
local function fecharGUI()
	ScreenGui:Destroy()
end

-- Criar os botões
criarBotao("🧠 ROUBAR", Color3.fromRGB(0, 170, 0), roubarBrains)
criarBotao("🚀 AUTO-FARM", Color3.fromRGB(255, 140, 0), toggleAutoFarm)
criarBotao("👁️ ESP", Color3.fromRGB(100, 100, 255), toggleESP)
criarBotao("❌ FECHAR", Color3.fromRGB(170, 0, 0), fecharGUI)
