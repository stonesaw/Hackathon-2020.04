class Shop
  def initialize
    @@display = Map.new(map:[
      [3,1,1,1,1,1,1,1,1,1,1,1,9,1,1,1,1,1,1,4],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,11],
      [7,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,8],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11],
      [2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11],
      [5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,6]
    ], text_hash:{0 => "  ", 1 => "━━", 2 => "┃ ", 
                  3 => "┏━", 4 => "━┓", 5 => "┗━", 6 => "━┛", 
                  7 => "┣━", 8 =>"━┫", 9 => "┳━", 10 => "┻━", 11 => " ┃"}
    )
    @@list_size = 12
    name_ary = []
    value_ary = []
    @@list_size.times do |i|
      name_ary << $item_list[i]['name']
      item_val = $item_list[i]['value']
      value_ary << (("#{item_val}".length % 2) == 0 ? " #{item_val} GOLD" : "  #{item_val} GOLD")
    end
    @@item =  Sprite.new(2, 1, name_ary)
    @@money = Sprite.new(13, 1, value_ary)
    @@cursol = Sprite.new(1, 1, "◎")
    @@m_have =  Sprite.new(1, 14, "所持金  GOLD")
    @@m_value = Sprite.new(10, 14, "価格  GOLD")
    @@expla =   Sprite.new(1, 15, "EX")
    @@eff_hp =     Sprite.new(1, 16, "HP")
    @@eff_attack = Sprite.new(9, 16, "ATTACK")
    @@eff_mp =     Sprite.new(1, 17, "MP")
    @@eff_block =  Sprite.new(9, 17, "BLOCK ")
    @@sel_msg = Sprite.new(1, 16, "購入しますか? ")
    @@cho_y =   Sprite.new(2, 17, "はい")
    @@cho_n =   Sprite.new(12, 17, "いいえ")
    @@cursol_2 = Sprite.new(1, 17, "〇")
    @@msg = Sprite.new(1, 18, "  ")
    @@sel_f = 0
    @@buy_f = 0
    @@bu_f = 0
  end

  class << self
    def update
      system("cls")

      if @@sel_f == 0
        @@cursol.y += 1 if Key.down?(Key::DOWN) && @@cursol.y < 12
        @@cursol.y -= 1 if Key.down?(Key::UP) && @@cursol.y > 1
      else
        @@cursol_2.x = 1 if Key.down?(Key::LEFT)
        @@cursol_2.x = 11 if Key.down?(Key::RIGHT)
      end
      
      if Key.down?(Key::RETURN)
        if @@sel_f == 0
          @@sel_f = 1
        elsif @@buy_f == 0
          if @@cursol_2.x == 1
            if $player.money >= $item_list[@@cursol.y - 1]['value']
              @@msg.text = "購入しました"
              get_item($item_list[@@cursol.y - 1]['name'])
              @@bu_f = 1
            else
              @@msg.text = "お金が足りません"
            end
            @@buy_f = 1
          else
            @@sel_f = 0
          end
          @@cursol_2.x = 1
        else
          @@msg.text = "  "
          $player.money -= $item_list[@@cursol.y - 1]['value'] if @@bu_f == 1
          @@bu_f = 0
          @@buy_f = 0
          @@sel_f = 0
        end
      end

      @@expla.text =   $item_list[@@cursol.y - 1]["ex"]
      @@m_have.text =  "所持金 #{Text.insert($player.money, num: 4)} GOLD"
      @@m_value.text = "価格 #{Text.insert($item_list[@@cursol.y - 1]["value"], num: 4)} GOLD"

      if @@sel_f == 0
        @@eff_hp.text =     "HP    " + effect2text("hp")
        @@eff_mp.text =     "MP    " + effect2text("mp")
        @@eff_attack.text = "ATTACK" + effect2text("attack")
        @@eff_block.text =  "BLOCK " + effect2text("block")
      end

      Scene.select(1, init: false) if Key.down?(Key::ESCAPE)
    end

    def draw
      already = [@@item, @@money, @@cursol, @@expla, @@m_have, @@m_value]
      if @@sel_f == 0
        @@display.draw(already + [@@eff_hp, @@eff_attack, @@eff_mp, @@eff_block])
      else
        @@display.draw(already + [@@sel_msg, @@cho_y, @@cho_n, @@cursol_2, @@msg])
      end
    end

    def effect2text(status)
      if $item_list[@@cursol.y - 1]["effect"].has_key?(status)
        text = $item_list[@@cursol.y - 1]["effect"][status].to_s
      else
        text = "0"
      end
      (4 - text.length).times do
        text = " " + text
      end
      return text
    end

    def get_item(name)
      if $player.item_list.length == 0
        $player.item_list << {'name' => name, 'num' => 1, 'data' => $item_list[@@cursol.y - 1]}
      else
        $player.item_list.length.times do |i|
          if $player.item_list[i]['name'] == name
            $player.item_list[i]['num'] += 1
            return
          end
        end
        $player.item_list << {'name' => name, 'num' => 1, 'data' => $item_list[@@cursol.y - 1]}
      end
    end
  end
end
