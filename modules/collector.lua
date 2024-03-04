local Collector = {}

local Timer = require('core/timer')
local Util = require('core/util')
local FileHandler = require('core/fileHandler')

local me = peripheral.wrap('top')
local basePath = 'MEC/data/'
local trackingList = {
  'Dust', 'Ingot', 'Diamond', 'Nugget', 'Essence',
  'Water', 'Liquid Lithium', 'Liquid Ethylene', 'Latex', 'Lava', 'Oxygen Gas', 'Heavy Water', 'Milk', 'Glue', 'Liquid Rubber',
  'Deuterium', 'Plutonium', 'Fissile Fuel', 'Tritium', 'Hydrogen', 'Oxygen', 'Polonium','Nuclear Waste'
}

function createMeData(itemList)
  local meData = {}
  for _,itemEntry in ipairs(itemList) do
    local addItem = false
    for _,trackMe in ipairs(trackingList) do
      if Util.stringContains(itemEntry.displayName,trackMe) then
        addItem = true
        if trackMe == 'Diamond' then
          if not trackMe == itemEntry.displayName then
            addItem = false
          end
        end
      end
    end
    if addItem then 
      local entry = createItemEntry(itemEntry.displayName,itemEntry.amount)
      table.insert(meData,entry)
    end
  end
  return meData
end

function createItemEntry(name,amount)
  local entry = {
    name = name,
    stamps = {}
  }
  table.insert(entry.stamps,createStamp(amount))
  return entry
end

function createStamp(amount)
  local stamp = {
    timestamp = Timer.getStamp(),
    amount = amount
  }
  return stamp
end

function mergeStamps(mec,me)
  for k,v in ipairs(me) do
    table.insert(mec,v)
  end
  return mec
end

function mergeData(meData,mecData)
  local newItemCounter = 0
  local processedItems = 0
  for _,meItem in ipairs(meData) do
    local foundInMEC = false
    for _,mecItem in ipairs(mecData) do
      if mecItem.name == meItem.name then
        foundInMEC = true
        mecItem.stamps = mergeStamps(mecItem.stamps, meItem.stamps)
        processedItems = processedItems + 1
        break
      end
    end
    if not foundInMEC then
      newItemCounter = newItemCounter + 1
      processedItems = processedItems + 1
      table.insert(mecData,createItemEntry(meItem.name,meItem.amount))
    end
  end
  return mecData, newItemCounter, processedItems
end

function Collector.collect()
  local meItems = {
    {
      name = 'items',
      list = me.listItems()
    },
    {
      name = 'liquids',
      list = me.listFluid()
    },
    {
      name = 'gases',
      list = me.listGas()
    }
  }
  for _, meType in ipairs(meItems) do
    --print('Collecting '..meType.name..' data')
    local totalProcessItems = 0
    local totalNewItems = 0

    if fs.exists(basePath..'mec_'..meType.name) then
      --print('Updating existing'..meType.name..' data')
      local meData = createMeData(meType.list)
      local mecData = FileHandler.readDataFromFile(basePath .. 'mec_' .. meType.name)
      local mergedData, totalNewItems, totalProcessItems = mergeData(meData,mecData)
      FileHandler.writeDataToFile(basePath..'mec_'..meType.name,mergedData)
    else
      --print('No existing '..meType.name..' data found. Creating initial '..meType.name..' data.')
      local initialData = createMeData(meType.list)
      FileHandler.writeDataToFile(basePath..'mec_'..meType.name,initialData)
      totalProcessItems = #initialData
      totalNewItems = #initialData
    end
    --print('Finished collection '..meType.name..' data.')
    --print('Processed '..totalProcessItems..' items.')
    --print('Including '..totalNewItems..' items.')
    --print('==================================================')
  end
end

return Collector