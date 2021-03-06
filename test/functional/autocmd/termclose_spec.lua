local helpers = require('test.functional.helpers')
local Screen = require('test.functional.ui.screen')

local clear, eval, execute, feed, nvim, nvim_dir = helpers.clear, helpers.eval,
helpers.execute, helpers.feed, helpers.nvim, helpers.nvim_dir
local wait = helpers.wait

describe('TermClose event', function()
  before_each(function()
    clear()
    nvim('set_option', 'shell', nvim_dir .. '/shell-test')
    nvim('set_option', 'shellcmdflag', 'EXE')
    screen = Screen.new(20, 4)
    screen:attach(false)
  end)

  it('works as expected', function()
    execute('autocmd TermClose * echomsg "TermClose works!"')
    execute('terminal')
    feed('<c-\\><c-n>')
    screen:expect([[
      ready $             |
      [Process exited 0]  |
      ^                    |
      TermClose works!    |
    ]])
  end)
end)
