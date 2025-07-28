local actions = {
  ["Generate PDF"] = require('config.tla.actions.generate_pdf'),
  ["Evaluate expression"] = require('config.tla.actions.evaluate_expression'),
  ["Parse"] = require('config.tla.actions.parse'),
  ["Check"] = require('config.tla.actions.check'),
}

return actions
