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
    @@ste = Sprite.new(2, 1, "ステータスの確認")
    @@save = Sprite.new(2, 2, "セーブ")
    @@end = Sprite.new(2, 3, "終了")
    @@cursol = Sprite.new(1, 1, "◎")
    @@sa_msg = Sprite.new(1, 1, "セーブしました")
    @@item_list = []
    @@dr_f = 0
  end

  class << self
    def update
      system("cls")

      if $player.money < 10
        @@money = Sprite.new(2, 1, "MONEY      #{$player.money}")
      elsif $player.money < 100
        @@money = Sprite.new(2, 1, "MONEY     #{$player.money}")
      elsif $player.money < 1000
        @@money = Sprite.new(2, 1, "MONEY    #{$player.money}")
      else
        @@money = Sprite.new(2, 1, "MONEY   #{$player.money}")
      end

      
      if $player.hp < 10
        @@hp = Sprite.new(2, 2, "HP       #{$player.hp}")
      elsif $player.hp < 100
        @@hp = Sprite.new(2, 2, "HP        #{$player.hp}")
      elsif $player.hp < 1000
        @@hp = Sprite.new(2, 2, "HP       #{$player.hp}")
      else
        @@hp = Sprite.new(2, 2, "HP      #{$player.hp}")
      end

      
      if $player.mp < 10
        @@mp = Sprite.new(2, 3, "MP         #{$player.mp}")
      elsif $player.mp < 100
        @@mp = Sprite.new(2, 3, "MP        #{$player.mp}")
      elsif $player.mp < 1000
        @@mp = Sprite.new(2, 3, "MP       #{$player.mp}")
      else
        @@mp = Sprite.new(2, 3, "MP      #{$player.mp}")
      end
      
      if $player.attack < 10
        @@attack = Sprite.new(2, 4, "ATTACK     #{$player.attack}")
      elsif $player.attack < 100
        @@attack = Sprite.new(2, 4, "ATTACK    #{$player.attack}")
      elsif $player.attack < 1000
        @@attack = Sprite.new(2, 4, "ATTACK   #{$player.attack}")
      else
        @@attack = Sprite.new(2, 4, "ATTACK  #{$player.attack}")
      end
      
      if $player.block < 10
        @@block = Sprite.new(2, 5, "BLOCK      #{$player.block}")
      elsif $player.block < 100
        @@block = Sprite.new(2, 5, "BLOCK     #{$player.block}")
      elsif $player.block < 1000
        @@block = Sprite.new(2, 5, "BLOCK    #{$player.block}")
      else
        @@block = Sprite.new(2, 5, "BLOCK   #{$player.block}")
      end
      
      if $player.agility < 10
        @@agility = Sprite.new(2, 6, "AGILITY    #{$player.agility}")
      elsif $player.agility < 100
        @@agility = Sprite.new(2, 6, "AGILITY   #{$player.agility}")
      elsif $player.agility < 1000
        @@agility = Sprite.new(2, 6, "AGILITY  #{$player.agility}")
      else
        @@agility = Sprite.new(2, 6, "AGILITY #{$player.agility}")
      end

      @@cursol.y += 1 if Key.down?(Key::DOWN) && @@cursol.y < 3
      @@cursol.y -= 1 if Key.down?(Key::UP) && @@cursol.y > 1

      if Key.down?(Key::RETURN)
        if (@@dr_f) == 0
          if @@cursol.y == 1
            @@dr_f = 1
          elsif @@cursol.y == 2
            @@dr_f = 2
          else
            exit
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
        @@display.draw([@@money, @@hp, @@mp, @@attack, @@block, @@agility])
      elsif @@dr_f == 2
        @@display.draw([@@sa_msg])
      end
    end
  end
end
