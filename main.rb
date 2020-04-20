#! ruby -Ku

require 'json' # usin './data/enemies.json'
require "fileutils" # using './scenes/menu.rb'
require_relative './Monochrome-Ruby' # メインのライブラリ
require_relative './scene-eitor' # シーン用クラス
require_relative './general-class' # 汎用クラス

$enemies_data = open('./data/enemies.json') do |i|
  JSON.load(i)
end
require_relative './data/items'
require_relative './data/random-names'
$save_data = [0, 9, 9]

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

loop do
  Key.update

  break if Key.down?(Key::ESCAPE) && Scene.current == 0

  Scene.update
  Scene.draw
end