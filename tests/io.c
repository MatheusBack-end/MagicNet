#include <unistd.h>
#include <fcntl.h>
#include <lua5.1/lua.h>
#include <lua5.1/lauxlib.h>

int read_non_blocking(lua_State *L)
{
  char buffer[3];

  memset(buffer, 0, sizeof(buffer));

  fcntl(0, F_SETFL, fcntl(0, F_GETFL) | O_NONBLOCK);
  int ready = read(0, buffer, 3);

  if(ready > 0)
  {
    lua_pushstring(L, buffer);
  }

  else
  {
    lua_pushnil(L);
  }

  return 1;
}

static const struct luaL_Reg functions [] =
{
  {"read_nb", read_non_blocking},
  {NULL, NULL}
};

int luaopen_ioutil(lua_State *L)
{
  luaL_register(L, "ioutil", functions);
  return 1;
}
