local ls = require("luasnip")
local extras = require("luasnip.extras")

local env = {
  s = ls.snippet,
  p = extras.partial,
}

return {
  env.s("dtime", env.p(os.date, "%Y-%m-%dT%H:%M:%S")),
  env.s("epoch", env.p(os.date, "%s")),
}
