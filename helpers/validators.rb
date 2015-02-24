module Validators
  
  # Public: #validate_presence_of
  # Validates if the given argument is an empty string.
  #
  # Parameters:
  # string - String to validate
  #
  # Returns:
  # True/False
  #
  # State Changes:
  # None
  
  def validate_presence_of(string)
    string != ""
  end
  
end