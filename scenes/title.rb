class Title
  def initialize
    @@display = Map.new(width: 20, height: 20, default_text: "・")
    @@title = Sprite.new(3, 2, "ABE-QUET")
    @@msg_start = "最初から"
    @@start = Sprite.new(4, 5, @@msg_start)
    @@msg_next = "続きから"
    @@next = Sprite.new(4, 7, @@msg_next)
    @@rode = Sprite.new(5, 5, "rode")
    @@back = Sprite.new(5, 6, "back")
    @@er_msg = Sprite.new(4, 5, "セーブデータがありません")
    @@sec = 0
    @@cursor = 0
    @@cursor_2 = Sprite.new(4, 5, "> ")
  end

  class << self
    def update
      system("cls")

      if @@sec == 0
        if Key.down?(Key::DOWN) && @@cursor < 1
          @@cursor += 1
        elsif Key.down?(Key::UP) && @@cursor > 0
          @@cursor -= 1
        end
      end

      if Key.down?(Key::RETURN)
        if @@sec == 0
          if @@cursor == 0
            print "名前を入力してください。\n> "
            name = gets.chomp.to_s
            name = "勇者" if name == ""
            $player = Player.new(name)
            Scene.next(init: true)
          elsif @@cursor == 1
            $player = Player.new("")
            if File.exist?("data.txt")
              File.open('data.txt', 'r'){ |f|
                $player.name = f.gets
                $player.money = f.gets.to_i
                $player.max_hp = f.gets.to_i
                $player.hp = f.gets.to_i
                $player.max_mp = f.gets.to_i
                $player.mp = f.gets.to_i
                $player.attack = f.gets.to_i
                $player.block = f.gets.to_i
                $player.agility = f.gets.to_i
              }
              Scene.next(init: true)
            else
              @@sec = 1
            end
          end
        else
          @@sec = 0
        end
      end

      if @@cursor == 0
        @@msg_start = "> 最初から"
        @@msg_next = "  続きから"
      else
        @@msg_start = "  最初から"
        @@msg_next = "> 続きから"
      end

      @@start.text = @@msg_start
      @@next.text = @@msg_next

    end
    
    def draw
      if @@sec == 0
        @@display.draw([@@title, @@start, @@next])
      else
        @@display.draw([@@er_msg])
      end
    end
  end
end
