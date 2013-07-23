$ ->
	$(document).foundation()

	$('#grub_session_invite_emails').tokenInput '/friends.json',
		preventDuplicates: true
		allowFreeTagging: true
		allowTabOut: true
		breakOnSpace: true

	$('#invite_vote_restaurant_id').tokenInput '/restaurants.json',
		preventDuplicates: true
		allowFreeTagging: true
		allowTabOut: true
		tokenLimit: 1
		resultsFormatter: (item) ->
			string = item[@propertyToSearch]
			"""
			<li>
				#{if @enableHTML then string else _escapeHTML(string)}
				<br>
				<p>#{item['description']}</p>
			</li>
			"""
