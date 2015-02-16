module ClockIndicator
  class CalendarWindow
    def initialize
      add_calendars
    end

    delegate :show_all, :destroy, :to => :window

    private

      def window
        @window ||= Gtk::Window.new(:toplevel).tap do |window|
          window.set_position(Gtk::WindowPosition[:mouse])
          window.set_type_hint(Gdk::WindowTypeHint[:dock])
          window.add(hbox)
        end
      end

      def add_calendars
        hbox.add(last_month_calendar.calendar)
        hbox.add(current_month_calendar.calendar)
        hbox.add(next_month_calendar.calendar)
      end

      def hbox
        @hbox ||= Gtk::HBox.new(true, 10)
      end

      def last_month_calendar
        @last_month_calendar ||= LastMonthCalendar.new
      end

      def current_month_calendar
        @current_month_calendar ||= CurrentMonthCalendar.new
      end

      def next_month_calendar
        @next_month_calendar ||= NextMonthCalendar.new
      end
  end
end
