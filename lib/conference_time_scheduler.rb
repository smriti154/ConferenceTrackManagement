class ConferenceTimeScheduler

	def self.set_time_according_to_slot(conference_list, slot_name)
		hash = {}
		set_start_time_for_conference(slot_name)
		conference_list.each do |x, y|
			hash[@conference_start_time.strftime("%H:%M")] = x
			@conference_start_time = @conference_start_time + y.minutes
		end
		hash
	end

	def self.set_start_time_for_conference(slot_name)
		if slot_name == "Morning" 
			@conference_start_time = "9:00"
		else
			@conference_start_time = "1:00"
		end
		@conference_start_time = Time.parse(@conference_start_time)
	end

end