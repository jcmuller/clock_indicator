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
        Time.now.to_s
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
            sub_menu.popup(nil, nil, nil, nil, event.button, event.time)
          end
        end
      end

      def toggle_calendar
        if @calendar_window.nil?
          calendar_window.show_all
        else
          calendar_window.destroy
          @calendar_window = nil
        end
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
        run_in_gtk = Proc.new do
          gtk_update_ui
        end
        GLib.idle_add(GLib::PRIORITY_DEFAULT_IDLE, run_in_gtk, nil, nil)
      rescue Exception => e
        show_notification("Clock.rb error", "#{e.class}: #{e.message}")
      end

      def gtk_update_ui
        tray_label.set_markup(time)
        tray_icon.set_tooltip_text(tooltip_status)
      end

      def show_notification(title, message)
        dialog = Gtk::Dialog.new
        dialog.set_title(title)
        label = Gtk::Label.new(message)
        dialog.get_content_area.add(label)
        dialog.add_button('_OK', -1)  # GTK_RESPONSE_NONE == -1
        GObject.signal_connect(dialog, 'response') do |d, response_id, user_data|
          d.destroy
        end
        dialog.show_all
      end
  end
end
