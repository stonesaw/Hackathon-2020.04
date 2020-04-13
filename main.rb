#ruby -Ku

require_relative './Monochrome-Ruby'
require_relative './scene-eitor'
require_relative './scenes/title'
require_relative './scenes/field'
require_relative './scenes/shop'

Scene.new([
  Title,
  Field,
  Shop
])

loop do
  Key.update

  break if Key.down?(Key::ESCAPE) && Scene.current == 0

  Scene.update
  Scene.draw
end