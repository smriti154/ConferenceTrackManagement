class ConferenceTrackerController < ApplicationController

  def upload_list_of_conferences
  end

  def get_conferences_schedules
    @all_scheduled_conferences = Hash.new
    upload_text_file_contents(params[:file])
    if !@hash_of_conferences.empty?
      @all_scheduled_conferences = ConferenceSlotScheduler.initialize_and_sort_the_list_of_conferences(@hash_of_conferences)
      @all_scheduled_conferences = ConferenceSlotScheduler.get_the_schedule(@all_scheduled_conferences)
    end
  end

  def upload_text_file_contents(uploaded_file)
    @hash_of_conferences = {}
    if uploaded_file.original_filename.to_s.include? ".txt"
      File.open(uploaded_file.path) do |fp|
        fp.each do |line|
          key = line.scan(/./).join('').scan(/\D/).join('').split('min')
          value = line.scan(/\d/).join('').to_i
          @hash_of_conferences[key[0]] = value
        end
      end
    end
  end

end