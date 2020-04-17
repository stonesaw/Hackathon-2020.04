class Title
  def initialize
    @@display = Map.new(width: 20, height: 20, default_text: "・")
    @@title = Sprite.new(3, 2, "ABE-QUET")
    @@msg_start = "START"
    @@start = Sprite.new(4, 5, @@msg_start)
    @@msg_option = "OPTION"
    @@option = Sprite.new(4, 7, @@msg_option)
    @@cursor = 0
  end

  class << self
    def update
      system("cls")
      if Key.down?(Key::DOWN) && @@cursor < 1
        @@cursor += 1
      elsif Key.down?(Key::UP) && @@cursor > 0
        @@cursor -= 1
      end

      if Key.down?(Key::RETURN)
        if @@cursor == 0
          print "名前を入力してください。\n> "
          name = gets.chomp.to_s
          name = "勇者" if name == ""
          $player = Player.new(name)
          Scene.next(init: true)
        elsif @@cursor == 1
          puts "option"
        end
      end

      if @@cursor == 0
        @@msg_start = "> START "
        @@msg_option = "  OPTION"
      else
        @@msg_start = "  START "
        @@msg_option = "> OPTION"
      end

      @@start.text = @@msg_start
      @@option.text = @@msg_option

    end
    
    def draw
      @@display.draw([@@title, @@start, @@option])
    end
  end
end
