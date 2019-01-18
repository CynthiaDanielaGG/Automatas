load "Automata.rb"
load "ManejoCadena.rb"

class Numero < Automata

  def initialize(estado)
    super @estado = estado
  end

  def transicion(cadena)

    case @estado

      when 1
        if ManejoCadena.new.isDigito(cadena)
          @estado = 2
        end
      when 2
        if ManejoCadena.new.isDigito(cadena)
          @estado = 2
        elsif ManejoCadena.new.isPunto(cadena)
          @estado = 3
        end
      when 3
        if ManejoCadena.new.isDigito(cadena)
          @estado = 4
        elsif ManejoCadena.new.isDigito(cadena)
          @estado = 4
        end
    end
  end
end