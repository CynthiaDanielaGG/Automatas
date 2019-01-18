require 'fox16'
include Fox

class NuevoError < FXMainWindow
  def initialize(app)
    super(app, "Nuevo error", :width=>500, :height=>200)

    descripcion = FXLabel.new(self, "Escribe la descripcion del error" , :opts => LAYOUT_EXPLICIT, :x => 150, :y => 30, :width => 180, :height => 25)
    desTxt = FXTextField.new(self, 20, nil, :opts => LAYOUT_EXPLICIT, :x => 50, :y => 70, :width =>400, :height => 25)
    btnAgregaNE = FXButton.new(self, "Agregar", :opts => LAYOUT_EXPLICIT, :x => 200, :y => 110, :width => 90, :height => 25)
    btnAgregaNE.backColor = 'gray'

    lblFondo = FXLabel.new(self,"", :opts=>LAYOUT_EXPLICIT, :x=>0, :y=>0, :width=>500, :height=>200)
    lblFondo.icon = FXJPGIcon.new(app, File.open("wall4.jpg","rb").read)
    lblFondo.layoutHints = LAYOUT_CENTER_X|LAYOUT_CENTER_Y







  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

end
