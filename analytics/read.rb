require 'csv'
require 'yaml'

file = ARGV[0]
data = CSV.read "#{file}", encoding:'iso-8859-1:utf-8'

class Column 
    def initialize data, field, limit = 3
        @data = data 
        @field = field 
        @limit = limit 

        @collector = Hash.new(0)
        @us = data.map { |x| x[field] }
        @us.each do |thing|
            @collector[thing] += 1
        end
        @ordered = @collector.sort_by { |k, v| v }.reverse
        @title = @data[0][field]
        @top = @ordered[0, @limit]

    end

    def to_s
        s = "  The top #{@limit} results for #{@title} are:\n"

        @top.each do |entry|
            s += "    * #{entry[0]} (#{entry[1]} occurences)\n"
        end

        s
    end
end

fields = [8, 9, 24]
fields
results = []

fields.each do |field|
    results.push Column.new data, field 
end

puts "Data from #{File.basename file}:"
puts

results.each do |result|
    puts result
    puts
end


data.shift

raw_royalties = data.map { |row| row[-4] }
actual_money = raw_royalties.map { |r| r[4..-1].to_f }

puts "Possibly we made £#{actual_money.sum} in sales, but it's hard to tell"
