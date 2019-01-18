require 'fox16'
load 'ManejoCadena.rb'
include Fox

class Interface < FXMainWindow

  def getIcon(filename)
    begin
      filename = File.join("C:/Users/Jonhy/RubymineProjects/AnalizadorAutomata/", filename)
      icon = nil
      File.open(filename, "rb") { |f|
        icon = FXPNGIcon.new(getApp(), f.read)
      }
      icon
    rescue
      raise RuntimeError, "Couldn't load icon: #{filename}"
    end
  end

  def initialize(app)
    super(app, "Analizador Lexico" , :width => 500, :height => 500)

    #ICONOS
    opens = getIcon("folder.png")
    #MENU

    menu_bar = FXMenuBar.new(self,LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
    file_menu_pane = FXMenuPane.new(self)

    question_icon =FXPNGIcon.new(app, File.open("open2.png", "rb").read)
    save_icon =FXPNGIcon.new(app, File.open("disk.png", "rb").read)
    file_open = FXMenuCommand.new(file_menu_pane, "Open...",opens)
    run_icon =FXPNGIcon.new(app, File.open("run.png", "rb").read)

    file_menu_title = FXMenuTitle.new(menu_bar, "File" , :popupMenu => file_menu_pane,:icon => question_icon)

    save_menu_title = FXMenuTitle.new(menu_bar, "Save",:icon => save_icon)
    run_menu_title = FXMenuTitle.new(menu_bar, "Run",:icon => run_icon)

    file_open.connect(SEL_COMMAND) do

      @file
      dialog = FXFileDialog.new(self, "Open File" )
      dialog.patternList = ["Archivo de Texto (*.txt)"]
      dialog.selectMode = SELECTFILE_MULTIPLE
      if dialog.execute != 0
        createTable
        @ij = 0
        @ik = 0
        puts dialog.filename
        @file = dialog.filename
        leerArchivo(dialog.filename)
      end
    end

    #frame = FXVerticalFrame.new(self, :opts => LAYOUT_FILL)
    @text = FXText.new(self, :opts => LAYOUT_EXPLICIT, :x => 10, :y => 40, :width =>480, :height => 150)
    @text.font = FXFont.new(app, "Arial" , 14, :slant => FXFont::Italic)

    save_menu_title.connect(SEL_LEFTBUTTONPRESS) do
      #guardamos el archivo

      begin
        archivo2 = @file
        f = File.new(archivo2,"w")
        f.puts(@text.getText)
        f.close

        FXMessageBox.information(
            self,
            MBOX_OK,
            "Message",
            "File saved successfully!"
        )


      rescue Exception => e
        puts e
      end

    end

    run_menu_title.connect(SEL_LEFTBUTTONPRESS) do
      t = @text.getText
      if t == ""
        FXMessageBox.warning(
            self,
            MBOX_OK,
            "Message",
            "NOT RUN!"
        )
      else
        @ij = 0
        @ik = 0
        createTable
        analizar(t)
      end

    end

    @table = FXTable.new(self, :opts => LAYOUT_EXPLICIT, :x => 10, :y => 200, :width =>215, :height => 300)
    @table.font = FXFont.new(app, "Times,120,bold" )
    @ij = 0
    @tablaDos = FXTable.new(self, :opts => LAYOUT_EXPLICIT, :x => 270, :y => 200, :width =>215, :height => 300)
    @tablaDos.font = FXFont.new(app, "Times,120,bold" )
    createTable
    @ik = 0


  end

  def createTable
    @table.setTableSize(100,1)
    @table.setColumnText(0, "LEXEMA")
    @table.setCellColor(0,0,"Blue")

    @tablaDos.setTableSize(30,1)
    @tablaDos.horizontalGridShown = false
    @tablaDos.setCellColor(0,0,"Red")
  end

  def leerArchivo(file_name)

    f = File.open(file_name)
    texto = ""
    f.each do |i|
      #puts "#{f.lineno}: #{i}"
      puts i
      texto = texto + i
      analizar(i)

    end
    f.close
    @text.text = texto
  end

  def analizar(mensaje)
    mCadena = ManejoCadena.new()
    arreglo = mCadena.separarSimbolos(mensaje)
    bandera=0

    #table.setItemText(0, 0,"Hola")
    arreglo.each { |i|
      puts i

      if mCadena.isAsignacion(i)
        puts "operador de asigancion: #{i}"
        @table.setRowText(@ij,"Op. Asignacion")
        @table.setItemText(@ij,0,i.to_s)
        bandera=1
        @ij += 1
      elsif mCadena.isPuntoComa(i)
        puts "punto y coma: #{i}"
        @table.setRowText(@ij,"Punto y Coma")
        @table.setItemText(@ij,0,i.to_s)
        bandera=1
        @ij += 1
      elsif mCadena.isSeparadores(i)
        puts "separador: #{i}"
        @table.setRowText(@ij,"Seperador")
        @table.setItemText(@ij,0,i.to_s)
        bandera=1
        @ij += 1
      else
        bandera=0
      end

      if bandera == 0
        array = mCadena.separarOperadores(i)
        array.each { |j|
          puts j
          if mCadena.isOperador(j)
            puts "operador aritmetico: #{j}"
            @table.setRowText(@ij,"Op. Aritmetico")
            #@table.setItemText(ij,0,"Op. Aritmetico")
            @table.setItemText(@ij,0,j.to_s)
            bandera=1
            @ij += 1
          elsif mCadena.isAsignacion(j)
            puts "operador de asigancion: #{j}"
            @table.setRowText(@ij,"Op. Asignacion")
            @table.setItemText(@ij,0,j.to_s)
            bandera=1
            @ij += 1
          elsif mCadena.isIgual(j)
            puts "Operador de Asignacion: #{j}"
            @table.setRowText(@ij,"Op. Asignacion")
            @table.setItemText(@ij,0,j.to_s)
            bandera = 1
            @ij += 1
          elsif mCadena.analizarIdentificador(j)
            puts "identificador: #{j}"
            @table.setRowText(@ij,"Identificador")
            @table.setItemText(@ij,0,j.to_s)
            bandera=1
            @ij += 1
          elsif mCadena.analizarNumero(j)
            puts "numero #{j}"
            @table.setRowText(@ij,"Numero")
            @table.setItemText(@ij,0,j.to_s)
            bandera=1
            @ij += 1
          else
            @tablaDos.setRowText(@ik,"No Valido")
            @tablaDos.setItemText(@ik,0,j.to_s)
            @ik += 1
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



