#ruby -Ku

require 'json'
require_relative './Monochrome-Ruby'
require_relative './scene-eitor'

$enemies_data = open('./data/enemies.json') do |io|
  JSON.load(io)
end
require_relative './data/random-names'
require_relative './data/items'


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
  attr_accessor :name, :money, :hp, :max_hp, :mp, :max_mp, :attack, :block, :agility
  
  def initialize(name = "yusya ")
    @name = name
    @money = 1000
    @max_hp = 100
    @hp = 100
    @max_mp = 60
    @mp = 60
    @attack = 20
    @block = 20
    @agility = 20
  end
end

$player = Player.new

loop do
  Key.update

  break if Key.down?(Key::ESCAPE) && Scene.current == 0

  Scene.update
  Scene.draw
end