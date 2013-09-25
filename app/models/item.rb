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
    if index == 0
      where_clause += "(#{value[:columns]} #{value[:operand]} '#{value[:column_value]}' "
    else
      where_clause += " #{value[:and_or]} #{value[:columns]} #{value[:operand]} '#{value[:column_value]}' "
    end
  end
  where_clause += ') AND (search_name is null)'
  where(where_clause)
 end

end
