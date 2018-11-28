local spammerNames = {
    ["Playermyrealm"]           = true,
    ["Someplayer-Somerealm"]    = true,
    ["Anotherone-Anotherrealm"] = true,
}

-- create a hook to the function that sorts the search results, so we can modify the result
-- list before it is displayed in the user interface
hooksecurefunc("LFGListUtil_SortSearchResults", function (results)
    -- loop backwards through the results list so we can remove elements from the table
    for i = #results, 1, -1 do
        -- get information about the current result entry
        local id, activity, name, comment, voiceChat, iLvl, honorLevel, age,
              numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName,
              numMembers, isAutoAccept, questID = C_LFGList.GetSearchResultInfo(results[i])
        -- if the leader's name is loaded (can be nil for brand-new groups) and
        -- the name is within the spammer list, remove it from the search results
        if leaderName and spammerNames[leaderName] then
        	--print("Removing group with leader " .. leaderName)
            table.remove(results, i)
        end
    end
    -- update the totalResult size (important if we removed all result entries)
    LFGListFrame.SearchPanel.totalResults = #results
end)
