if not nn then require 'nn' end
if not dpnn then require 'dpnn' end

nnname = {
  version = 1,
}

-- find a module by its name
function nn.Module:find(name, last)
    local modules = self:findAll(name)
    return last and modules[#modules] or modules[1]
end

-- find all module by its name
function nn.Module:findAll(name)
    local modules = {}
    for i, m in ipairs(self:listModules()) do
        if m.name == name then
            table.insert(modules, m)
        end
    end
    return modules
end

-- set the name of a module
function nn.Module:setName(name)
    self.name = name
    return self
end

-- show name when printing the module
for k, v in pairs(nn) do
    if torch.isTypeOf(v, 'nn.Module') then
        if v.__tostring__ then
            local oldtostring = v.__tostring__
            v.__tostring__ = function(self)
                return (self.name and '[' .. self.name .. '] ' or '') .. oldtostring(self)
            end
        elseif v.__tostring then
            local oldtostring = v.__tostring
            v.__tostring = function(self)
                return (self.name and '[' .. self.name .. '] ' or '') .. oldtostring(self)
            end
        end
    end
end

-- dealing with cudnn.torch modules
if cudnn then
    for k, v in pairs(cudnn) do
        if torch.isTypeOf(v, 'nn.Module') then
            if v.__tostring then
                local oldtostring = v.__tostring
                v.__tostring = function(self)
                    local name = (self.name and '[' .. self.name .. '] ' or '')
                    local old = oldtostring(self)
                    return stringx.startswith(old, name) and old or name .. old
                end
            end
        end
    end
end
