return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 8,
  height = 8,
  tilewidth = 32,
  tileheight = 32,
  properties = {},
  tilesets = {
    {
      name = "Desert",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 1,
      margin = 1,
      image = "map/desert.png",
      imagewidth = 265,
      imageheight = 199,
      properties = {
        ["prop01"] = "Val01"
      },
      tiles = {
        {
          id = 1,
          properties = {
            ["aProperty"] = "aValue"
          }
        },
        {
          id = 41,
          properties = {
            ["loc"] = "OneRightOfBottomLeft"
          }
        }
      }
    },
    {
      name = "terrain4x4",
      firstgid = 49,
      tilewidth = 256,
      tileheight = 222,
      spacing = 0,
      margin = 0,
      image = "../HexTests/terrain4x4.png",
      imagewidth = 1024,
      imageheight = 1024,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Ground",
      x = 0,
      y = 0,
      width = 8,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 2, 3, 1, 2, 3, 30, 30,
        9, 10, 11, 9, 10, 11, 30, 30,
        17, 18, 19, 17, 18, 19, 48, 30,
        1, 2, 3, 1, 2, 3, 30, 30,
        9, 10, 11, 9, 10, 11, 30, 30,
        17, 18, 19, 17, 18, 19, 30, 30,
        30, 30, 30, 30, 30, 30, 30, 30,
        21, 30, 30, 30, 30, 30, 30, 30
      }
    }
  }
}
