require 'gtk3'

class RubyApp < Gtk::Window

  def initialize
    super
    init_ui
  end

  def init_ui

    override_background_color :normal, Gdk::RGBA::new(0.2, 0.2, 0.2, 1)

    begin
      bardejov = Gdk::Pixbuf.new :file => "d.jpg"

    rescue IOError => e
      puts e
      puts "cannot load images"
      exit
    end

    image1 = Gtk::Image.new :pixbuf => bardejov


    fixed = Gtk::Fixed.new

    fixed.put image1, 0, 0


    add fixed

    set_title "Bienvenido"
    signal_connect "destroy" do



      load "Interface.rb"

      app = FXApp.new
      Interface.new(app)
      app.create
      app.run
    end

    set_default_size 290, 290
    window_position = :center

    show_all
  end
end

Gtk.init
window = RubyApp.new
Gtk.main