require 'csv'
require 'yaml' 

file = ARGV[0]
data = CSV.read "#{file}", encoding:'iso-8859-1:utf-8'

class Column 
    def initialize data, field, limit = 10
        @data = data.clone
        @headers = @data.shift 
        @field = field 
        @limit = limit 

        @collector = Hash.new(0)
        @us = @data.map { |x| x[field] }
        @us.each do |thing|
            @collector[thing] += 1
        end
        @ordered = @collector.sort_by { |k, v| v }.reverse
        @title = @data[0][field]
        @title = @headers[field]
        @top = @ordered[0, @limit]

    end

    def to_s
        s = "  The top #{@top.count} results for #{@title} are:\n"

        @top.each do |entry|
            s += "    * #{entry[0]} (#{entry[1]} occurrences)\n"
        end

        s
    end
end

fields = YAML.load_file('conf.yaml')['fields']
results = []

fields.each do |field|
    results.push Column.new data, field 
end

puts 
puts "*" * 80
puts

puts "Data from #{File.basename file}:"
puts

results.each do |result|
    puts result
    puts
end


data.shift

raw_royalties = data.map { |row| row[-4] }
actual_money = raw_royalties.map { |r| r[4..-1].to_f }

puts "Possibly we made £%0.2f in sales, but it's hard to tell" % [actual_money.sum]

puts 
puts "*" * 80
puts

