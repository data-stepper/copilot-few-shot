-- plugin.lua
-- Main plugin file

local function load_tasks()
    -- Load the tasks from the examples directory

    -- Load the filenames from the examples directory
    local filenames = {}
    for filename in io.popen('ls examples/'):lines() do
        table.insert(filenames, filename)
    end

    -- Load the tasks from the filenames
    local tasks = {}
    for _, filename in pairs(filenames) do
        local file = io.open('examples/' .. filename, 'r')
        local task = {}
        for line in file:lines() do
            table.insert(task, line)
        end
        table.insert(tasks, task)
    end

    return tasks
end

local tasks = load_tasks()

function FewShotList()
    -- Lists the available tasks.

    for i, task in pairs(tasks) do
        print(i .. ': ' .. task[1])
    end
end

function FewShotOpen(task)
    -- Opens the task examples in a new buffer.

    if task < 1 or task > #tasks then
        error('Invalid task')
    end

    -- Open a new buffer
    vim.api.nvim_command('enew')

    -- Insert the task examples
    for i, line in pairs(tasks[task]) do
        if i < #tasks[task] then
            vim.api.nvim_buf_set_lines(0, i - 1, i, false, {line})
        else
            -- The last line is the prompt
            vim.api.nvim_buf_set_lines(0, i - 1, i, false, {line .. '_'})
        end
    end
end

function setup()
    -- Set up the plugin
end
