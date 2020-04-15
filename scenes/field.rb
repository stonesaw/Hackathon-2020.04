class Field
  def initialize
    @@d_castle = Map.new(width: 20, height: 20, default_text:"・")
    @@d_jie = Map.new(width: 20, height: 20, default_text:"・")
    @@dis_flag = 0
    @@king = Sprite.new(9, 6, "王")
    @@maou = Sprite.new(10, 19, "魔")
    @@player = Sprite.new(9, 9, "〇")
    @@castle = Sprite.new(10, 0, "城")
    @@hotel = Sprite.new(0, 0, "宿")
    @@shop = Sprite.new(19, 0, "店")
    @@wall = []
    @@d_castle.width.times do |i|
      @@wall << Sprite.new(i, 0, "■")
      if i != 9 && i != 10
        @@wall << Sprite.new(i, 19, "■")
      end
    end
    @@d_castle.height.times do |i|
      @@wall << Sprite.new(0, i, "■")
      @@wall << Sprite.new(19, i, "■")
    end
    @@mienai = []
    @@d_jie.width.times do |i|
      @@mienai << Sprite.new(i, -1, "■")
      @@mienai << Sprite.new(i, 20, "■")
    end
    @@d_jie.height.times do |i|
      @@mienai << Sprite.new(-1, i, "■")
      @@mienai << Sprite.new(20, i, "■")
    end
  end

  class << self
    def update
      system("cls")
      Scene.next if Key.down?(Key::RETURN)
      Scene.back if Key.down?(Key::ESCAPE)

      if @@dis_flag == 0
        @@player.x += 1 if Key.down?(Key::RIGHT) && !(@@player.touch_right([@@king] + @@wall))
        @@player.x -= 1 if Key.down?(Key::LEFT) && !(@@player.touch_left([@@king] + @@wall))
        @@player.y += 1 if Key.down?(Key::DOWN) && !(@@player.touch_foot([@@king] + @@wall))
        @@player.y -= 1 if Key.down?(Key::UP) && !(@@player.touch_head([@@king] + @@wall))
      else
        @@player.x += 1 if Key.down?(Key::RIGHT)  && !(@@player.touch_right([@@maou, @@hotel] + @@mienai))
        @@player.x -= 1 if Key.down?(Key::LEFT) && !(@@player.touch_left([@@maou, @@hotel] + @@mienai))
        @@player.y += 1 if Key.down?(Key::DOWN) && !(@@player.touch_foot([@@maou, @@hotel] + @@mienai))
        @@player.y -= 1 if Key.down?(Key::UP) && !(@@player.touch_head([@@maou, @@hotel] + @@mienai))
      end

      if @@dis_flag == 0 && @@player.y == 20
        @@dis_flag = 1
        @@player.x = @@castle.x
        @@player.y = @@castle.y + 1
      end

      if @@dis_flag == 1 && @@player.x == @@castle.x && @@player.y == @@castle.y
        @@dis_flag = 0
        @@player.x = 9
        @@player.y = 19
      end

      if @@dis_flag == 1 && @@player.x == @@shop.x && @@player.y == @@shop.y
        @@player.x = @@shop.x - 1
        Scene.next
        Scene.next(init: true)
      end
    end

    def draw
      if @@dis_flag == 0
        @@d_castle.draw([@@king, @@wall, @@player])
      else
        @@d_jie.draw([@@player, @@castle, @@maou, @@hotel, @@shop])
      end
    end
  end
end