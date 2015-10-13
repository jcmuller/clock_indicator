module ClockIndicator
  class CalendarWindow
    def initialize
      add_calendars
    end

    delegate :show_all, :destroy, :to => :window

    private

      CAL_WIDTH = 350

      def cals_in_window
        [(Gdk::Screen.width / CAL_WIDTH) / 2, 3].min
      end

      def window
        @window ||= Gtk::Window.new(:toplevel).tap do |window|
          window.position  = Gtk::WindowPosition[:mouse]
          window.type_hint = Gdk::WindowTypeHint[:dock]
          window.add(hbox)
        end
      end

      def add_calendars
        cals_in_window.downto(1).each do |i|
          hbox.add(LastMonthCalendar.new(i).calendar)
        end

        hbox.add(current_month_calendar.calendar)

        1.upto(cals_in_window).each do |i|
          hbox.add(NextMonthCalendar.new(i).calendar)
        end
      end

      def hbox
        @hbox ||= Gtk::HBox.new(true, 10)
      end

      def current_month_calendar
        @current_month_calendar ||= CurrentMonthCalendar.new
      end

  end
end
