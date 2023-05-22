local status_ok, abbrevman = pcall(require, "abbrev-man")
if not status_ok then
  print 'AbbrevMan not loaded'
	return
end

abbrevman.setup {
  natural_dictionaries = {
    ["nt_co_authored_by"] = {
      ["cabjim"] = "co-authored-by: james grundner <james.grundner@ryansg.com>",
      ["cabjf"] = "co-authored-by: joseph frazer <joseph.frazer@ryansg.com>",
      ["cabmg"] = "co-authored-by: mark goldsmith <mark.goldsmith@ryansg.com>",
      ["cabss"] = "co-authored-by: shelly shaver <shelly.shaver@ryansg.com>",
      ["cabae"] = "co-authored-by: andrew elbaneh <andrew.elbaneh@ryansg.com>",
      ["cabcv"] = "co-authored-by: corey vollmer <corey.vollmer@ryansg.com>",
      ["cabrn"] = "co-authored-by: raymond nagel <raymond.nagel@ryansg.com>",
      ["cabad"] = "co-authored-by: anthony dalfonso <anthony.dalfonso@ryansg.com>",
      ["cabrh"] = "co-authored-by: ronnie herbine <veronica.herbine@ryansg.com>",
      ["cabtq"] = "co-authored-by: thomas quiring <thomas.quiring@ryansg.com>",
      ["cabme"] = "co-authored-by: matt edgar <matthew.edgar@rtspecialty.com>",
    }
  },
}
