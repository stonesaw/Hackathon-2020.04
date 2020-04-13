class Title
  def initialize
  end

  class << self
    def update
      system("cls")
      Scene.next if Key.down?(Key::RETURN)
    end

    def draw
      puts "title!"
    end
  end
end
