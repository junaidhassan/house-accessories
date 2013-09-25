class Item < ActiveRecord::Base

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     Item.create! row.to_hash
    end
  end



def self.search(options = {})
  where_clause = ''
  keycount = options.keys.count
  options.each_with_index do |(key,value),index|
    if index == keycount - 1
      where_clause += "#{value[:columns]} #{value[:operand]} '#{value[:column_value]}'"
    else
      where_clause += "#{value[:columns]} #{value[:operand]} '#{value[:column_value]}' #{value[:and_or]} "
    end
  end
  where(where_clause)
 end

end
