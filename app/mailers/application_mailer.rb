class ApplicationMailer < ActionMailer::Base
    add_template_helper(EmailHelper)
    default from: '\'videorRehearser\' <notification@videorehearser.com>'
    before_action :set_base_url


	def set_base_url
		if Rails.env.development?
			@base = "http://localhost:3000"
		elsif Rails.env.test?
			@base = "https://testing.videorehearser.com"
		else
			@base = "https://v1.videorehearser.com"
		end
		# @image = "default.jpg"
	end

	def mailer_formats(f)
		f.html{ render layout: 'mailer_layout.html.erb' }
		# format.text
	end
end
