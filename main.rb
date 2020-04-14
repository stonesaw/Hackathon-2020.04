#ruby -Ku

require_relative './Monochrome-Ruby'
require_relative './scene-eitor'
require_relative './scenes/title'
require_relative './scenes/field'
require_relative './scenes/menu'
require_relative './scenes/shop'
require_relative './scenes/battle'

Scene.new([
  Title,
  Field,
  Menu,
  Shop,
  Battle
])

class Player
  attr_accessor :name, :money, :hp, :max_hp, :attack, :mp, :max_mp, :block
  
  def initialize(name)
    @name = name
  end
end

loop do
  Key.update

  break if Key.down?(Key::ESCAPE) && Scene.current == 0

  Scene.update
  Scene.draw
end