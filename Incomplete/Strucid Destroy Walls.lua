if getgenv().destroy then setting.destroy = false end -- Prevent crashes from using this to much

getgenv().settings = {
    destroy = true --// Destroy?
}

while wait() and settings.destroy do
    pcall(function()
        workspace.BuildStuff:ClearAllChildren''
    end)
end