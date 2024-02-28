class CalllogMailer < ApplicationMailer
    def send_daily_stats(user_id)
      @user = User.find_by_id(user_id)
      return unless @user.present?
      @analysis = perform_analysis(user_id)
      mail(to: @user.email, subject: 'Call Analysis')
    end

    def perform_analysis(user_id)
        call_logs = CallLog.where(user_id: user_id)
    
        total_calls = call_logs.count
        average_duration = call_logs.average(:duration).to_i
        max_duration = call_logs.maximum(:duration).to_i
        top_contacts = call_logs.where.not(name: nil).group(:name).count.sort_by { |_, v| -v }.first(5).to_h
        call_times = call_logs.group_by { |c| c.call_start_time.hour }.transform_values(&:count)
        call_types = call_logs.group(:call_type).count
        call_patterns = call_logs.group(:name).pluck(:name).compact.uniq
    
        {
          total_calls: total_calls,
          average_duration: average_duration,
          max_duration: max_duration,
          top_contacts: top_contacts,
          call_times: call_times,
          call_types: call_types,
          call_patterns: call_patterns
        }
    end
end