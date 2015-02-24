require 'minitest/autorun'
require 'sqlite3'
require 'rubygems'
require 'active_support/inflector'

DATABASE = SQLite3::Database.new("./tests/person_test.db")
require_relative '../database/database_setup'

require_relative '../database/database_functionality'
require_relative '../models/person'

class DatabaseMethodsTest < Minitest::Test
  
  def setup
    DATABASE.execute("DELETE FROM people")
    DATABASE.execute("DELETE FROM panels")
    DATABASE.execute("DELETE FROM conventions")
  end
  
  # Testing .insert
  
  def test_person_receives_id_when_inserted
    test = Person.new({"name" => "Andrew", "username" => "ADStrovers", "password" => "Testing123"})
    test.insert
    
    assert_kind_of Integer, test.id
  end
  
  # Testing .all as well as initializing built on top of .insert passing before.
  
  def test_people_name_should_be_equal_to_passed_in_name
    test = Person.new({"name" => "Erin", "username" => "eskoog", "password" => "rawr"})
    test.insert
    people = Person.all
    
    assert_equal "Erin", people[-1].name
  end
  
  # Testing .save method.
  
  def test_person_name_should_change_after_save
    test = Person.new({"name" => "Cindy", "username" => "CLStrovers", "password" => "rawr2"})
    test.insert
    test.name = "Cindy Strovers"
    test.save
    people = Person.all
    
    assert_equal "Cindy Strovers", people[-1].name
  end
  
  # Testing .delete function
  
  def test_should_properly_delete_record_from_database
    DATABASE.execute("DELETE FROM people")
    test = Person.new({"name" => "David", "username" => "DEStrovers", "password" => "rawr2"})
    test.insert
    first_assert = Person.search_for("id", test.id)
    
    assert_equal first_assert[0].id, test.id
    
    Person.delete(test.id)
    second_assert = Person.search_for("id", test.id)
    
    assert_equal Array.new, second_assert
  end
  
  def test_object_should_not_return_an_id_with_requirements
    test = Person.new({"name" => "Erin Skoog", "username" => "eskoog87", "password" => "test"})
    req = test.requirements
    
    assert !req.include?("id")
    assert req.include?("name")
    
    req = test.requirements_with_id
    
    assert req.include?("id")
  end
  
  
  
end