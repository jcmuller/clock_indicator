module ClockIndicator
  class SubMenu

    delegate :popup, :to => :menu

    def set_time(time)
      time_item.set_label(time)
    end

    private

      def menu
        @menu ||= Gtk::Menu.new.tap do |m|
          m.append(time_item)
          m.append(separator)
          m.append(exit_item)
          m.show_all
        end
      end

      def time_item
        @time_item ||= Gtk::MenuItem.new.tap do |i|
          # Not selectable
          i.signal_connect("select") { i.deselect }
        end
      end

      def separator
        @separator ||= Gtk::SeparatorMenuItem.new
      end

      def exit_item
        @exit_item ||= Gtk::MenuItem.new_with_label("Quit").tap do |i|
          i.signal_connect("activate") { Gtk.main_quit }
        end
      end

  end
end
