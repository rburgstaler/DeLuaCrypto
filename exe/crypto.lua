crypto = {}

LuaDelphi = package.loadlib("DeLuaCrypto.dll","libinit")
LuaDelphi();

function crypto.digest(digtype, str)
	return digest(digtype, str);
end

return crypto