require 'fox16'
require_relative 'Nuevo_Error'
include Fox
class VentanaDoble < FXMainWindow

  @tabla = Array.new

  def initialize(app)
    super(app, "Errores", :width => 800, :height => 200)
    self.backColor ='purple'
    @combo = FXComboBox.new(self, 30, nil, :opts => LAYOUT_EXPLICIT, :x => 20, :y  => 100, :width => 600, :height => 30)
    btnAgregarE = FXButton.new(self, "Agregar a la tabla",:opts=> LAYOUT_EXPLICIT, :x =>640, :y=>100, :width=>150, :height=> 35)
    btnAgregarE.font = FXFont.new(app,"Modern, 120, BOLD, 0")
    btnNuevo = FXButton.new(self, "Nuevo error",:opts=> LAYOUT_EXPLICIT, :x =>640, :y=>150, :width=>150, :height=> 35)
    btnAgregarE.font = FXFont.new(app,"Modern, 120, BOLD, 0")
    #C:\Users\Babi\RubymineProjects\Automaatas1\src
    #C:\Users\Cynthia\Documents\VERANO 2016\AUTOMATAS II\Automaatas1\src
    #@archivoExcel="C:/Users/Babi/RubymineProjects/Automaatas1/src/ManejoERROR.xls"
    @archivoExcel="C:/Users/Cynthia/Documents/VERANO 2016/AUTOMATAS II/Automaatas1/src/ManejoERROR.xls"
    #@archivoExcel="C:/Users/Cynthia/Documents/VERANO 2016/AUTOMATAS II/Automaatas1/src/ManejoERROR.xls"


    obtenerE = @obtError


    @obj = ManejoArchivoExcel.new(@archivoExcel)
    @tabla = @obj.getDatos

    #puts 'contenido tablas es',tabla.getDatos
    puts "Filas> ", @obj.getNumFilas.to_s
    puts "Columnas> ", @obj.getNumColumnas.to_s

    llenaCombo

    btnAgregarE.connect(SEL_COMMAND) do
      puts item = @combo.currentItem

        puts @tabla[item][0].to_s
        @obtError = @tabla[item][0].to_s




    end

    btnNuevo.connect(SEL_COMMAND) do
      vetan = NuevoError.new(app)
      vetan.create
    end
    lblFondo = FXLabel.new(self,"", :opts=>LAYOUT_EXPLICIT, :x=>0, :y=>0, :width=>800, :height=>400)
    lblFondo.icon = FXJPGIcon.new(app, File.open("wall4.jpg","rb").read)
    lblFondo.layoutHints = LAYOUT_CENTER_X|LAYOUT_CENTER_Y

  end

  def llenaCombo
    puts "llena combo..."
    @combo.clearItems

    #0.upto(@obj.getFilas-2) do |i|
     # puts "VALOR> ", @tabla[i][1].to_s
    #end

    0.upto(@obj.getFilas-2) do |i|
      @combo.appendItem(@tabla[i][1].to_s)

    end



  end


#-----------------------------------------------
  def create
    super
    show(PLACEMENT_SCREEN)
  end
  def getNumeroError
    return @obtError
  end
end
