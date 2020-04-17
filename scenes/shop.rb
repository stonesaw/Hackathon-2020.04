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
    ], text_hash:{0 => "  ", 1 => "━━", 2 => "┃ ", 3 => "┏━", 4 => "━┓", 5 => "┗━", 6 => "━┛", 7 => "┣━", 8 =>"━┫", 9 => "┳━", 10 => "┻━", 11 => " ┃"})
    @@item = [
      Sprite.new(2, 1, "メガホン"),
      Sprite.new(2, 2, "学生服"),
      Sprite.new(2, 3, "科章"),
      Sprite.new(2, 4, "欠点界の最高点"),
      Sprite.new(2, 5, "寮食"),
      Sprite.new(2, 6, "学生証"),
      Sprite.new(2, 7, "単位"),
      Sprite.new(2, 8, "ウルトラメガホン"),
      Sprite.new(2, 9, "やさC "),
      Sprite.new(2, 10, "伝説の剣"),
      Sprite.new(2, 11, "伝説の鎧"),
      Sprite.new(2, 12, "伝説のメガホン")
    ]
    @@m_num = [
      320,
      900,
      500,
      495,
      300,
      200,
      500,
      1000,
      2500,
      5000,
      5000,
      9999
    ]
    @@money = [
      Sprite.new(13, 1, " #{@@m_num[0]}GOLD"),
      Sprite.new(13, 2, " #{@@m_num[1]}GOLD"), 
      Sprite.new(13, 3, " #{@@m_num[2]}GOLD"),
      Sprite.new(13, 4, " #{@@m_num[3]}GOLD"),
      Sprite.new(13, 5, " #{@@m_num[4]}GOLD"),
      Sprite.new(13, 6, " #{@@m_num[5]}GOLD"),
      Sprite.new(13, 7, " #{@@m_num[6]}GOLD"),
      Sprite.new(13, 8, "#{@@m_num[7]}GOLD"),
      Sprite.new(13, 9, "#{@@m_num[8]}GOLD"),
      Sprite.new(13, 10, "#{@@m_num[9]}GOLD"),
      Sprite.new(13, 11, "#{@@m_num[10]}GOLD"),
      Sprite.new(13, 12, "#{@@m_num[11]}GOLD")
    ]
    @@cursol = Sprite.new(1, 1, "◎")
    @@ex_a = [
      "拡声器　声量によるダメージ増加",
      "服　敵の攻撃をちょっとだけ防ぐ",
      "身だしなみに必要　挨拶の効果UP",
      "保体の49.5点の答案　効果なし笑",
      "味はまずいが体力を回復させる",
      "これがないと、学割が効かない",
      "卒業に必要　みんな欲しがる",
      "拡声器　ダメージが大幅UP",
      "C言語用の教科書 ちゃんと読もう",
      "王がくれた剣　なくしたら買おう",
      "絶対防御の伝説の品",
      "伝説級の声量で相手を倒す"
    ]
    @@eff_t = [
      {"hp" => 0, "attack" => 20 ,"mp" => 0, "block" => 0},
      {"hp" => 0, "attack" => 0 ,"mp" => 0, "block" => 10},
      {"hp" => 0, "attack" => 10 ,"mp" => 0, "block" => 5},
      {"hp" => 0, "attack" => 0 ,"mp" => 0, "block" => 0},
      {"hp" => 40, "attack" => 0 ,"mp" => 0, "block" => 0},
      {"hp" => 15, "attack" => 0 ,"mp" => 15, "block" => 15},
      {"hp" => 30, "attack" => 30 ,"mp" => 30, "block" => 30},
      {"hp" => 0, "attack" => 70 ,"mp" => 0, "block" => 0},
      {"hp" => 0, "attack" => 40 ,"mp" => 30, "block" => 25},
      {"hp" => 0, "attack" => 90 ,"mp" => 0, "block" => 0},
      {"hp" => 0, "attack" => 0 ,"mp" => 0, "block" => 90},
      {"hp" => 0, "attack" => 300 ,"mp" => 0, "block" => 0}
    ]
    @@m_have = Sprite.new(1, 14, "所持金   #{$player.money}GOLD")
    @@m_value = Sprite.new(10, 14, "価格 #{$item_list[@@cursol.y - 1]["value"]}GOLD")
    @@mon_
    @@expla = Sprite.new(1, 15, $item_list[@@cursol.y - 1]["ex"])
    @@eff_hp = Sprite.new(1, 16, "HP #{$item_list[@@cursol.y - 1]["effect"]["hp"]}")
    @@eff_attack = Sprite.new(5, 16, "ATTACK #{$item_list[@@cursol.y - 1]["effect"]["attack"]}")
    @@eff_mp = Sprite.new(10, 17, "MP#{$item_list[@@cursol.y - 1]["effect"]["mp"]}")
    @@eff_block = Sprite.new(15, 17, "BLOCK#{$item_list[@@cursol.y - 1]["effect"]["block"]}")
    @@sel_msg = Sprite.new(1, 16, "購入しますか? ")
    @@cho_y = Sprite.new(2, 17, "はい")
    @@cho_n = Sprite.new(12, 17, "いいえ")
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
            if $player.money >= @@m_num[@@cursol.y - 1]
              @@msg.text = "購入しました"
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
          $player.money -= @@m_num[@@cursol.y - 1] if @@bu_f == 1
          @@bu_f = 0
          @@buy_f = 0
          @@sel_f = 0
        end
      end

      @@expla.text = $item_list[@@cursol.y - 1]["ex"]

      if $player.money >= 1000
        @@m_have.text = "所持金　#{$player.money}GOLD"
      elsif $player.money >= 100
        @@m_have.text = "所持金　 #{$player.money}GOLD"
      elsif $player.money >= 10
        @@m_have.text = "所持金　  #{$player.money}GOLD"
      else
        @@m_have.text = "所持金　   #{$player.money}GOLD"
      end

      if $item_list[@@cursol.y - 1]["value"] >= 1000
        @@m_value.text = "価格　#{$item_list[@@cursol.y - 1]["value"]}GOLD"
      else
        @@m_value.text = "価格　 #{$item_list[@@cursol.y - 1]["value"]}GOLD"
      end

      if @@sel_f == 0
        if $item_list[@@cursol.y - 1]["effect"]["hp"] < 10
          @@eff_hp = Sprite.new(1, 16, "HP   #{$item_list[@@cursol.y - 1]["effect"]["hp"]}")
        elsif $item_list[@@cursol.y - 1]["effect"]["hp"] < 100
          @@eff_hp = Sprite.new(1, 16, "HP  #{$item_list[@@cursol.y - 1]["effect"]["hp"]}")
        else
          @@eff_hp = Sprite.new(1, 16, "HP #{$item_list[@@cursol.y - 1]["effect"]["hp"]}")
        end

        if $item_list[@@cursol.y - 1]["effect"]["attack"] < 10
          @@eff_attack = Sprite.new(9, 16, "ATTACK   #{$item_list[@@cursol.y - 1]["effect"]["attack"]}")
        elsif $item_list[@@cursol.y - 1]["effect"]["attack"] < 100
          @@eff_attack = Sprite.new(9, 16, "ATTACK  #{$item_list[@@cursol.y - 1]["effect"]["attack"]}")
        else
          @@eff_attack = Sprite.new(9, 16, "ATTACK #{$item_list[@@cursol.y - 1]["effect"]["attack"]}")
        end

        if $item_list[@@cursol.y - 1]["effect"]["mp"] < 10
          @@eff_mp = Sprite.new(1, 17, "MP   #{$item_list[@@cursol.y - 1]["effect"]["mp"]}")
        elsif $item_list[@@cursol.y - 1]["effect"]["mp"] < 100
          @@eff_mp = Sprite.new(1, 17, "MP  #{$item_list[@@cursol.y - 1]["effect"]["mp"]}")
        else
          @@eff_mp = Sprite.new(1, 17, "MP #{$item_list[@@cursol.y - 1]["effect"]["mp"]}")
        end

        if $item_list[@@cursol.y - 1]["effect"]["block"] < 10
          @@eff_block = Sprite.new(9, 17, "BLOCK    #{$item_list[@@cursol.y - 1]["effect"]["block"]}")
        elsif $item_list[@@cursol.y - 1]["effect"]["block"] < 100
          @@eff_block = Sprite.new(9, 17, "BLOCK   #{$item_list[@@cursol.y - 1]["effect"]["block"]}")
        else
          @@eff_block = Sprite.new(9, 17, "BLOCK  #{$item_list[@@cursol.y - 1]["effect"]["block"]}")
        end
      end

      Scene.select(1, init: false) if Key.down?(Key::ESCAPE)
    end

    def draw
      if @@sel_f == 0
        @@display.draw([@@item, @@money, @@cursol, @@expla, @@m_have, @@m_value, @@eff_hp, @@eff_attack, @@eff_mp, @@eff_block])
      else
        @@display.draw([@@item, @@money, @@cursol, @@expla, @@m_have, @@m_value, @@sel_msg, @@cho_y, @@cho_n, @@cursol_2, @@msg])
      end
    end
  end
end
