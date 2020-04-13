class Battle
  def initialize    
  end

  class << self
    def update
      system("cls")
      Scene.close if Key.down?(Key::RETURN)
      Scene.back if Key.down?(Key::ESCAPE)
    end

    def draw
      puts "field!"
    end
  end
end
      