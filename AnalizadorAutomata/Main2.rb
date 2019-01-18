require 'fox16'
load 'ManejoCadena.rb'
include Fox

class Interface < FXMainWindow
  def initialize(app)
    super(app, "Analizador Lexico" , :width => 500, :height => 500)

    #MENU
    menu_bar = FXMenuBar.new(self,LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
    file_menu_pane = FXMenuPane.new(self)
    file_open = FXMenuCommand.new(file_menu_pane, "Open..." )
    file_exit = FXMenuCommand.new(file_menu_pane, "Exit...")
    file_menu_title = FXMenuTitle.new(menu_bar, "File" , :popupMenu => file_menu_pane)

    file_open.connect(SEL_COMMAND) do

      dialog = FXFileDialog.new(self, "Open File" )
      dialog.patternList = ["Archivo de Texto (*.txt)"]
      dialog.selectMode = SELECTFILE_MULTIPLE
      if dialog.execute != 0
        puts dialog.filename
        leerArchivo(dialog.filename)
      end

    end

    file_exit.connect(SEL_COMMAND) do
      exit
    end

    #frame = FXVerticalFrame.new(self, :opts => LAYOUT_FILL)
    #text = FXText.new(frame, :opts => TEXT_READONLY|LAYOUT_FILL_X)


    @table = FXTable.new(self, :opts => LAYOUT_FILL)
    @table.setTableSize(30,2)
    @table.horizontalGridShown = false
    @table.setColumnText(0, "TOKEN")
    @table.setColumnText(1, "LEXEMA")
    #table.editable = false




  end

  def leerArchivo(file_name)

    f = File.open(file_name)

    f.each do |i|
      #puts "#{f.lineno}: #{i}"
      puts i

    end
    f.close

  end

  def analizar(mensaje)
    mCadena = ManejoCadena.new()
    arreglo = mCadena.separarSimbolos(mensaje)
    bandera=0
    ij = 0
    #table.setItemText(0, 0,"Hola")
    arreglo.each { |i|
      puts i

      if mCadena.isAsignacion(i)
        puts "operador de asigancion: #{i}"
        @table.setItemText(ij,0,"Op. Asignacion")
        @table.setItemText(ij,1,i.to_s)
        bandera=1
        ij += 1
      elsif mCadena.isPuntoComa(i)
        puts "punto y coma: #{i}"
        @table.setItemText(ij,0,"Punto y Coma")
        @table.setItemText(ij,1,i.to_s)
        bandera=1
        ij += 1
      elsif mCadena.isSeparadores(i)
        puts "separador: #{i}"
        @table.setItemText(ij,0,"Seperador")
        @table.setItemText(ij,1,i.to_s)
        bandera=1
        ij += 1
      else
        bandera=0
      end

      if bandera == 0
        array = mCadena.separarOperadores(i)
        array.each { |j|
          puts j
          if mCadena.isOperador(j)
            puts "operador aritmetico: #{j}"
            @table.setItemText(ij,0,"Op. Aritmetico")
            @table.setItemText(ij,1,j.to_s)
            bandera=1
            ij += 1
          elsif mCadena.isAsignacion(j)
            puts "operador de asigancion: #{j}"
            @table.setItemText(ij,0,"Op. Asignacion")
            @table.setItemText(ij,1,j.to_s)
            bandera=1
            ij += 1
          elsif mCadena.isIgual(j)
            puts "Operador de Asignacion: #{j}"
            @table.setItemText(ij,0,"Op. Asignacion")
            @table.setItemText(ij,1,j.to_s)
            bandera = 1
            ij += 1
          elsif mCadena.analizarIdentificador(j)
            puts "identificador: #{j}"
            @table.setItemText(ij,0,"Identificador")
            @table.setItemText(ij,1,j.to_s)
            bandera=1
            ij += 1
          elsif mCadena.analizarNumero(j)
            puts "numero #{j}"
            @table.setItemText(ij,0,"Numero")
            @table.setItemText(ij,1,j.to_s)
            bandera=1
            ij += 1
          end
        }
      end
    }
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end


end

app = FXApp.new
Interface.new(app)
app.create
app.run