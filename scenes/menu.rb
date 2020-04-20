class Menu
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
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
      [5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,6]
    ], text_hash: {0 => "  ", 1 => "━━", 2 => "┃", 3 => "┏", 4 => "┓", 5 => "┗", 6 => "┛"})
    @@ste =  Sprite.new(2, 1, "ステータスの確認")
    @@save = Sprite.new(2, 2, "セーブ")
    @@end =  Sprite.new(2, 3, "終了")
    @@cursol =   Sprite.new(1, 1, "◎")
    @@cursol_2 = Sprite.new(2, 3, "◎")
    @@sa_msg =   Sprite.new(1, 1, "セーブしました")
    @@sa_che_1 = Sprite.new(2, 1, "既存のセーブデータがあります。")
    @@sa_che_2 = Sprite.new(2, 2, "上書きしますか？")
    @@item_msg = Sprite.new(2, 9, "-アイテム-")
    @@yes = Sprite.new(3, 3, "はい")
    @@no =  Sprite.new(3, 4, "いいえ")
    @@item_list = []
    $player.item_list.length.times do |i|
      name = Text.add($player.item_list[i]['name'], num: 16)
      num = Text.insert($player.item_list[i]['num'], num: 2)
      @@item_list << Sprite.new(2, (10 + i), "#{name}  ×  #{num}")
    end
    if $player.item_list.length == 0
      @@item_list = Sprite.new(2, 9, "なし")
    end
    @@money =   Sprite.new(2, 2, "MONEY ")
    @@hp =      Sprite.new(2, 3, "HP")
    @@mp =      Sprite.new(2, 4, "MP")
    @@attack =  Sprite.new(2, 5, "ATTACK")
    @@block =   Sprite.new(2, 6, "BLOCK ")
    @@agility = Sprite.new(2, 7, "AGILITY ")
    @@dr_f = 0
  end

  class << self
    def update
      system("cls")

      @@money.text =   "MONEY   #{Text.insert($player.money, num: 4)}"
      @@hp.text =      "HP      #{Text.insert($player.hp, num: 4)}"
      @@mp.text =      "MP      #{Text.insert($player.mp, num: 4)}"
      @@attack.text =  "ATTACK  #{Text.insert($player.attack, num: 4)}"
      @@block.text =   "BLOCK   #{Text.insert($player.block, num: 4)}"
      @@agility.text = "AGILITY #{Text.insert($player.agility, num: 4)}"

      if @@dr_f == 0
        @@cursol.y += 1 if Key.down?(Key::DOWN) && @@cursol.y < 3
        @@cursol.y -= 1 if Key.down?(Key::UP) && @@cursol.y > 1
      elsif @@dr_f == 4
        @@cursol_2.y = 3 if Key.down?(Key::UP)
        @@cursol_2.y = 4 if Key.down?(Key::DOWN)
      end

      if Key.down?(Key::RETURN)
        if @@dr_f == 0
          if @@cursol.y == 1
            @@dr_f = 1
          elsif @@cursol.y == 2
            if File.exist?("./data/data.txt")
              @@dr_f = 4
            else
              open('./data/data.txt', 'w'){ |f|
                f.puts "#{Field.dis_flag}"
                f.puts "#{Field.player.x}"
                f.puts "#{Field.player.y}"
                f.puts "#{$player.name}"
                f.puts "#{$player.money}"
                f.puts "#{$player.max_hp}"
                f.puts "#{$player.hp}"
                f.puts "#{$player.max_mp}"
                f.puts "#{$player.mp}"
                f.puts "#{$player.attack}"
                f.puts "#{$player.block}"
                f.puts "#{$player.agility}"
                ($player.item_list).length.times do |i|
                  f.puts "#{$player.item_list[i]}"
                end
              }
              @@dr_f = 2
            end
          else
            exit
          end
        elsif @@dr_f == 4
          if @@cursol_2.y == 3
            open('./data/data.txt', 'w'){ |f|
              f.puts "#{Field.dis_flag}"
              f.puts "#{Field.player.x}"
              f.puts "#{Field.player.y}"
              f.puts "#{$player.name}"
              f.puts "#{$player.money}"
              f.puts "#{$player.max_hp}"
              f.puts "#{$player.hp}"
              f.puts "#{$player.max_mp}"
              f.puts "#{$player.mp}"
              f.puts "#{$player.attack}"
              f.puts "#{$player.block}"
              f.puts "#{$player.agility}"
              ($player.item_list).length.times do |i|
                f.puts "#{$player.item_list[i]}"
              end
            }
            @@dr_f = 2
          else
            @@dr_f = 0
          end
        else
          @@dr_f = 0
        end
      end

      Scene.back(init: false) if Key.down?(Key::ESCAPE)
    end

    def draw
      if @@dr_f == 0
        @@display.draw([@@ste, @@save, @@end, @@cursol])
      elsif @@dr_f == 1
        @@display.draw([@@money, @@hp, @@mp, @@attack, @@block, @@agility, @@item_msg, @@item_list])
      elsif @@dr_f == 2
        @@display.draw([@@sa_msg])
      elsif @@dr_f == 4
        @@display.draw([@@sa_che_1, @@sa_che_2, @@cursol_2, @@yes, @@no])
      end
    end
  end
end
