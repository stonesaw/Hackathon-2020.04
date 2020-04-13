class Shop
  def initialize    
  end

  class << self
    def update
      system("cls")
      Scene.back if Key.down?(Key::ESCAPE)
    end

    def draw
      puts "shop!"
    end
  end
end
