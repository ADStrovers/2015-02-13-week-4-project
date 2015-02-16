class Inventory
  
  def initialize
    @weapon = options["weapon"]
    @armor = options["armor"]
    @space = []
  end
  
  def equip_weapon(item)
    if @space.include?(item)
      @weapon = item if item.is_a? Weapon
      true
    else
      false
    end
    
end