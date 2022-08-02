local cg = game:GetService("CoreGui")
for i=1,100 do
	print('\n')
end

print('CoreGui Components: \n')

for i, child in pairs(cg:GetChildren()) do
	print(child.Name.." is "..i)
	if child.Name == "test" then
		child:Destroy()
		print("#"..i.." destroyed.\n")
	end
end

local test = Instance.new("ScreenGui")
local top = Instance.new("Frame")
local but = Instance.new("TextButton")

test.Name = "test"
test.Parent = game:GetService("CoreGui")
test.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

top.Name = "top"
top.Parent = test
top.Active = true
top.Draggable = true
top.Selectable = true
top.BackgroundColor3 = Color3.fromRGB(113, 40, 254)
top.BorderSizePixel = 0
top.Position = UDim2.new(0.130303025, 0, 0.225995317, 0)
top.Size = UDim2.new(0, 618, 0, 200)

but.Name = "but"
but.Parent = top
but.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
but.Position = UDim2.new(0.45, 0, 0.3, 0)
but.Size = UDim2.new(0, 60, 0, 60)
but.Font = Enum.Font.SourceSans
but.Text = "Test"
but.TextColor3 = Color3.fromRGB(255, 255, 255)
but.TextSize = 30.000

but.MouseButton1Click:Connect(function()
	print('test button output: hello assholes')
end)
