class Enemy
  attr_accessor :name, :kind, :hp, :max_hp, :mp, :max_mp,:attack, :block, :agility, :money, :exp

  def initialize(kind)
    if $enemies_data.include?(kind)
      @kind = kind
    else
      raise ArgumentError.new("'#{kind}' is undefined in 'data/enemies_data.json'")
    end

    if @kind == "slime"
      @name = "スラ" + $random_names_data[rand($random_names_data.length - 1)]
    elsif @kind == "maou"
      @name = "魔王"
    else
      @name = "NoName"
    end
    
    @hp = data_match('hp')
    @mp = data_match('mp')
    @max_hp = @hp
    @max_mp = @mp
    @attack =  data_match('attack')
    @block =   data_match('block')
    @agility = data_match('agility')
    @money =   data_match('money')
    @exp =     data_match('exp')
  end

  private
  def data_match(status)
    match1 = $enemies_data[@kind][status].match(/\A([1-9]*[0-9]+)\z/)
    match2 = $enemies_data[@kind][status].match(/\A([1-9]*[0-9]+)-([1-9]*[0-9]+)\z/)
    if match1
      return match1[1].to_i
    elsif match2
      return rand((match2[1].to_i)..(match2[2].to_i))
    else
      raise ArgumentError.new("'#{status}' no match data type (check 'data/enemies.json')")
    end
  end
