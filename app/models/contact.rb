class Contact < ActiveRecord::Base

	has_no_table

	column :name, :string
	column :email, :string
	column :content, :string

	validates_presence_of :name
	validates_presence_of :email
	validates_presence_of :content
	validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
	validates_length_of :content, :maximum => 500

	def update_spreadsheet
		connection = GoogleDrive.login(ENV["hoancai"], ENV["beginning"])
		ss = connection.spreadsheet_by_title('website_contact_messages')
		if ss.nil?
			ss = connection.create_spreadsheet('website_contact_messages')
		end

		ws = ss.worksheets[0]

		last_row = 1 + ws.num_rows
		ws[last_rows, 1] = Time.new
		ws[last_rows, 2] = self.name
		ws[last_rows, 3] = self.email
		ws[last_rows, 4] = self.content
		ws.save
	end

end