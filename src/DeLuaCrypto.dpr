library DeLuaCrypto;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  Lua in '..\LuaDelphi\Lib\Lua.pas',
  lua52 in '..\LuaDelphi\Lib\lua52.pas',
  LuaLib in '..\LuaDelphi\Lib\LuaLib.pas',
  LuaCrypto in 'LuaCrypto.pas';

{$R *.res}

var
  LuaCrypto: TLuaCrypto;

function libinit (L: Lua_State): Integer; cdecl;export;
begin
  LuaCrypto := TLuaCrypto.Create(false);  // we don't want to register the functions
  LuaCrypto.LuaInstance := L;         // update LuaInstance
  LuaCrypto.AutoRegisterFunctions(LuaCrypto);         // now register the functions
  result := 1;
end;

exports
  libinit;

begin
end.
