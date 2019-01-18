require 'fox16'
include Fox

class CatalogoErrores < FXMainWindow
  def initialize(app)
    super(app,"Errores", :width=>900,:height =>400)
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
aplicacion = FXApp.new()
CatalogoErrores.new(aplicacion)
aplicacion.create
aplicacion.run