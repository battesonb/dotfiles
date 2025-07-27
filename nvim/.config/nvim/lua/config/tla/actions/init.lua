local actions = {
  ["Generate PDF"] = require('config.tla.actions.generate_pdf'),
  ["Parse"] = require('config.tla.actions.parse'),
  ["Check"] = require('config.tla.actions.check'),
}

return actions
