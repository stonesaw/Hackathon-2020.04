class Player
  attr_accessor :name, :hp, :max_hp, :mp, :max_mp, :attack, :block, :agility, :money, :exp, :item_list
  
  def initialize(name)
    @name = name
    @max_hp = 100
    @hp = 100
    @max_mp = 60
    @mp = 60
    @attack = 20
    @block = 20
    @agility = 20
    @money = 1000
    @exp = 0
    @item_list = []
  end
end


class Text
  class << self
    def insert(text, num: 1, ins: " ")
      text = text.to_s
      width_ = width(text)
      if num == 1
        return (width_ % 2) == 1 ? text + ins : text
      else
        re = text
        (num - width_).times do
          re = ins + re
        end
        return re
      end
    end

    def add(text, num: 1, add: " ")
      text = text.to_s
      width_ = width(text)
      if num == 1
        return (width_ % 2) == 1 ? text + add : text
      else
        re = text
        (num - width_).times do
          re += add
        end
        return re
      end
    end

    def width(text)
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
          width += 2
        end
      end
      return width
    end
  end
end
