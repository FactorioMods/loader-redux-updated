--[[ Copyright (c) 2017 Optera
 * Part of Loader Redux
 *
 * See LICENSE.md in the project directory for license information.
--]]

data:extend({
  {
    type = "recipe",
    name = "loader",
    enabled = false,
    hidden = false,
    energy_required = 5,
    ingredients = {
      {type="item",name="iron-plate",amount=10},
      {type="item",name="electronic-circuit",amount=10},
      {type="item",name="inserter",amount=5},
      {type="item",name="transport-belt",amount=5},
    },
    results = {{type="item",name="loader",amount=1}}
  },
  {
    type = "recipe",
    name = "fast-loader",
    enabled = false,
    hidden = false,
    energy_required = 5,
    ingredients = {
      {type="item",name="iron-gear-wheel",amount=20},
      {type="item",name="electronic-circuit",amount=20},
      {type="item",name="advanced-circuit",amount=1},
      {type="item",name="loader",amount=1},
    },
    results = {{type="item",name="fast-loader",amount=1}}
  },
  {
    type = "recipe",
    name = "express-loader",
    categories = {"crafting-with-fluid"},
    enabled = false,
    hidden = false,
    energy_required = 5,
    ingredients = {
      {type="item",name="iron-gear-wheel",amount=20},
      {type="item",name="advanced-circuit",amount=20},
      {type="item",name="fast-loader",amount=1},
      {type="fluid", name="lubricant", amount=80},
    },
    results = {{type="item",name="express-loader",amount=1}}
  },
})

