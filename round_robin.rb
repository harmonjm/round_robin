#!/usr/bin/env ruby

class Schedule
	attr_reader :teams, :weeks, :schedule

	# create a new empty schedule with given teams, and weeks.
	def initialize(teams, weeks)
		raise "Teams needs to be a even number" unless teams % 2 == 0
		raise "Need at least 1 week" unless weeks >= 1
		@teams = teams
		@weeks = weeks
		@schedule = []
	end
	# prints the schedule
	#~ def print(io = $stdout)
		#~ io.puts "schedule:"
		#~ w = 0
		#~ schedule.each do |week|
			#~ io.printf "%4d: ", w
			#~ io.puts
			#~ w += 1
		#~ end
	#~ end
end

class RoundRobinSchedule < Schedule

	# generate schedule via cyclic algorithm
	def generate	
		locked_item = teams - 1
		weeks.times do |week|
			week_array = []
			#~ puts "Week #{week}"
			week_array << "#{week + 1}:"
			week_array << locked_item + 1

			(teams - 1).times do |i|
				week_array << ((week + i) % (teams - 1)) + 1
			end
			
			for x in week_array
				print x.to_s + " "
			end
			puts
		end

	end
end


puts "Round Robin Generator"

schedule = RoundRobinSchedule.new(16,17)
schedule.generate
#~ schedule.print