class ConferenceSlotScheduler

	def self.get_the_schedule(remaining_conferences_to_schedule)
		empty_the_slots
		remaining_conferences_to_schedule.each do |x, y|
		@total_duration = @total_duration + y
			if morning_slot_condition
				@morning_slot_conferences[x] = y
			elsif evening_slot_condition
				@evening_slot_conferences[x] = y
			else
				@total_duration = @total_duration - y
				@remaining_conferences[x] = y 
			end
		end
		check_the_available_slot
		@all_scheduled_conferences
	end

	def self.sort_hash_by_descending(hash_to_sort)
	  hash_to_sort.sort_by { |_key, value| -value }.to_h
	end

	def self.initialize_and_sort_the_list_of_conferences(hash_to_sort)
		@all_scheduled_conferences = Array.new
		@morning_slot_fixed = false
		sort_hash_by_descending(hash_to_sort)
	end

	def self.empty_the_slots
		@total_duration = 0
		@morning_slot_conferences = {}
		@evening_slot_conferences = {}
		@remaining_conferences = {}
	end

	def self.morning_slot_condition
	  @total_duration <= 180 && !@morning_slot_fixed
	end

	def self.evening_slot_condition
	  @total_duration <= 240 && @morning_slot_fixed
	end

	def self.check_the_available_slot
		if !@morning_slot_fixed
		  	set_scheduled_for_morning
		else
			set_scheduled_for_evening
		end
	end

	def self.set_scheduled_for_morning
		@morning_slot_fixed = true
		@all_scheduled_conferences << @morning_slot_conferences
		get_the_schedule(@evening_slot_conferences.merge(@remaining_conferences)) if !@remaining_conferences.empty?
	end

	def self.set_scheduled_for_evening
		@morning_slot_fixed = false
		@all_scheduled_conferences << @evening_slot_conferences
		get_the_schedule(@morning_slot_conferences.merge(@remaining_conferences)) if !@remaining_conferences.empty?
	end

end