extern "C"
{
  #include <cstdio>
  #include <lua5.1/lua.h>
  #include <lua5.1/lauxlib.h>

  int to_byte(lua_State *L)
  {
    printf("%i", luaL_checkint(L, 1));
    return 1;
  }

  static const struct luaL_Reg functions [] =
  {
    {"to_byte", to_byte},
    {NULL, NULL}
  };

  int luaopen_Binary(lua_State *L)
  {
    luaL_register(L, "Binary", functions);
    return 1;
  }
}
