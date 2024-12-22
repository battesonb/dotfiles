local ls = require("luasnip")
local extras = require("luasnip.extras")

local env = {
  s = ls.snippet,
  p = extras.partial,
}

return {
  env.s("time", env.p(os.date, "%H:%M")),
  env.s("dtime", env.p(os.date, "%Y-%m-%dT%H:%M:%S+10:00")),
}
