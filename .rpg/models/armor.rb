class Armor
  
  def initialize(options)
    @name = options["name"]
    @reduction_dice_size = options["reduction_dice_size"]
    @reduction_dice_amount = options["reduction_dice_amount"]
    @dex_mod = options["dex_mod"]
  end
  
end