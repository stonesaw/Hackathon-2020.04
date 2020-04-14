class Field
  def initialize
    @@display = Map.new(width: 20, height: 20, default_text:"・")
    @@king = Sprite.new(9, 6, "王")
    @@player = Sprite.new(9, 9, "〇")
    @@wall = []
    @@display.width.times do |i|
      @@wall << Sprite.new(i, 0, "■")
      if i != 9 && i != 10
        @@wall << Sprite.new(i, 19, "■")
      end
    end
    @@display.height.times do |i|
      @@wall << Sprite.new(0, i, "■")
      @@wall << Sprite.new(19, i, "■")
    end

  end

  class << self
    def update
      system("cls")
      Scene.next if Key.down?(Key::RETURN)
      Scene.back if Key.down?(Key::ESCAPE)

      @@player.x += 1 if Key.down?(Key::RIGHT) && !(@@player.touch_right(@@king)) && !(@@player.touch_right(@@wall))
      @@player.x -= 1 if Key.down?(Key::LEFT) && !(@@player.touch_left(@@king)) && !(@@player.touch_left(@@wall))
      @@player.y += 1 if Key.down?(Key::DOWN) && !(@@player.touch_foot(@@king)) && !(@@player.touch_foot(@@wall))
      @@player.y -= 1 if Key.down?(Key::UP) && !(@@player.touch_head(@@king)) && !(@@player.touch_head(@@wall))
    end

    def draw
      @@display.draw([@@king, @@wall, @@player])
    end
  end
end
    