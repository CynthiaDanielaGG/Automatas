#IMPORTACIONES
require_relative 'Ventana_Doble'
require_relative 'Ventanita'
require_relative 'Manejo_Cadena'
require_relative 'Manejo_Archivo_Excel'
require_relative 'Automata_General'
require "fox16"
include Fox

#CLASE VENTANA QUE OBTIENE PROPIEDADES DE FXMAINWINDOWS
class Ventana < FXMainWindow
  #METODO CONSTRUCTOR
  def initialize(aplicacion )
    super(aplicacion, "Automatas", :width => 1100, :height => 600 )
    folder = FXPNGIcon.new(aplicacion ,File.open("folder.png", "rb"). read)
    folderAbri= FXPNGIcon.new(aplicacion ,File.open("folder_page.png", "rb"). read)
    folderGuardar= FXPNGIcon.new(aplicacion ,File.open("page_save.png", "rb"). read)
    acercaDeIcon= FXPNGIcon.new(aplicacion ,File.open("page_white_text.png", "rb"). read)
    self.backColor = 'purple'
    aplicacion.backColor='white'
    @aplicacion = aplicacion
    @auxiliar_guardar = false
    #Para saber si acaba de abrir un archivo de excel
    @viene_de_abrir_excel = false
    @checks = Array.new
    @targets = Array.new
    @estado_inicial = 1
    @tabla_estado = FXTable.new(self, :opts => LAYOUT_EXPLICIT, :x => 600, :y => 100, :width => 420, :height => 350)
    label_estado_inicial = FXLabel.new(self, " Estado 0 " , :opts => LAYOUT_EXPLICIT, :x => 20, :y => 30, :width => 90, :height => 25)
    label_estado_inicial.backColor='purple'
    label_simbolo = FXLabel.new(self, " Simbolo" , :opts => LAYOUT_EXPLICIT, :x => 130, :y => 30, :width => 90, :height => 25)
    label_simbolo.backColor='purple'
    label_estado_final = FXLabel.new(self, " Estado 1" , :opts => LAYOUT_EXPLICIT, :x => 240, :y => 30, :width => 90, :height => 25)
    label_estado_final.backColor='purple'
    estadoI = FXTextField.new(self, 20, nil, :opts => LAYOUT_EXPLICIT, :x => 20, :y => 60, :width =>90, :height => 25)
    tipo_simbolo = FXTextField.new(self, 20, nil, :opts => LAYOUT_EXPLICIT, :x => 130, :y => 60, :width => 90, :height => 25)
    estado_final = FXTextField.new(self, 20, nil, :opts => LAYOUT_EXPLICIT, :x => 240, :y => 60, :width => 90, :height => 25)
    boton_agregar = FXButton.new(self, "Llenar Tabla", :opts => LAYOUT_EXPLICIT, :x => 350, :y => 60, :width => 90, :height => 25)
    boton_agregar.backColor='gray'
    label_estado_inicio = FXLabel.new(self, "Estado inicial " , :opts => LAYOUT_EXPLICIT, :x => 20, :y => 130, :width => 90, :height => 25)
    label_estado_inicio.backColor='purple'
    @combo = FXComboBox.new(self, 30, nil, :opts => LAYOUT_EXPLICIT, :x => 20, :y => 180, :width => 125, :height => 45)
    label_estado_fin = FXLabel.new(self, "Estado Final" , :opts => LAYOUT_EXPLICIT, :x => 240, :y => 130, :width => 90, :height => 25)
    label_estado_fin.backColor='purple'
    label_verificar = FXLabel.new(self, "Ingrese un dato" , :opts => LAYOUT_EXPLICIT, :x => 30, :y => 500, :width => 90, :height => 25)
    label_verificar.backColor='purple'
    cadena = FXTextField.new(self, 16, nil, :opts => LAYOUT_EXPLICIT, :x => 150, :y => 500, :width => 270, :height => 25)
    #cadenaEva = FXTextField.new(self, 16, nil, :opts => LAYOUT_EXPLICIT, :x => 130, :y => 300, :width => 200, :height => 45)
    boton_verificar = FXButton.new(self, "Verificar", :opts => LAYOUT_EXPLICIT, :x => 450, :y => 500, :width => 80, :height => 25)
    boton_verificar.backColor='gray'
    btnActualizar = FXButton.new(self, "Actualizar", :opts => LAYOUT_EXPLICIT, :x => 600, :y => 500, :width => 80, :height => 25)
    btnActualizar.backColor='gray'
    menu_bar=FXMenuBar.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
    opcion_uno=FXMenuPane.new (self)
    boton_cargar=FXMenuCommand.new(opcion_uno, "Abrir Archivo", :ic => folderAbri)
    opcionUno=FXMenuTitle.new(menu_bar, "Archivo", :popupMenu => opcion_uno , :icon=>folder)
    #opcion_dos=FXMenuTitle.new(menu_bar, "Acerca de...", :popupMenu => opcion_dos)
    boton_guardar=FXMenuCommand.new(opcion_uno, "Guardar archivo",:ic=>folderGuardar )
    acercaDe=FXMenuCommand.new(opcion_uno, "Acerca de...",:ic=>acercaDeIcon)
    ###########AQUI ACERCA DE AGREGAR AL FINAL


    #Evento para  tablita, ASIENDO PRUEBAS PARA NUEVO AVANCE

    @tabla_estado .connect(SEL_DOUBLECLICKED) do
      puts 'aqui asiendo pruebas'

     # lista= FXListBox.new(self,:target=>true, :selector=>0, :opts=>LIST_NORMAL, :x=>0, :y=>0, :width=>24, :height=>90)
     # lista='nombre','hola'

     # FXMessageBox.warning(self,MBOX_OK,"Error","Debes agregar un numero mayor a 0")
      #MensajeGrafico.new(@aplicacion,"Mensaje","Este campo contiene un dato.\n¿Desea modificarlo?",@tabla_estado,fila,col,dato)
      #@tabla_estado=TABLE_READONLY

       fil = @tabla_estado.selStartRow
      column = @tabla_estado.selStartColumn

      puts "Fila seleciionada:" + fil.to_s
      puts "Columna seleccionada:" + column.to_s
      @vetan = VentanaDoble.new(app)
      @vetan.create
    end

    btnActualizar.connect(SEL_COMMAND) do
      error = @vetan.getNumeroError
      @tabla_estado.setItemText(@tabla_estado.selStartRow,@tabla_estado.selStartColumn,error)
      @vetan.close
    end


    #----------------------------------------------------------------------------------
    boton_agregar.connect(SEL_COMMAND) do
      if estadoI .text!="" and tipo_simbolo.text!="" and estado_final.text!=""
        valor_estado0=estadoI .text
        valor_estado1=estado_final.text
        if valor_estado0.to_i > 0 and valor_estado1.to_i > 0
          e0 = estadoI .text
          s = tipo_simbolo.text
          e1 = estado_final.text
          agregarFila(e0,s,e1)
          crearChecks
          estado_final.text=""
          tipo_simbolo.text=""
          estadoI .text=""
        else
          FXMessageBox.warning(self,MBOX_OK,"Error","Debes agregar un numero mayor a 0")
        end
      else
        FXMessageBox.warning(self,MBOX_OK,"Error","Estas olvidando un campo")
      end

    end

    @combo.connect(SEL_COMMAND) do |valor|
      @estado_inicial = (valor.to_s).to_i
    end
    #EVENTO DE GUARDAR ARCHIVO
    boton_guardar.connect(SEL_COMMAND) do

      if @tabla_estado.numRows != 0 and @tabla_estado.numColumns != 0
        libro = Spreadsheet::Workbook.new
        libro.create_worksheet :name => 'Hoja1'

        encabezado = Array.new

        0.upto(@tabla_estado.numColumns-1) do |i|
          encabezado.push(@tabla_estado.getColumnText(i))
        end

        encabezado.push("FDC")
        libro.worksheet(0).insert_row(0,encabezado)

        estados_fin = Array.new
        estados_fin = obtener_estados_finales
        index = 0
        0.upto(@tabla_estado.numRows-1) do |i|
          fila = Array.new
          0.upto(@tabla_estado.numColumns-1) do |j|
            fila.push(@tabla_estado.getItemText(i,j))
          end
          fila.push(estados_fin[index])
          libro.worksheet(0).insert_row(i+1,fila)
          index += 1
        end

        ruta =abrir_directorio
        if ruta != "Cancelado"
          libro.write(ruta)
          FXMessageBox.information(self,MBOX_OK,"Errosr","No se esta guardando")
        end

      else
        FXMessageBox.warning(self,MBOX_OK,"Error","No existen datos en tabla")
      end

    end
    #BOTON VERIFICAR CADENA
    boton_verificar.connect(SEL_COMMAND) do
      if cadena.text!=""
        marcado = false
        @targets.each{|i|
          if i.value
            marcado = true

          end
        }

        if marcado
          @aceptado = true
          @estadoFinal= Array.new
          @estadosFinal = obtener_estados_finales
          @trancisiones = Array.new
          @alfabeto = Array.new
          @alfabeto = obtenerLetras
          @trancisiones = obtener_estados
          @cadena_general = cadena.text + "~"
          automata_general = AutomataGeneral.new(@trancisiones, @estado_inicial, @alfabeto)
          identificador = ManejoCadena.new(@cadena_general)
          token = identificador.siguiente
          until automata_general.get_Estado.to_i == 0 do
            automata_general.transicion(token)
            token = identificador.siguiente
            if (automata_general.get_Estado).to_i == -1
              @aceptado = false
              break
            end
          end

          if @aceptado == false
            FXMessageBox.information(self, MBOX_OK,  "Mensaje", "No aceptado")
            cadena.text = ""
          else
            FXMessageBox.information(self, MBOX_OK, "Mensaje", "Aceptada")
            cadena.text = ""
          end
        else
          FXMessageBox.warning(self,MBOX_OK,"Eror","Seleccione estado final.")
        end

      else
        FXMessageBox.warning(self,MBOX_OK,"Error","Debe ingresar algo")
      end

    end


    boton_cargar.connect(SEL_COMMAND) do
      dialogo = FXFileDialog.new(self,"Abrir Archivo...")
      dialogo.patternList = ["Todos los archivos (*)","Excel (.xls)"]

      dialogo.selectMode = SELECTFILE_EXISTING
      if dialogo.execute != 0
        @archivoExcel = dialogo.filename
        tabla = ManejoArchivoExcel.new(@archivoExcel)
        encabezado = tabla.getEncabezado
        @columna = tabla.getEstados
        puts @columna.to_s
        datos = tabla.getDatos
        filas = tabla.getFilas
        filas -= 1
        columnas = tabla.getColumnas

        @tabla_estado.setTableSize(filas, columnas - 1)
        tabla.getEncabezado.each_with_index do |elemento, i|
          @tabla_estado.setColumnText(i, elemento.to_s.upcase)
        end

        0.upto(filas - 1) do |i|
          @tabla_estado.setRowText(i, (i + 1).to_s)
        end

        i = 0
        while (i < filas)
          j = 0
          while(j < columnas - 1)
            dato = datos[i][j]
            if dato != ''
              @tabla_estado.setItemText(i, j, dato.to_s)
            end
            j += 1
          end
          i += 1
        end

        puts "Vengo de haber abierto un excel muajajaja"
        @viene_de_abrir_excel = true
      end
      @combo.clearItems

      0.upto(@tabla_estado.numRows - 1) do |i|
        @tabla_estado.setRowText(i, (i + 1).to_s)
        @combo.appendItem((i + 1).to_s)
        target = FXDataTarget.new(false)
      end
      if @tabla_estado.numRows<=6
        @combo.numVisible =@tabla_estado.numRows
      else
        @combo.numVisible = 5
      end
      verChecks
      puts "Abri al menos el dialogo de abrir"
    end



    def abrir_directorio
      directorio = FXDirDialog.new(self, "Guardar archivo")
      directorio.directory = "C:/Users/Cynthia/Documents/VERANO 2016/AUTOMATAS II/Automaatas1/src"
      #@archivoExcel="C:/Users/Cynthia/Documents/VERANO 2016/AUTOMATAS II/Automaatas1/src/ManejoERROR.xls"
      if(directorio.execute != 0)
        return directorio.directory+".xls"
      else
        return "Cancelado"
      end
    end

    def obtener_estados
      transiciones = Array.new
      filas = @tabla_estado.numRows
      columnas = @tabla_estado.numColumns
      i = 0
      while (i < filas)
        j = 0
        arreglo_auxiliar = Array.new

        while (j < columnas)
          if @tabla_estado.getItemText(i, j).to_s == ""
            arreglo_auxiliar.push("-1")
          else
            arreglo_auxiliar.push(@tabla_estado.getItemText(i, j).to_s)
          end
          j += 1
        end
        arreglo_auxiliar.push(@estadosFinal[i])#///////////////////////////////////////////////////////////////////////////////////////////
        transiciones.push(arreglo_auxiliar)
        i += 1
      end

      return transiciones

    end

    def obtenerLetras
      columnas = @tabla_estado.numColumns
      alfabeto = Array.new
      i = 0
      while(i < columnas)
        alfabeto.push(@tabla_estado.getColumnText(i))
        i += 1
      end
      alfabeto.push("FDC")

      return alfabeto
    end

    def agregarFila(estado0,simbolo,estado1)

      if not existeFila?(estado0.to_s)
        @tabla_estado.insertRows(@tabla_estado.numRows,estado0.to_i-@tabla_estado.numRows)
      end


      @combo.clearItems

      0.upto(@tabla_estado.numRows-1) do |i|
        @tabla_estado.setRowText(i,(i+1).to_s)
        @combo.appendItem((i+1).to_s)
        target = FXDataTarget.new(false)
      end
      if @tabla_estado.numRows<=6
        @combo.numVisible =@tabla_estado.numRows
      else
        @combo.numVisible =5
      end
      index =existeColumna?(simbolo)
      if index==-1
        @tabla_estado.insertColumns(@tabla_estado.numColumns,1)
        @tabla_estado.setColumnText(@tabla_estado.numColumns-1,simbolo)
        index = @tabla_estado.numColumns-1
      end
      insertar(estado0.to_i-1,index,estado1)
    end
    def insertar(fila,col,dato)
      if @tabla_estado.getItemText(fila,col) == ''
        @tabla_estado.setItemText(fila,col,dato)
      else

        MensajeGrafico.new(@aplicacion,"Mensaje","Este campo contiene un dato.\n¿Desea modificarlo?",@tabla_estado,fila,col,dato)
      end
    end

    def obtener_estados_finales
      estados_finales = Array.new
      @targets.each_with_index{|est,i|
        if est.value
          estados_finales[i] = "0"
        else
          estados_finales[i] = "-1"
        end
      }
      return estados_finales
    end
    def existeColumna?(columna)
      i=0
      columnas = @tabla_estado.numColumns
      while (i<columnas)
        if @tabla_estado.getColumnText(i) == columna
          return i
        end
        i+=1
      end
      return -1
    end

    def crearChecks
      @checks.each do |ch|
        ch.visible = false
      end

      @checks = Array.new
      @targets = Array.new
      puts "(Crear checks) Viene de abrir un excel: ",@viene_de_abrir_excel
      unless @matrizChecks.nil?
        @matrizChecks.destroy
      end

      @matrizChecks = FXMatrix.new(self, 3, MATRIX_BY_ROWS|LAYOUT_EXPLICIT,:x=>190,:y=>180,:width => 400,:height =>100)
      puts 'que guarda esta matris1',@matrizChecks.numRows
      puts "pppppppppppppppppppppppppppppppppppppppp"
      #:x => 20, :y => 180, :width => 125, :height => 45   :x => 240, :y => 130

      contador = 0
      ver = false

      0.upto(@tabla_estado.numRows-1) do |i|

        if(@viene_de_abrir_excel)
          if (@columna[contador]).to_i == -1 || contador>=@columna.size
            ver = false
          else
            ver = true
          end
          contador += 1
          target = FXDataTarget.new(ver)
          puts "soy el contador de checks", contador
        else
          target = FXDataTarget.new(false)
        end
                                #w(self, 3, MATRIX_BY_ROWS|LAYOUT_EXPLICIT,:x=>240,:y=>180,:width => 235,:height =>80)
        @targets.push(target)
        check = FXCheckButton.new(@matrizChecks," Estado "+(i+1).to_s,:target => target,:selector => FXDataTarget::ID_VALUE,)
        puts 'estoy imprimiedno i',(i+1).to_s
        puts 'que guarda check',check
        puts "pppppppppppppppppppppppppppppppppppppppp"
        @checks.push(check)
      end
      @matrizChecks.create
    end
    def verChecks
      @checks.each do |ch|
        ch.visible = false
      end
      @checks = Array.new
      @targets = Array.new
      unless @matrizChecks.nil?
        @matrizChecks.destroy
      end
      @matrizChecks = FXMatrix.new(self, 3, MATRIX_BY_ROWS|LAYOUT_EXPLICIT,:x=>240,:y=>180,:width => 200,:height =>70)
      puts 'que guarda esta matrische2',@matrizChecks.numRows
      puts "pppppppppppppppppppppppppppppppppppppppp"
      contador = 0
      ver = true
      0.upto(@tabla_estado.numRows-1) do |i|
        if (@columna[contador]).to_i == -1
          ver = false
        end
        contador += 1
        if ver
          target = FXDataTarget.new(true)
        else
          target = FXDataTarget.new(false)
          ver = true
        end

        @targets.push(target)
        check = FXCheckButton.new(@matrizChecks," Estado "+(i+1).to_s,:target => target,:selector => FXDataTarget::ID_VALUE)
        puts 'aqui veremos',(i+1).to_s
        @checks.push(check)
      end
      @matrizChecks.create
    end


    def existeFila?(fila)
      i=0
      filas = @tabla_estado.numRows
      while (i<filas)
        if @tabla_estado.getRowText(i)==fila
          return true
        end
        i+=1
      end
      return false

    end



  end


  def create
    super
    show(PLACEMENT_SCREEN)
  end

end
aplicacion = FXApp.new()
Ventana.new(aplicacion)
aplicacion.create
aplicacion.run