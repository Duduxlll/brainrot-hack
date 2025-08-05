-- ✅ MOD FINALIZADO – GUI bonita, fly, speed, noclip, base
local lp = game.Players.LocalPlayer
local cg = game:GetService("CoreGui")
local rs = game:GetService("RunService")

-- Criar GUI base
local gui = Instance.new("ScreenGui", cg)
gui.Name = "ModMenu"

-- Janela arrastável
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 360)
frame.Position = UDim2.new(0, 20, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Título
local titulo = Instance.new("TextLabel", frame)
titulo.Size = UDim2.new(1, 0, 0, 40)
titulo.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
titulo.Text = "🔧 MOD MENU"
titulo.TextColor3 = Color3.new(1, 1, 1)
titulo.TextScaled = true
titulo.Font = Enum.Font.GothamBold

-- Criar botões
local function criarBotao(nome, cor, ordem, callback)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(1, -20, 0, 40)
	b.Position = UDim2.new(0, 10, 0, 45 + (ordem - 1) * 45)
	b.BackgroundColor3 = cor
	b.TextColor3 = Color3.new(1, 1, 1)
	b.TextScaled = true
	b.Font = Enum.Font.GothamBold
	b.Text = nome
	b.MouseButton1Click:Connect(callback)
end

-- ✅ NOCLIP
local noclip = false
local function toggleNoclip()
	noclip = not noclip
end
rs.Stepped:Connect(function()
	if noclip and lp.Character then
		for _, part in pairs(lp.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- ✅ FLY
local flyAtivo = false
local bv = nil
local function toggleFly()
	if flyAtivo then
		if bv then bv:Destroy() end
		lp.Character.Humanoid.PlatformStand = false
		flyAtivo = false
	else
		local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			bv = Instance.new("BodyVelocity", hrp)
			bv.Velocity = Vector3.new(0, 0, 0)
			bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
			lp.Character.Humanoid.PlatformStand = true
			flyAtivo = true

			rs.RenderStepped:Connect(function()
				if flyAtivo and bv and hrp then
					local dir = Vector3.new()
					if lp:GetMouse().KeyDown("w") then dir = dir + Vector3.new(0, 0, -1) end
					if lp:GetMouse().KeyDown("s") then dir = dir + Vector3.new(0, 0, 1) end
					if lp:GetMouse().KeyDown("a") then dir = dir + Vector3.new(-1, 0, 0) end
					if lp:GetMouse().KeyDown("d") then dir = dir + Vector3.new(1, 0, 0) end
					bv.Velocity = workspace.CurrentCamera.CFrame:VectorToWorldSpace(dir * 60)
				end
			end)
		end
	end
end

-- ✅ SPEED
local function setSpeed(mult)
	local hum = lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid")
	if hum then hum.WalkSpeed = 16 * mult end
end

-- ✅ TELEPORTAR PARA BASE
local function irParaBase()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj:FindFirstChild("Owner") and obj.Owner.Value == lp then
			local p = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
			if p then
				lp.Character:WaitForChild("HumanoidRootPart").CFrame = p.CFrame + Vector3.new(0, 5, 0)
				return
			end
		end
	end
	warn("❌ Base não encontrada.")
end

-- Criar botões no frame
criarBotao("🚪 ATRAVESSAR", Color3.fromRGB(255, 85, 0), 1, toggleNoclip)
criarBotao("🛸 VOAR", Color3.fromRGB(200, 100, 255), 2, toggleFly)
criarBotao("🏠 IR PRA BASE", Color3.fromRGB(0, 170, 0), 3, irParaBase)
criarBotao("💨 SPEED x2", Color3.fromRGB(50, 150, 255), 4, function() setSpeed(2) end)
criarBotao("💨 SPEED x4", Color3.fromRGB(50, 150, 255), 5, function() setSpeed(4) end)
criarBotao("💨 SPEED x8", Color3.fromRGB(50, 150, 255), 6, function() setSpeed(8) end)
criarBotao("💨 SPEED x16", Color3.fromRGB(50, 150, 255), 7, function() setSpeed(16) end)

