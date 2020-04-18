class Enemy
  attr_accessor :name, :kind, :hp, :max_hp, :mp, :max_mp,:attack, :block, :agility, :money, :exp

  def initialize(kind)
    if $enemies_data.include?(kind)
      @kind = kind
    else
      raise ArgumentError.new("'#{kind}' is undefined in <enemies_data>")
    end
    @name = ""
    if @kind == "slime"
      @name = "スラ" + $random_names_data[rand($random_names_data.length - 1)]
    end
    @hp = data_match('hp')
    @mp = data_match('mp')
    @max_hp = @hp
    @max_mp = @mp
    @attack = data_match('attack')
    @block = data_match('block')
    @agility =  data_match('agility')
    @money = data_match('money')
    @exp = data_match('exp')
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
        3 => "┏", 4 => "┓", 5 => "┗", 6 => "┛", 7 => "┣", 8 => "┫"}
    )
    @@cursor = Sprite.new(2, 15, "○")
    @@com_attack = Sprite.new(4, 15, "攻撃")
    @@com_greet = Sprite.new(4, 16, "あいさつ")
    @@com_item = Sprite.new(12, 15, "アイテム")
    @@com_escape = Sprite.new(12, 16, "逃げる")
    @@com_ex = Sprite.new(5, 18, "選択:方向キー, 決定:エンター")
    @@msg = Sprite.new(3, 15, "text")
    @@drawed = []
    @@enemy1 = Enemy.new("slime")
    @@show_enemy = Sprite.new(7, 1, ["ene", "HP||"])
    @@show_player = Sprite.new(2, 10, ["yu", "HP||"])
    @@my_init = 0
    @@esc_enemy_attack = 0
  end

  class << self
    def update
      system("cls")
      # $playerはinitializeで使えないため
      if @@my_init == 0
        @@show_enemy.text = text_persentage(@@enemy1)
        @@show_player.text = text_persentage($player)
        @@my_init = 1
      end

      # 常に表示
      @@drawed = [@@show_enemy, @@show_player]

      if Key.down?(Key::UP) && @@cursor.y > @@com_attack.y
        @@cursor.y -= @@com_escape.y - @@com_attack.y
      elsif Key.down?(Key::DOWN) && @@cursor.y < @@com_escape.y
        @@cursor.y += @@com_escape.y - @@com_attack.y
      elsif Key.down?(Key::RIGHT) && @@cursor.x < @@com_ex.x - 2
        @@cursor.x += @@com_escape.x - @@com_attack.x
      elsif Key.down?(Key::LEFT) && @@cursor.x > @@com_attack.x - 2
        @@cursor.x -= @@com_escape.x - @@com_attack.x
      end

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
          escape() if $player.hp > 0
        end
        
        if @@esc_enemy_attack == 0
          enemy_attack() if $player.agility >= @@enemy1.agility
        end
      else
        @@display.draw(@@drawed << [@@cursor, @@com_attack, @@com_greet, @@com_item, @@com_escape, @@com_ex])
      end
    end

    def draw
      # @@display.draw(@@drawed)
      # p @@enemy1
      # p $player
    end

    # 行動 - 攻撃
    def attack
      damage = $player.attack - (@@enemy1.block * rand(0.7..1)).round
      damage = 0 if damage <= 0
      @@enemy1.hp -= damage

      damage = " #{damage}" if "#{damage}".length == 1
      
      @@msg.text = ["#{text_control($player.name)}の攻撃！", "#{text_control(@@enemy1.name)}に#{damage}のダメージ！"]
      if @@enemy1.hp > 0
        @@msg.text += ["#{text_control(@@enemy1.name)}のHP残り#{text_control(@@enemy1.hp)}"]
      end
      msg_draw()

      defeat() if @@enemy1.hp <= 0
    end

    # 行動 - あいさつ
    def greet
      @@msg.text = "#{text_control($player.name)}は大きな声であいさつをした"
      msg_draw()
      @@msg.text =  ["#{text_control(@@enemy1.name)}は", "いい気分になって帰っていった... "]
      msg_draw()
      @@esc_enemy_attack = 1
      # To Scene-Field
      Scene.select(1, init: false)
    end

    # 行動 - アイテム
    def item
      if $player.item_list.empty?
        @@msg.text = ["#{text_control($player.name)}は", "アイテムを持っていなかった。"]
        msg_draw()
        @@esc_enemy_attack = 1
      else
        @@msg.text = "どのアイテムを使いますか"
        msg_draw()
      end
    end

    # 行動 - 逃げる
    def escape
      puts "うまく逃げ切れた"
      msg_draw()
      # To Scene-Field
      Scene.select(1, init: false)
      @@esc_enemy_attack = 1
    end

    def enemy_attack
      @@msg.text = "敵の攻撃"
      msg_draw()

      damage = @@enemy1.attack - ($player.block * rand(0.7..1)).round
      damage = 0 if damage <= 0
      $player.hp -= damage

      @@msg.text = ["#{text_control(@@enemy1.name)}の攻撃！", 
                    "#{text_control($player.name)}に#{text_control(damage)}のダメージ！"]
      if $player.hp > 0
        @@msg.text += ["#{text_control($player.name)}のHP残り" + text_control($player.hp)]
      end
      msg_draw()

      gameover() if $player.hp <= 0
    end

    def defeat
      @@esc_enemy_attack = 1
      @@msg.text = "#{text_control(@@enemy1.name)}を倒した"
      msg_draw()

      $player.money += @@enemy1.money
      $player.exp += @@enemy1.exp
      @@msg.text = ["#{text_control(@@enemy1.exp)}Exp,", 
                    "#{text_control(@@enemy1.money)}GOLDを手に入れた"]
      msg_draw()
      system("cls")
      # To Scene-Fielsd
      Scene.select(1, init: false)
    end

    def gameover
      @@msg.text = "ヤラレチャッタ！"
      msg_draw()
      # To Scene-Field
      $player.money /= 2
      Scene.select(1, init: false)
    end

    def msg_draw(time = 20)
      @@show_enemy.text = text_persentage(@@enemy1)
      @@show_player.text = text_persentage($player)
      time.times do |i|
        Key.update
        break if Key.down?(Key::RETURN)
        
        system("cls")
        @@display.draw(@@drawed)
        p i
      end
    end

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
      return ["#{text_control(character.name)}  HP:#{text_control(character.hp)}/#{text_control(character.max_hp)}",
              "HP|#{hp_gauge}|",
              "MP|#{mp_gauge}|"]
    end

    def text_control(text)
      text = text.to_s
      width = 0
      text.scan(/./) do |i|
        if /\A[ぁ-んー－]+\z/ =~ i# 全角ひらがな
          width += 2
        elsif /\A[ｧ-ﾝﾞﾟ]+\z/ =~ i# 半角型カタカナ
          width += 1
        elsif /\A[ -~。-゜]+\z/ =~ i# 半角
          width += 1
        else
          width += 1
        end
      end
      (width % 2) == 1 ? " " + text : text
    end
  end
end
