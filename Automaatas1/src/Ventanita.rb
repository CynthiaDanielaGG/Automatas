require 'fox16'
include Fox
class MensajeGrafico < FXMainWindow

  def initialize(app,titulo,mensaje,tabla,fila,columna,dato)

    ancho = ((mensaje.size * 4)+100)
    super(app, titulo, :width => ancho, :height => 100)

    lblMensaje = FXLabel.new(self, mensaje,:opts=>LAYOUT_EXPLICIT,:x=>0,:y=>15,:width => ancho,:height=>40)
    lblMensaje.justify = JUSTIFY_CENTER_X

   no = FXButton.new(self,"No",:opts=>LAYOUT_EXPLICIT,:x=>((ancho/2)-70),:y=>60,:width=>70,:height=>30)
   no.backColor = "lightblue"
   si  = FXButton.new(self,"Sí",:opts=>LAYOUT_EXPLICIT,:x=>((ancho/2)+10),:y=>60,:width=>70,:height=>30)
   si.backColor = "lightblue"

    no.connect(SEL_COMMAND) do
      close
    end

    si.connect(SEL_COMMAND) do
     tabla.setItemText(fila,columna,dato)
      close
    end

    create


  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
