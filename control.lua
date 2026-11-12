local legacy_import=require("legacy_import")
--[[ Copyright (c) 2017 Optera
 * Part of Loader Redux
 *
 * See LICENSE.md in the project directory for license information.
--]]

-- http://lua-api.factorio.com/latest/events.html#on_entity_settings_pasted
-- http://lua-api.factorio.com/0.15.2/LuaEntity.html#LuaEntity.filter_slot_count
-- http://lua-api.factorio.com/0.15.2/LuaEntity.html#LuaEntity.get_filter
-- https://forums.factorio.com/viewtopic.php?p=579807#p579807

local snapping = require("script.snapping")

local use_snapping = settings.global["loader-snapping"].value

-- local supported_loaders = {} -- dictionary indexed by supported entity name
-- local supported_loader_names = {}  -- list of loader names for find_entities_filtered

-- remote interface to add and remove loaders from whitelist
remote.add_interface("loader-redux",  {
  -- add loader name if it doesn't already exist
  add_loader = function(name)
    if name then
      storage.supported_loaders = storage.supported_loaders or {} -- allows on_init of API subscribers be called before on_configuration_changed resets everything
      storage.supported_loaders[name] = true
      storage.supported_loader_names = {}
      for k, v in pairs(storage.supported_loaders) do
        table.insert(storage.supported_loader_names, k)
      end
      log("storage.supported_loaders: "..serpent.block(storage.supported_loaders) )
    end
  end,

  -- remove loader name
  remove_loader = function(name)
    if name then
      storage.supported_loaders = storage.supported_loaders or {} -- allows on_init of API subscribers be called before on_configuration_changed resets everything
      storage.supported_loaders[name] = nil
      storage.supported_loader_names = {}
      for k, v in pairs(storage.supported_loaders) do
        table.insert(storage.supported_loader_names, k)
      end
      log("storage.supported_loaders: "..serpent.block(storage.supported_loaders) )
    end
  end
})

--Check for loaders around rotated entities that may need snapping
script.on_event(defines.events.on_player_rotated_entity, function(event)
  if use_snapping then
    snapping.check_for_loaders(event)
  end
end)

--Snap loaders on built or correct existing loaders when building next to them.
script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity}, function(event)
  local entity = event.entity
  if entity.type == "loader" and storage.supported_loaders[entity.name] then
    if use_snapping then
      snapping.snap_loader(entity, event)
    end
  elseif use_snapping then
    snapping.check_for_loaders(event)
  end
end)

-- update mod runtime settings
-- change event subscriptions and initialize wagon-loader pairs as needed
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  if event.setting == "loader-snapping" then
    use_snapping = settings.global["loader-snapping"].value
  end
end)


---- Bootstrap ----

function init_supported_loaders()
  storage.supported_loaders = {} -- clean old prototype names, API subscribers should be called afterwards
  remote.call("loader-redux", "add_loader", "loader")
  remote.call("loader-redux", "add_loader", "fast-loader")
  remote.call("loader-redux", "add_loader", "express-loader")
end

-- On first install scan the map and find any loaders that might need work!
script.on_init(function()
  if legacy_import.adopt("LoaderRedux") then return end
  init_supported_loaders()
end)

-- rescan all loader-wagon connections in case changing mods removed some wagons
script.on_configuration_changed(function(data)
  legacy_import.adopt("LoaderRedux")
  init_supported_loaders()
  -- wipe unused globals
  storage.wagons = nil
  storage.loader_wagon_map = nil
end)
