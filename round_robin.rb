#!/usr/bin/env ruby

class Schedule
	attr_reader :teams, :weeks, :schedule, :schedule_table

	# create a new empty schedule with given teams, and weeks.
	def initialize(teams, weeks)
		raise "Teams needs to be a even number" unless teams % 2 == 0
		raise "Need at least 1 week" unless weeks >= 1
		@teams = teams
		@weeks = weeks
		@schedule = []
	end
	# prints the schedule in a csv format
	def to_csv(io = $stdout)
		io.puts "#Round Robin Tournament Schedule"
		io.printf "#%s Teams, %s Weeks\n", teams, weeks
		io.puts "#week, home_team, away_team"
		
		schedule.each do |game|
			io.printf "%s,%s,%s\n", game["week"], game["home_team"], game["away_team"]
		end
	end
end

class RoundRobinSchedule < Schedule

	# generate schedule via cyclic algorithm
	def create
		locked_item = teams - 1
		weeks.times do |week|
			week_array = []
			week_array << locked_item + 1

			(teams - 1).times do |i|
				week_array << ((week + i) % (teams - 1)) + 1
			end

			(1..teams/2).each do |i|
				even_odd_game = i % 2
			
				if i == 1
					if week % 2 == 0
						game = {"week" => week + 1, "home_team" => week_array.first, "away_team" => week_array.last}
					else
						game = {"week" => week + 1, "home_team" => week_array.last, "away_team" => week_array.first}
					end
				else
					if i % 2 == 0
						game = {"week" => week + 1, "home_team" => week_array.first, "away_team" => week_array.last}
					else
						game = {"week" => week + 1, "home_team" => week_array.last, "away_team" => week_array.first}
					end
				end
				week_array.shift
				week_array.pop
				schedule << game
			end
		end
	end
end


puts "Round Robin Generator Example"
puts
schedule = RoundRobinSchedule.new(16,17)
schedule.create
schedule.to_csv