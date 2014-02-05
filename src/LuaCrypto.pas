unit LuaCrypto;

interface

{$I luadefine.inc}
uses
  Lua, SysUtils, {$IFNDEF LUA52}LuaLib{$ELSE}Lua52{$ENDIF};

type
  TLuaCrypto = class(TLua)
  published
    {published properties}
    function digest(LuaState: TLuaState): Integer;
  end;

implementation

uses
  IdHashMessageDigest, idHash, System.IOUtils;

{ TLuaCrypto }

function MD5(const Str : String) : string;
var
  idmd5 : TIdHashMessageDigest5;
  hash : T4x4LongWordRecord;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    Result:=idmd5.HashStringAsHex(Str, TEncoding.ANSI)
  finally
    idmd5.Free;
  end;
end;

function TLuaCrypto.digest(LuaState: TLuaState): Integer;
var
  lStr: AnsiString;
  ArgCount: Integer;
begin
  ArgCount := Lua_GetTop(LuaState);

  lStr:=Lua_ToString(LuaState, 2);
  lStr:=LowerCase(MD5(lStr));
  // Clear stack
  Lua_Pop(LuaState, Lua_GetTop(LuaState));

  lua_pushlstring(LuaState, PAnsiChar(lStr), Length(lStr));
  Result:=1;
end;

end.
