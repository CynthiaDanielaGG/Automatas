load "Automata.rb"
load "ManejoCadena.rb"
load 'ManejoArchivo.rb'

class Identificador < Automata

  def initialize(estado)
    @mArchivo = ManejoArchivo.new("Identificador")
    @tabla = @mArchivo.getTabla
    @alfabeto = @mArchivo.obtenerAlfabeto()
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
        return i
      else
        i += 1
      end

    end
    return ""
  end

end