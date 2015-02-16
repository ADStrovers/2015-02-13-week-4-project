class Character
  
  def initialize(options)
    @generic_stat = options["generic_stat"]
    @str = options["str"] ||= @generic_stat
    @con = options["con"] ||= @generic_stat
    @dex = options["dex"] ||= @generic_stat
    @damaged = 0
    @inventory = []
  end
  
  def calculate_current_hp
    @current_hp = @max_hp - @damaged
  end
  
  def calculate_max_hp
    @max_hp = @con * 2 + (@str / 2).floor
  end
  
  def add_to_inventory(*items)
    items.each{ |item| @inventory << item }
  end
  
end