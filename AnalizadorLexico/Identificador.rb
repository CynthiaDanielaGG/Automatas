load "Automata.rb"
load "ManejoCadena.rb"

class Identificador < Automata

  def initialize(estado)
    super @estado = estado

  end

  def transicion(cadena)

    case @estado

      when 1
        if ManejoCadena.new.isLetra(cadena)
          @estado = 2
        end
      when 2
        if ManejoCadena.new.isLetra(cadena)
          @estado = 2
        elsif ManejoCadena.new.isDigito(cadena)
          @estado = 2
        end
    end

  end

end