end

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
                   3 => "┏", 4 => "┓", 5 => "┗", 6 => "┛", 
                   7 => "┣", 8 => "┫"}
    )
    @@cursor =     Sprite.new(2, 15, "○")
    @@com_attack = Sprite.new(4, 15, "攻撃")
    @@com_greet =  Sprite.new(4, 16, "あいさつ")
    @@com_item =   Sprite.new(12, 15, "アイテム")
    @@com_escape = Sprite.new(12, 16, "逃げる")
    @@com_ex =     Sprite.new(5, 18, "選択:方向キー, 決定:エンター")
    @@msg =        Sprite.new(3, 15, "msg ")
    @@item_cursor = Sprite.new(2, 15, "◎")
    @@item_msg =    Sprite.new(3, 14, "item")
    if Field.enemy == "nomal"
      @@enemy1 = Enemy.new("slime")
    elsif Field.enemy == "maou"
      @@enemy1 = Enemy.new("maou")
    end
    @@show_enemy =  Sprite.new(7, 1, Battle.text_persentage(@@enemy1))
    @@show_player = Sprite.new(2, 10, Battle.text_persentage($player))
    @@drawed = []
    @@esc_enemy_attack = 0
  end

  class << self
    def update
      system("cls")

      # 常に表示
      @@drawed = [@@show_enemy, @@show_player]

      # カーソルの移動
      if Key.down?(Key::UP) && @@cursor.y > @@com_attack.y
        @@cursor.y -= (@@com_escape.y - @@com_attack.y)
      elsif Key.down?(Key::DOWN) && @@cursor.y < @@com_escape.y
        @@cursor.y += (@@com_escape.y - @@com_attack.y)
      elsif Key.down?(Key::RIGHT) && @@cursor.x < @@com_ex.x - 2
        @@cursor.x += (@@com_escape.x - @@com_attack.x)
      elsif Key.down?(Key::LEFT) && @@cursor.x > @@com_attack.x - 2
        @@cursor.x -= (@@com_escape.x - @@com_attack.x)
      end

      # 行動が選択されたとき
      if Key.down?(Key::RETURN)
        @@drawed << @@msg
        @@esc_enemy_attack = 0
        if @@cursor.x == @@com_attack.x - 2 && @@cursor.y == @@com_attack.y
          enemy_attack() if $player.agility < @@enemy1.agility
          attack() if $player.hp > 0
        elsif @@cursor.x == @@com_greet.x - 2 && @@cursor.y == @@com_greet.y
          enemy_attack() if $player.agility < @@enemy1.agility
          greet() if $player.hp > 0
        elsif @@cursor.x == @@com_item.x - 2 && @@cursor.y == @@com_item.y
          item() if $player.hp > 0
        elsif @@cursor.x == @@com_escape.x - 2 && @@cursor.y == @@com_escape.y
          enemy_attack() if $player.agility < @@enemy1.agility
          escape() if $player.hp > 0
        end
        
        if $player.agility >= @@enemy1.agility && @@esc_enemy_attack == 0
          enemy_attack()
        end
      else
        @@display.draw(@@drawed + [@@cursor, @@com_attack, @@com_greet, @@com_item, @@com_escape, @@com_ex])
      end
    end

    def draw
      # msg_draw()でループを回していたり、描画しているため毎回drawが呼ばれると都合が悪いので省略
    end

    # 行動 - 攻撃
    def attack
      if @@enemy1.kind == "maou"
        motion_attack($player, @@enemy1, exception_damage: 0)
      else
        motion_attack($player, @@enemy1)
      end

      defeat() if @@enemy1.hp <= 0
    end

    # 行動 - あいさつ
    def greet
      @@msg.text = ["#{Text.insert($player.name)}は", "大きな声であいさつをした"]
      msg_draw()

      if @@enemy1.kind == "maou"
        motion_attack($player, @@enemy1)
        defeat() if @@enemy1.hp <= 0
      else
        @@msg.text =  ["#{Text.insert(@@enemy1.name)}は", "いい気分になって帰っていった... "]
        msg_draw()
        system("cls")
        @@esc_enemy_attack = 1
        # To Scene-Field
        Scene.select(1, init: false)
      end
    end

    # 行動 - アイテム
    def item
      @@item_can_use = []
      $player.item_list.length.times do |i|
        if $player.item_list[i]['data']['type'] == "item"
          @@item_can_use << $player.item_list[i]
        end
      end

      if @@item_can_use.length == 0
        @@msg.text = ["#{Text.insert($player.name)}は", "使えるアイテムを持っていなかった"]
        msg_draw()
        @@esc_enemy_attack = 1
      else
        @@item_cursor_pos = 0
        @@item_draw_pos = 0
        loop do
          Key.update
          system("cls")

          if Key.down?(Key::ESCAPE)
            @@esc_enemy_attack = 1
            break
          end

          @@item_msg.text = ["どのアイテムを使いますか"]
          4.times do |i|
            break if @@item_can_use.length <= @@item_draw_pos + i
            name = Text.add("#{@@item_can_use[@@item_draw_pos + i]['name']}", num: 16)
            num = @@item_can_use[@@item_draw_pos + i]['num']
            @@item_msg.text = @@item_msg.text << "#{name}  ×  #{Text.insert(num)}"
          end

          if Key.down?(Key::UP)
            if @@item_cursor_pos > 0
              @@item_cursor_pos -= 1
              if @@item_cursor.y > 15
                @@item_cursor.y -= 1
              else
                @@item_draw_pos -= 1
              end
            end
          elsif Key.down?(Key::DOWN)
            if @@item_cursor_pos < @@item_can_use.length - 1
              @@item_cursor_pos += 1
              if @@item_cursor.y < 18
                @@item_cursor.y += 1
              else
                @@item_draw_pos += 1
              end
            end
          end

          @@display.draw([@@show_player, @@show_enemy, @@item_msg, @@item_cursor])

          if Key.down?(Key::RETURN)
            item_using = @@item_can_use[@@item_cursor_pos]
            @@msg.text = ["#{Text.insert($player.name)}は", "#{item_using['name']}を使った！"]
            msg_draw()

            use_item(item_using)
            break
          end
        end
      end
    end

    # 行動 - 逃げる
    def escape
      @@msg.text = "うまく逃げ切れた"
      msg_draw()
      # To Scene-Field
      Scene.select(1, init: false)
      @@esc_enemy_attack = 1
    end

    # --- 敵の攻撃 ---
    def enemy_attack
      @@msg.text = "敵の攻撃"
      msg_draw()

      motion_attack(@@enemy1, $player)
      gameover() if $player.hp <= 0
    end

    # --- 敵を倒したとき ---
    def defeat
      @@esc_enemy_attack = 1
      @@msg.text = "#{Text.insert(@@enemy1.name)}を倒した"
      msg_draw()

      $player.money += @@enemy1.money
      $player.exp += @@enemy1.exp
      @@msg.text = ["#{Text.insert(@@enemy1.exp)}Exp,", 
                    "#{Text.insert(@@enemy1.money)}GOLDを手に入れた"]
      $player.money = 9999 if $player.money > 9999
      $player.exp   = 9999 if $player.exp   > 9999
      msg_draw()
      system("cls")
      # To Scene-Fielsd
      Scene.select(1, init: false)
    end

    # --- 自分が死んだとき ---
    def gameover
      @@msg.text = "ヤラレチャッタ！"
      msg_draw()

      # To Scene-Field
      $player.money /= 2
      Scene.select(1, init: false)
    end

    # --- 攻撃のベースメソッド ---
    def motion_attack(from, to, exception_damage: -1)
      if exception_damage == -1
        damage = from.attack - (to.block * rand(0.7..1)).round
        damage = 0 if damage <= 0
        to.hp -= damage
      else
        damage = exception_damage
        to.hp -= damage
      end

      damage = " #{damage}" if "#{damage}".length == 1      
      @@msg.text = ["#{Text.insert(from.name)}の攻撃！", "#{Text.insert(to.name)}に#{damage}のダメージ！"]
      @@msg.text += ["#{Text.insert(to.name)}のHP残り#{Text.insert(to.hp)}"] if to.hp > 0
      msg_draw()
    end

    # --- アイテムの使用 ---
    def use_item(item)
      if item['num'] > 1
        item['num'] -= 1
      else
        choice = $player.item_list.select { |list| list == item}
        $player.item_list.delete(choice.first)
        @@item_cursor.y = 15
      end
      if item['data']['effect'].length == 0
        @@msg.text = "しかしなにも起きなかった... "
        msg_draw()
      else
        @@msg.text = ["#{Text.insert($player.name)}の  "]
        $player.hp = item_effect(item, 'hp', $player.hp, max_to: $player.max_hp)
        $player.mp = item_effect(item, 'mp', $player.mp, max_to: $player.max_mp)
        $player.attack = item_effect(item, 'attack', $player.attack)
        $player.block = item_effect(item, 'block', $player.block)
        $player.agility = item_effect(item, 'agility', $player.agility)

        msg_draw()
      end
    end

    def item_effect(item, effect, to, max_to: -1)
      if item['data']['effect'].has_key?(effect)
        num = item['data']['effect'][effect]
        if effect == 'hp' || effect == 'mp'
          if @@msg.text[-1].length > 10
            @@msg.text = @@msg.text << "#{effect.upcase}が#{Text.insert(num)}回復!   "
          else
            @@msg.text[-1] += "#{effect.upcase}が#{Text.insert(num)}回復!   "
          end
        else
          if @@msg.text[-1].length > 10
            @@msg.text = @@msg.text << "#{Text.insert(effect.upcase)}が#{Text.insert(num)}上昇!   "
          else
            @@msg.text[-1] += "#{Text.insert(effect.upcase)}が#{Text.insert(num)}上昇!   "
          end
        end
        to += num
        if max_to == -1
          return to
        else
          return to > max_to ? max_to : to
        end
      end
      return to
    end

    # --- メッセージの表示 ---
    def msg_draw(time = 20)
      @@show_enemy.text = text_persentage(@@enemy1)
      @@show_player.text = text_persentage($player)
      time.times do |i|
        Key.update
        break if Key.down?(Key::RETURN)
        
        system("cls")
        @@display.draw(@@drawed)
        # p i
      end
    end

    # --- HP, MP のゲージを更新 ---
    def text_persentage(character)
      character.hp = 0 if character.hp < 0
      character.mp = 0 if character.mp < 0
      
      hp_per = ((character.hp.to_f / character.max_hp.to_f) * 10).round
      mp_per = ((character.mp.to_f / character.max_mp.to_f) * 10).round
      hp_gauge = ""
      mp_gauge = ""
      10.times do |i|
        hp_gauge += hp_per > i ? "■" : "□"
        mp_gauge += mp_per > i ? "■" : "□"
      end
      return ["#{Text.insert(character.name)}  HP:#{Text.insert(character.hp)}/#{Text.insert(character.max_hp)}",
              "HP|#{hp_gauge}|",
              "MP|#{mp_gauge}|"]
    end
  end
end
