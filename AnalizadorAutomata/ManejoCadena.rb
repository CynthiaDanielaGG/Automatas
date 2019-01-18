
class ManejoCadena


  def esDigito (simbolo)
    return simbolo  =~ /^[0-9]/
  end

  def isPunto(punto)
    if(punto.match(/[.]/))
      return true
    else
      return false
    end
  end

  def esLetra (simbolo)
    return simbolo =~/^[a-zA-Z]/
  end

  def esFDC (simbolo)
    return simbolo  =~ /\$/
  end
  def isIgual(simbolo)
    return simbolo =~ /[=]/
  end

  def isOperador(operador)
    if operador.match(/^[+]/)
      return true
    else
      if operador.match(/^[-]/)
        return true
      else
        if operador.match(/^[\*]/)
          return true
        else
          if operador.match(/^[\/]/)
            return true
          end
        end
      end
    end
  end


  def isAsignacion(asignacion)

    #puts "llegue aqui"

    if asignacion.match(/[+][=]/)
      return true
    elsif asignacion.match(/^[-][=]/)
      return true
    elsif asignacion.match(/^[*][=]/)
      return true
    elsif asignacion.match(/^[\/][=]/)
      return true
    else
      return false
    end
  end

  def isPuntoComa(punto)
    if punto.match(/[;]/)
      return true
    else
      return false
    end
  end

  def isSeparadores(separador)
    if separador.match(/[(]|[)]/)
      return true
    else
      return false
    end
  end

  def separarSimbolos(cadena)

    cadena = cadena.gsub(/[+][=]/," += ")
    cadena = cadena.gsub("-="," -= ")
    cadena = cadena.gsub("*="," *= ")
    cadena = cadena.gsub("/="," /= ")
    cadena = cadena.gsub("("," ( ")
    cadena = cadena.gsub(")"," ) ")
    cadena = cadena.gsub(";"," ; ")
    array =  cadena.split(" ");
    return array;

  end

  def separarOperadores(cadena)
    cadena = cadena.gsub("="," = ")
    cadena = cadena.gsub(/[+]/," + ")

    cadena = cadena.gsub("-"," - ")

    cadena = cadena.gsub("*"," * ")
    cadena = cadena.gsub("/"," / ")

    array = cadena.split(" ");
    return array;
  end

  def analizarNumero(cadena)
    load "Numero.rb"
    arreglo = cadena.split("")
    @estado = 1
    numero = Numero.new(1)
    arreglo.each { |i|
      puts "simbolo #{i}"
      @estado = numero.transicion(i)
      if @estado < 0
        break
      end
      numero.setEstado(@estado)
    }
    if @estado == 2 || @estado == 4
      return true
    else
      return false
    end
  end
  def analizarIdentificador(cadena)
    load "Identificador.rb"
    arreglo = cadena.split("")
    identificador = Identificador.new(1)
    @estado = 1
    arreglo.each { |j|
      puts j
      @estado = identificador.transicion(j)
      if identificador.getEstado < 0
        break
      end
      identificador.setEstado(@estado)
    }
    if @estado == 2
      return true
    else
      return false
    end
  end


  def getDescripcion(simbolo)

    if(esDigito(simbolo))
      return "digito"
    elsif (esLetra(simbolo))
      return "letra"
    elsif (isPunto(simbolo))
      return "punto"
    elsif (esFDC(simbolo))
      return "fdc"
    else
      return "ERROR"
    end
  end


end

