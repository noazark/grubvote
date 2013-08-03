module DeliversBulkMail
	extend ActiveSupport::Concern

	module ClassMethods
		def deliver_builk_mail(mail)
			if delivery_method === :postmark
				client = Postmark::ApiClient.new(ENV['POSTMARK_API_KEY'])
				client.deliver_messages mail
			else
				mail.each(&:deliver)
			end
		end
	end
end