class Title
  def initialize
    @@display = Map.new(width: 20, height: 20, default_text: " .")
    @@title = Sprite.new(4, 3, ["=-=-=-=-=-=-=-=-=-=-=-=-", 
                                "                        ",
                                "  Xx_AAABBBEEE-QUET_xX  ",
                                "                        ",
                                "-=-=-=-=-=-=-=-=-=-=-=-="])
    @@msg_start = "最初から"
    @@start = Sprite.new(7, 10, @@msg_start)
    @@msg_next = "続きから"
    @@next = Sprite.new(7, 12, @@msg_next)
    @@copylight = Sprite.new(5, 18, " (C) 2020 AAABBBEEE ")
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
            loop do
              print "名前を入力してください。\n> "
              @@p_name = gets.chomp.to_s
              @@p_name = "勇者" if @@p_name == ""
              if @@p_name.length > 16
                print "半角16文字・全角8文字以下の名前にしてください！"
              else
                puts "こんにちわ#{@@p_name}！"
                puts "AAABBBEEE-QUESTへようこそ！"
                sleep 1
                break
              end
            end
            $player = Player.new(@@p_name)
            Scene.next(init: true)
          elsif @@cursor == 1
            $player = Player.new("")
            if File.exist?("./data/data.txt")
              File.open('./data/data.txt', 'r'){ |f|
                $save_data[0] = f.gets.to_i
                $save_data[1] = f.gets.to_i
                $save_data[2] = f.gets.to_i
                $player.name = f.gets.chomp
                $player.money = f.gets.to_i
                $player.max_hp = f.gets.to_i
                $player.hp = f.gets.to_i
                $player.max_mp = f.gets.to_i
                $player.mp = f.gets.to_i
                $player.attack = f.gets.to_i
                $player.block = f.gets.to_i
                $player.agility = f.gets.to_i
                item = f.gets
                while item != nil
                  $player.item_list << eval("#{item}")
                  item = f.gets
                end
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
        @@msg_next =  "  続きから"
      else
        @@msg_start = "  最初から"
        @@msg_next =  "> 続きから"
      end

      @@start.text = @@msg_start
      @@next.text = @@msg_next

    end
    
    def draw
      if @@sec == 0
        @@display.draw([@@title, @@start, @@next, @@copylight])
      else
        @@display.draw([@@er_msg])
      end
    end
  end
end
