class Enemy
  attr_accessor :name, :kind, :hp, :max_hp, :mp, :max_mp,:attack, :block, :agility

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
      puts "no-match"
      exit
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
    @@com_attack = Sprite.new(2, 15, "○  攻撃")
    @@com_greet = Sprite.new(2, 17, "    あいさつ")
    @@com_item = Sprite.new(10, 15, "    アイテム")
    @@com_escape = Sprite.new(10, 17, "    逃げる")
    @@msg = Sprite.new(3, 15, "text")
    @@cursor = 0
    @@drawed = []
    @@enemy1 = Enemy.new("slime")
    @@show_enemy = Sprite.new(7, 1, ["ene", "HP||"])
    @@show_player = Sprite.new(2, 11, ["yu", "HP||"])
    @@count = 0
  end

  class << self
    def update
      system("cls")
      Scene.back if Key.down?(Key::ESCAPE)
      # $playerはinitializeで使えないため
      if @@count == 0
        @@show_enemy.text = self.text_persentage(@@enemy1)
        @@show_player.text = self.text_persentage($player)
        @@count = 1
      end

      @@drawed = [@@show_enemy, @@show_player]

      self.cursor_update

      if Key.down?(Key::RETURN)
        # system("cls")
        @@drawed << @@msg
        self.enemy_attack if $player.agility < @@enemy1.agility
        if @@cursor == 0
          self.attack
        elsif @@cursor == 1
          self.greet
        elsif @@cursor == 10
          self.item
        elsif @@cursor == 11
          self.escape
        end
        self.enemy_attack if $player.agility >= @@enemy1.agility && @@enemy1.hp >= 0
      else
        @@display.draw(@@drawed << [@@com_attack, @@com_greet, @@com_item, @@com_escape])
      end
    end

    def draw
      # @@display.draw(@@drawed)
      # p @@enemy1
      # p $player
    end

    def attack      
      damage = $player.attack - (@@enemy1.block * rand(0.7..1)).round
      damage = 0 if damage <= 0
      @@enemy1.hp -= damage

      damage = " #{damage}" if "#{damage}".length == 1
      p_enemy_hp = "#{@@enemy1.hp}"
      p_enemy_hp = (" " + p_enemy_hp) if "#{@@enemy1.hp}".length == 1

      @@msg.text = ["#{$player.name}の攻撃！", 
                    "#{@@enemy1.name}に#{damage}のダメージ！"]
      if @@enemy1.hp > 0
        @@msg.text += ["#{@@enemy1.name}のHP残り" + p_enemy_hp]
        self.msg_draw(1)
      else
        self.defeat
      end
      @@show_enemy.text = self.text_persentage(@@enemy1)
      @@show_player.text = self.text_persentage($player)
    end

    def greet
      puts "greet now"
    end

    def item
      puts "item now"
    end

    def escape
      puts "うまく逃げ切れた"
      Scene.close
    end

    def msg_draw(time)
      system("cls")
      @@display.draw(@@drawed)
      sleep(time)
    end

    def enemy_attack
      @@msg.text = "敵の攻撃"
      self.msg_draw(1)

      damage = @@enemy1.attack - ($player.block * rand(0.7..1)).round
      damage = 0 if damage <= 0
      $player.hp -= damage

      # 文字数調整
      damage = "#{damage}"
      ("#{damage}".length % 2).times do |i|
        damage = " " + damage
      end
      p_player_hp = "#{$player.hp}"
      ("#{$player.hp}".length % 2).times do |i|
        p_player_hp = " " + p_player_hp
      end

      @@msg.text = ["#{@@enemy1.name}の攻撃！", 
                    "#{$player.name}に#{damage}のダメージ！"]
      @@msg.text += ["#{$player.name}のHP残り" + p_player_hp] if $player.hp > 0
      
      @@show_enemy.text = self.text_persentage(@@enemy1)
      @@show_player.text = self.text_persentage($player)
      self.msg_draw(1)
    end

    def defeat
      @@msg.text = "#{@@enemy1.name}を倒した"
      self.msg_draw(1)
      @@msg.text = ["の経験値", "のお金を手に入れた"]
      self.msg_draw(1)
      system("cls")
      Scene.select(1)
    end

    def text_persentage(character)
      if character.hp < 0
        character.hp = 0
      else
        per = ((character.hp.to_f / character.max_hp.to_f) * 10).round
        gauge = ""
        10.times do |i|
          gauge += per > i ? "■" : "□"
        end
      end
      print_hp = "#{character.hp}"
      ("#{character.hp}".length % 2).times do |i|
        print_hp = " " + print_hp
      end
      print_max_hp = "#{character.max_hp}"
      ("#{character.max_hp}".length % 2).times do |i|
        print_max_hp = " " + print_max_hp
      end
      return ["#{character.name}  HP:#{print_hp}/#{print_max_hp}", "HP|#{gauge}|"]
    end
    
    def cursor_update
      if Key.down?(Key::UP) && (@@cursor % 10) == 1
        @@cursor -= 1
      elsif Key.down?(Key::DOWN) && (@@cursor % 10) == 0
        @@cursor += 1
      elsif Key.down?(Key::RIGHT) && @@cursor < 10
        @@cursor += 10
      elsif Key.down?(Key::LEFT) && @@cursor >= 10
        @@cursor -= 10
      end

      if @@cursor == 0
        @@com_attack.text = "○  攻撃"
        @@com_greet.text = "    あいさつ"
        @@com_item.text = "    アイテム"
        @@com_escape.text = "    逃げる"
      elsif @@cursor == 1
        @@com_attack.text = "    攻撃"
        @@com_greet.text = "○  あいさつ"
        @@com_item.text = "    アイテム"
        @@com_escape.text = "    逃げる"
      elsif @@cursor == 10
        @@com_attack.text = "    攻撃"
        @@com_greet.text = "    あいさつ"
        @@com_item.text = "○  アイテム"
        @@com_escape.text = "    逃げる"
      elsif @@cursor == 11
        @@com_attack.text = "    攻撃"
        @@com_greet.text = "    あいさつ"
        @@com_item.text = "    アイテム"
        @@com_escape.text = "○  逃げる"
      end
    end
  end
end
