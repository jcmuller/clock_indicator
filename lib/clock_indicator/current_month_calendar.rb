module ClockIndicator
  class CurrentMonthCalendar
    def calendar
      @calendar ||= Gtk::Calendar.new.tap do |c|
        c.month = Time.now.month - 1
      end
    end
  end
end
