function PromptForDatabaseConnection()
    local user = vim.fn.input('Enter the database username: ')
    local password = vim.fn.input('Enter the database password: ')
    local host = vim.fn.input('Enter the database host: ')
    local port = vim.fn.input('Enter port number: ')
    local database = vim.fn.input('Enter the database name: ')

    -- Construct the connection URI with the provided port
    local connection_uri = user .. ':' .. password .. '@' .. host .. ':' .. port .. '/' .. database

    -- Store the connection URI in a global variable for later use
    vim.g.database_connection_uri = connection_uri

    print('Database connection details saved.')
    print(connection_uri)
end

-- Call the function to prompt for database connection details
PromptForDatabaseConnection()

-- Set the default profile for dadbod
vim.g.dbext_default_profile_mysql = 'mariadb'

-- Define a key mapping that uses variables in the command
vim.api.nvim_set_keymap('x', '<leader>ss', [[:DB mysql://]] .. vim.g.database_connection_uri, { noremap = true })
