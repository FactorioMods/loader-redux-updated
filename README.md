# Loader Redux: Updated
Adds Loaders.
Rewritten add-loader with new loader snapping logic.
Graphics from Arch666Angel and Kirazy.

This Factorio 2.1.24 port retains the three 1×2 loader tiers, belt snapping, native rail interaction and original item, recipe and technology names. It adopts original Loader Redux state.

Original project: [LoaderRedux](https://mods.factorio.com/mod/LoaderRedux) — Optera; graphics credits from Arch666Angel and Kirazy are retained above. [Original source](https://github.com/0ptera/Loader-Redux). [Updated Mod Portal page](https://mods.factorio.com/mod/loader-redux-updated) · [Fork source](https://github.com/FactorioMods/loader-redux-updated).

# API Data Stage
required to use make_loader function with 1.8.0
```lua
local loader_redux = require("__loader-redux-updated__.make_loader")
```

create loader item
```lua
loader_redux.make_loader_item(name, subgroup, order, tint)
-- @tparam String name
-- @tparam String subgroup
-- @tparam String order
-- @tparam Types.Color[] tint
```

create loader entity
```lua
loader_redux.make_loader_entity(name, belt, tint, next_upgrade)
-- @tparam String name
-- @tparam Prototype.TransportBelt[] belt
-- @tparam Types.Color[] tint
-- @tparam String|nil next_upgrade
```

# API Control Stage
register loader for snapping and train interaction in on_init and on_configuration_changed.<br>
Do not call from on_load.
```lua
remote.call("loader-redux", "add_loader", name)
-- @tparam String name
```

unregister loader for snapping and train interaction in on_init and on_configuration_changed.<br>
Do not call from on_load.
```lua
remote.call("loader-redux", "remove_loader", name)
-- @tparam String name
```
