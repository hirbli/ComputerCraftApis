fs={}

function fs.list(dir)
  return {"autotable", "dispatcher", "event", "gpsplus", "minet", "persistency", "serializer", "table", "timer", "turtleplus", "routingtable", "turtlesensor", "transformation", "array"}
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

turtle={}

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

loadApi("loader", "rom/apis/loader")
loadApi("lunit", "rom/apis/lunit")
loadApi("vector", "rom/apis/vector")
loader.initializeApis()
lunit.run()
