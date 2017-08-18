require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    #why does the below statement work to satisfy the second condition?
    return @columns unless @columns.nil?
    result = DBConnection.execute2(<<-SQL)
    SELECT
    *
    FROM
    #{table_name}
  SQL

    @columns = result.first.map{ |el| el.to_sym}

  end

  def self.finalize!

    self.columns.each do |col|
      define_method(col) do
             self.attributes[col]
           end
      define_method("#{col}=") do |value|
        self.attributes[col] = value
        end
      end


  end

  def self.table_name=(table_name)
   "@#{table_name}".tableize
  end

  def self.table_name
    @table_name ||= "#{self}s".tableize
  end

  def self.all
    result = {}
    @params.each do |el|
      el
    end

  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})

  end

  def attributes
    @attributes ||= {}

  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
