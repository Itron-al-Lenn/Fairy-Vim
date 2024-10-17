local M = {}

---Returns the output of a given command
---@param command string
---@return string
M.exec = function(command)
  local f = io.popen(command, 'r')
  local output = f:read '*a'
  f:close()
  return output
end

return M
