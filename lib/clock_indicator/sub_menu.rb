module ClockIndicator
  class SubMenu

    delegate :popup, :to => :menu

    private

      def menu
        @menu ||= Gtk::Menu.new.tap do |m|
          m.append(item)
          m.show_all
        end
      end

      def item
        @item ||= Gtk::MenuItem.new_with_label("Exit").tap do |i|
          i.signal_connect("activate") { Gtk.main_quit }
        end
      end
  end
end
