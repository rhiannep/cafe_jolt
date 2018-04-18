class MenuItem
  def initialize(kitchen_response)
    @id = kitchen_response["id"]
    @name = kitchen_response["name"]
    @description = kitchen_response["description"]
    @stock_level = kitchen_response["stock_level"]
  end

  def self.parse_kitchen_response(kitchen_response)
    kitchen_response.parsed_response["menu_items"].map do |item|
      self.new(item)
    end
  end

  attr_reader :name, :description, :stock_level
end
