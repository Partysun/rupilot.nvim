local curl = require("plenary.curl")
local Input = require("nui.input")
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

RUPILOT_KEY = os.getenv("RUPILOT_KEY") -- get API key from environment variable
if not RUPILOT_KEY then
	error("No API key found")
end

local function fetch_api(search_query, callback)
	local json = { query = search_query, locale = "en" }
	-- how to get api key from config of vim plugin using lazy.nvim
	local headers = {
		["content-type"] = "application/json",
		["Authorization"] = "Bearer sk-" .. RUPILOT_KEY,
	}
	local res = curl.post("https://taz.zatsepin.dev/chat", { body = vim.fn.json_encode(json), headers = headers })

	assert(res.exit == 0 and res.status < 400 and res.status >= 200, "Failed to fetch Rupilot API")
	local body = vim.fn.json_decode(res.body)
	--print("Debug Variable Value: " .. vim.inspect(body))
	if body ~= nil then
		vim.schedule(function()
			callback(body.query)
		end)
	else
		print("Failed to fetch, Response was empty")
	end
end

local Rupilot = {}

Rupilot.getVisualSelection = function()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

Rupilot.setup = function()
	print("Setup Rupilot")

	vim.api.nvim_create_user_command("Rupilot", function(args)
		if args.args ~= nil then
			if string.len(args.args) > 1 then
				Rupilot.open_popup(args.args)
			else
				Rupilot.input()
			end
		else
			Rupilot.input()
		end
	end, { nargs = "?" })

	vim.keymap.set("n", "<leader>aa", function()
		vim.cmd(":Rupilot " .. vim.fn.input("Ваш вопрос к Rupilot? ") .. "<cr>")
	end)

	vim.keymap.set("v", "<leader>ae", function()
		local selectedText = Rupilot.getVisualSelection()
		vim.cmd(
			":Rupilot "
				.. vim.fn.input("Как вам помочь с этим кодом?: ")
				.. selectedText
				.. "<cr>"
		)
	end)
end

Rupilot.input = function()
	local input = Input({
		position = {
			row = "25%",
			col = "50%",
		},
		size = {
			width = "60%",
		},
		border = {
			style = "double",
			text = {
				top = "[Ask Rupilot]",
				top_align = "center",
				bottom = ":help, Question",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		prompt = "> ",
		default_value = "",
		on_close = function() end,
		on_submit = function(value)
			Rupilot.open_popup(value)
		end,
	})

	-- mount/open the component
	input:mount()

	-- unmount component when cursor leaves buffer
	input:on(event.BufLeave, function()
		input:unmount()
	end)
end

-- Pops up a window containing the results of the search
Rupilot.open_popup = function(search_query)
	local popup = Popup({
		enter = true,
		focusable = true,
		border = {
			style = "double",
			text = {
				top = "[Rupilot]",
				top_align = "center",
			},
		},
		position = "50%",
		size = {
			width = "80%",
			height = "60%",
		},
	})

	-- mount/open the component
	popup:mount()

	-- unmount component when cursor leaves buffer
	popup:on(event.BufLeave, function()
		popup:unmount()
	end)

	local function previewer(articles)
		local lines = {}
		for line in articles:gmatch("[^\n]+") do
			local clean = string.gsub(line, "\x1b[.[0-9;]*[mK]", "")
			lines[#lines + 1] = clean
		end
		vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, lines)
		vim.bo.filetype = "python"
	end

	fetch_api(search_query, previewer)
	vim.keymap.set("n", "q", ":q!<cr>", { buffer = true })
end

return Rupilot
