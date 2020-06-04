local function GetIdentifiers(source)
    local identifiers = {}
    local playerIdentifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(playerIdentifiers) do
        local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
        identifiers[before] = playerIdentifiers[_]
    end
    return identifiers
end

RegisterServerEvent('handler:savePosition')
AddEventHandler('handler:savePosition', function(Position)
    local source = source
    local identifier = GetIdentifiers(source).steam

            MySQL.Async.execute('UPDATE users SET position=@position WHERE is_active=1 AND identifier=@identifier', {
                ['@position'] = json.encode(Position),
                ['@identifier'] = identifier,
            })

end)