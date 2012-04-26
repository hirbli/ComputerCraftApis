fs={}

function fs.list(dir)
  local files={}
  for file in io.popen("ls '"..dir.."'"):lines() do
    table.insert(files, file)
  end
  return files
end
function fs.combine(a, b)
  return a.."/"..b
end
function fs.isDir(a)
  return false
end
function fs.exists(a)
  return false
end
function fs.makeDir(a)
end

function os.getComputerID()
  return 3
end
local tid=0
function os.startTimer()
  tid=tid+1
  return tid
end
function os.setAlarm()
  tid=tid+1
  return tid
end

rednet={}
function rednet.send()
end
function rednet.broadcast()
end

peripheral={}
function peripheral.getType() return nil end

turtle={}
function turtle.up() return true end
function turtle.down() return true end
function turtle.turnLeft() return true end
function turtle.turnRight() return true end
function turtle.forward() return true end

local function loadApiFromFile(name, path)
  local env = setmetatable({}, {__index = _G})
  local func, parseError = loadfile(path)
  if not func then error(parseError) end
  setfenv(func, env)
  local result = func()
  if result==nil then return env
  elseif result==false then return nil end
  error("Unexpected return value from API "..name)
end

local function loadApi(name, path)
  local env = loadApiFromFile(name, path)
  local api={}
  for k,v in pairs(env) do
    api[k] = v
  end
  _G[name] = api
end

print("load basics")
loadApi("loader", "rom/apis/loader")
loadApi("lunit", "rom/apis/lunit")
loadApi("vector", "rom/apis/vector")
print("initialize APIs")
loader.initializeApis()
print("running unit tests")
lunit.run()
