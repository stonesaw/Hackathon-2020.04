class Menu
  def initialize    
  end

  class << self
    def update
      system("cls")
      Scene.next(init: true) if Key.down?(Key::RETURN)
      Scene.back if Key.down?(Key::ESCAPE)
    end

    def draw
      puts "menu!"
    end
  end
end
