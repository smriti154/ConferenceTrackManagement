require 'rails_helper'

RSpec.describe ConferenceTrackerController, :type => :controller do

	describe "GET upload_list_of_conferences" do

		it "fetches all account announcements and returns http success" do
			get :upload_list_of_conferences
			expect(response.status).to eq(200)
			expect(response).to render_template(:upload_list_of_conferences)
		end
	end

	describe "POST get_conferences_schedules" do

		it "gets the scheduled conference lists when .txt file is input" do
			file = ActionDispatch::Http::UploadedFile.new({:tempfile => File.new("#{Rails.root}/public/Rspec_Test_Input.txt")})
			file.original_filename = "Rspec_Test_Input.txt"
			params = {"file" => file }
			expect(ConferenceSlotScheduler).to receive(:get_the_schedule).with(sorted_input).and_return(expected_output)
			post :get_conferences_schedules, params
			expect(response.status).to eq(200)
		end

		it "gets the scheduled conference lists when other than .txt file is input" do
			file = ActionDispatch::Http::UploadedFile.new({:tempfile => File.new("#{Rails.root}/public/Wrong_format_input.rtf")})
			file.original_filename = "Wrong_format_input.rtf"
			params = {"file" => file }
			post :get_conferences_schedules, params
			expect(response.status).to eq(200)
		end

	end

	def sorted_input
		{"Test E "=>60, "Test F "=>60, "Test G "=>60, "﻿Test A "=>50, "Test D "=>40, "Test C "=>30, "Test B "=>3}
	end
	
	def expected_output
		[{"Test E "=>60, "Test F "=>60, "Test G "=>60},{"﻿Test A "=>50, "Test D "=>40, "Test C "=>30, "Test B "=>3}]
	end

end