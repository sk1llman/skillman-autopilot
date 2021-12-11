RegisterCommand("ap", function(source, args, raw)
    local src = source
    TriggerClientEvent("skillman_autopilot:main", src)
end)

RegisterCommand("autopilot", function(source, args, raw)
    local src = source
    TriggerClientEvent("skillman_autopilot:main", src)
end)