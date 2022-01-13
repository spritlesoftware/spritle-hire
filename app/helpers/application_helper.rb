module ApplicationHelper
  def get_date_format(datetime)
    date = datetime.present? ? datetime.strftime("%d-%m-%Y") : ""
  end

  def get_remaining_hours_string(test_time)
    current_time = Time.now
    seconds_diff = (test_time - current_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    return (hours == 1 ? "#{hours} hr ago" : (hours > 1 ? "#{hours} hrs ago" : (minutes == 1 ? "#{minutes} min ago" : minutes > 1 ? "#{minutes} mins ago": (seconds > 10 ? "#{seconds} secs ago" : "just now"))))
  end

  def trim_text(text_string)
    if text_string.length > 20
      text_string.match(/^.{0,20}\b/)[0] + "..."
    else
      text_string
    end
  end

  def user_gravatar(user)
    if user.user_type == "admin"
      hash = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{hash}.png"
      image_tag(gravatar_url, alt: user.name)
    else
      name = user.name
      size = 128
      length = 1
      bold = true
      color = "ffffff"
      bgcolor = "%06x" % (rand * 0xffffff) 

      gravatar_url = "https://ui-avatars.com/api/?name=#{name}&size=#{size}&length=#{length}&bold=#{bold}&color=#{color}&background=#{bgcolor}"
      image_tag(gravatar_url, alt: user.name)
    end
  end
end
