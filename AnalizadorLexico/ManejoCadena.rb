
class ManejoCadena

  def isDigito(digito)
    if(digito.match(/[0-9]/))
      return true
    else
      return false
    end
  end

  def isPunto(punto)
    if(punto.match(/[.]/))
      return true
    else
      return false
    end
  end

  def isLetra(letra)
    if(letra.match(/^[Aa-zZ]/))
      return true
    else
      return false
    end
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
    if asignacion.match(/[=]/)
      return true
    elsif asignacion.match(/[+][=]/)
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


  def isIdetificador(cadena)

    load "Identificador.rb"

    arreglo = separarOperadores(cadena)

    arreglo.each { |i|


      if Identificador.new(1).transicion(i) == 2
        puts "identificador: #{i}"
      elsif isOperador(i)
        puts "operador aritmetico: #{i}"
      else
        return false

      end

    }
    return true
  end

  def isNumero(cadena)
    load "Numero.rb"

    arreglo = separarOperadores(cadena)

    arreglo.each { |i|



      if (Numero.new(1).transicion(i) == 2)
        puts "numero: #{i}"
      elsif (Numero.new(1).transicion(i) == 4)
        puts "numero: #{i}"
      elsif isOperador(i)
        puts "operador aritmetico: #{i}"
      else
        return false
      end
    }
    return true

  end

end