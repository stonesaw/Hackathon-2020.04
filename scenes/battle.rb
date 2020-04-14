class Battle
  def initialize
    @@display = Map.new(map: [
      [3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,8],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,6]
    ], text_hash: {0 => "  ", 1 => "━━", 2 => "┃", 
        3 => "┏", 4 => "┓", 5 => "┗", 6 => "┛", 7 => "┣", 8 => "┫"}
    )
    @@com_attack = Sprite.new(2, 16, "○  攻撃")
    @@com_greet = Sprite.new(2, 17, "    あいさつ")
    @@com_item = Sprite.new(10, 16, "    アイテム")
    @@com_escape = Sprite.new(10, 17, "    逃げる")
    @@enemy_name = "スライム"
    @@msg_attack1 = Sprite.new(2, 15, "text")
    @@msg_attack2 = Sprite.new(2, 15, "text")
    @@cursor = 0
    @@drawed = []
  end

  class << self
    def update
      system("cls")
      Scene.back if Key.down?(Key::ESCAPE)

      if Key.down?(Key::UP) && (@@cursor % 10) == 1
        @@cursor -= 1
      elsif Key.down?(Key::DOWN) && (@@cursor % 10) == 0
        @@cursor += 1
      elsif Key.down?(Key::RIGHT) && @@cursor < 10
        @@cursor += 10
      elsif Key.down?(Key::LEFT) && @@cursor >= 10
        @@cursor -= 10
      end

      @@drawed = [@@com_attack, @@com_greet, @@com_item, @@com_escape]

      if @@cursor == 0
        self.attack if Key.down?(Key::RETURN)
        @@com_attack.text = "○  攻撃"
        @@com_greet.text = "    あいさつ"
        @@com_item.text = "    アイテム"
        @@com_escape.text = "    逃げる"
      elsif @@cursor == 1
        self.greet if Key.down?(Key::RETURN)
        @@com_attack.text = "    攻撃"
        @@com_greet.text = "○  あいさつ"
        @@com_item.text = "    アイテム"
        @@com_escape.text = "    逃げる"
      elsif @@cursor == 10
        self.item if Key.down?(Key::RETURN)
        @@com_attack.text = "    攻撃"
        @@com_greet.text = "    あいさつ"
        @@com_item.text = "○  アイテム"
        @@com_escape.text = "    逃げる"
      elsif @@cursor == 11
        self.escape if Key.down?(Key::RETURN)
        @@com_attack.text = "    攻撃"
        @@com_greet.text = "    あいさつ"
        @@com_item.text = "    アイテム"
        @@com_escape.text = "○  逃げる"
      end
    end

    def draw
      @@display.draw(@@drawed)
      puts @@cursor
    end

    def attack
      puts "attack now"

    end

    def greet
      puts "greet now"
    end

    def item
      puts "item now"
    end

    def escape
      puts "うまく逃げ切れた"
      Scene.close if Key.down?(Key::ANY)
    end
  end
end
      