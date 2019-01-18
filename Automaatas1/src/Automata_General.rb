require_relative "Automata"
require_relative "Manejo_Cadena"
class AutomataGeneral < Automata
  def initialize(transiciones, estado, alfabeto)
    @transiciones = transiciones
    @estado = estado
    @alfabeto = alfabeto
    @manejador = ManejoCadena.new("")
    set_estado(@estado)
  end
  def get_columna(simbolo)
    i = 0
    @tam = @alfabeto.size
    while ( @alfabeto[i] != @manejador.tipo(simbolo))
       if i < @tam
        i += 1
      else
        return -1
      end
    end
    return i
  end

  def transicion(simbolo)
    a = ((get_Estado.to_i) - 1)
    b = get_columna(simbolo)
    if b == -1
      set_estado(-1)
    else
      set_estado(@transiciones[a][b])
    end
  end


end