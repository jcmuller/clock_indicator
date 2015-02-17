module ClockIndicator
  class Clock
    def initialize
      set_ui
      setup_callbacks
      start_update_thread
    end

    private

      def set_ui
        tray_icon.show_all
        gtk_update_ui
      end

      def tray_icon
        @tray_icon ||= Gtkti::TrayIcon.new("ClockIndicator::Clock").tap do |ti|
          ti.add(event_box)
          ti.set_tooltip_text(tooltip_status)
        end
      end

      def event_box
        @event_box ||= Gtk::EventBox.new.tap do |eb|
          eb.add(tray_label)
        end
      end

      def tooltip_status
        Time.new.to_s
      end

      def time_item_text
        Time.new.strftime("%A, %B %e, %Y %I:%M:%S %P")
      end

      def sub_menu
        @sub_menu ||= SubMenu.new
      end

      def setup_callbacks
        GObject.signal_connect(event_box, "button-press-event") do |_, event, _|
          case event.button
          when 1
            toggle_calendar
          when 3
            popup_sub_menu(event)
          end
        end
      end

      def pos(event)
        proc { [event.x_root, 19] }
      end

      def toggle_calendar
        if @calendar_window.nil?
          calendar_window.show_all
        else
          calendar_window.destroy
          @calendar_window = nil
        end
      end

      def popup_sub_menu(event)
        gtk_update_ui
        sub_menu.popup(nil, nil, pos(event), nil, event.button, event.time)
      end

      def calendar_window
        @calendar_window ||= CalendarWindow.new
      end

      def tray_label
        @tray_label ||= Gtk::Label.new("")
      end

      def font
        Pango::FontDescription.from_string("Ubuntu 10")
      end

      def time
        Time.new.strftime(time_format)
      end

      def time_format
        "%a %m/%d/%Y <b>%I:%M%P</b>"
      end

      def start_update_thread
        Thread.new do
          check_interval_sec = 5
          loop do
            update_ui
            sleep(check_interval_sec)
          end
        end
      end

      def update_ui
        run_in_gtk = proc { gtk_update_ui }
        GLib.idle_add(GLib::PRIORITY_DEFAULT_IDLE, run_in_gtk, nil, nil)
      end

      def gtk_update_ui
        tray_label.set_markup(time)
        tray_icon.set_tooltip_text(tooltip_status)
        sub_menu.set_time(time_item_text)
      end

  end
end
