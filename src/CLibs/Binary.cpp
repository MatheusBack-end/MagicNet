#include <bitset>
#include <iostream>
#include <vector>

extern "C"
{
  #include <cstdio>
  #include <lua5.1/lua.h>
  #include <lua5.1/lauxlib.h>

  std::vector<unsigned char> buffer;

  int allocate(lua_State *L)
  {
    buffer.resize(luaL_checkint(L, 1));
    std::cout << buffer.size() << "\n"; 
    return 1;
  }

  int to_byte(lua_State *L)
  {
    unsigned char value = 42;
    unsigned char result = (value & 1) << 7;

    std::cout << std::bitset<8>(result) << "\n";
    std::cout << std::bitset<8>(value) << "\n";
    return 1;
  }

  static const struct luaL_Reg functions [] =
  {
    {"allocate", allocate},
    {"to_byte", to_byte},
    {NULL, NULL}
  };

  int luaopen_Binary(lua_State *L)
  {
    luaL_register(L, "Binary", functions);
    return 1;
  }
}
