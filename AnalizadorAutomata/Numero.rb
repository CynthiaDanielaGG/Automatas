load "Automata.rb"
load "ManejoCadena.rb"
load "ManejoArchivo.rb"
class Numero < Automata

  def initialize(estado)
    @archivo = ManejoArchivo.new("Numero")
    @tabla = @archivo.getTabla
    @alfabeto = @archivo.obtenerAlfabeto
    super @estado = estado
  end

  def transicion(cadena)
    begin
      @estado = @tabla[(@estado-1)][numeroColumna(ManejoCadena.new.getDescripcion(cadena))]
    rescue Exception
      @estado = -2
    end

  end


  def numeroColumna(descripcion)
    i = 0
    while(i < @alfabeto.length)

      if(descripcion == @alfabeto[i])
        puts @alfabeto[i]
        return i
      else
        i += 1
      end
    end
    return ""
  end

end