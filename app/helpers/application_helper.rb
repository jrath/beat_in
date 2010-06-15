# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def display_beat_content(beat)
    content = h beat.content
    if beat.source_beat # beat has a source so it is a comment
      replied_to, reply = beat.content.split(' ',2)
      content = "@<a href=\"#{profile_user_url(:id => beat.source_beat.user_id)}\">#{h replied_to[1..-1]}</a> " + h(reply)
    end
    return content
  end
end
