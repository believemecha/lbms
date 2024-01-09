class StatsMailer < ApplicationMailer
  def date_wise_stats(organization_id)
    date = Time.current.in_time_zone('Mumbai')
    @organization = Organization.find_by_id(organization_id)

    return if @organization.nil?

    subject = "Weekly Summary"

    @user_stats = {}
    total_stats = { incoming: 0, outgoing: 0, missed: 0, declined: 0 }

    @organization.users.each do |user|
      user_call_logs = @organization.call_logs.where(
        "user_id = ? AND call_start_time >= ? AND call_start_time <= ?",
        user.id, date.beginning_of_week, date.end_of_week
      )

      user_stats = user_call_logs.group(:call_type).count

      @user_stats[user] = user_stats
      total_stats[:incoming] += user_stats["incoming"].to_i
      total_stats[:outgoing] += user_stats["outgoing"].to_i
      total_stats[:missed] += user_stats["missed"].to_i
      total_stats[:declined] += user_stats["declined"].to_i
    end

    @total_stats = total_stats
    @total_stats[:date] = date

    mail(
      from: "lbsingh732196@gmail.com",
      to: ["lbsingh732196@gmail.com"],
      subject: subject
    )
  end
end
