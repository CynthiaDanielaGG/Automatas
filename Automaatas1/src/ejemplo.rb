class ManejoCadena
  def initialize()
  end
  def cadena(cadenanueva)
    @cadena = cadenanueva.to_s
  end

  def siguienteSimbolo
    begin
      @caracter=@cadena[0].chr
      @cadena=@cadena[1...@cadena.size]
      return @caracter
    rescue
      @caracter = "\n"
    end
  end

  def separartermino
    @cadena = @cadena.gsub("*"," * ")
    @cadena = @cadena.gsub("/"," / ")
    array = @cadena.split(" ")
    return array
  end


  def quees(caracter)
    if(digito(caracter))
      return "Digito"
    elsif (letra(caracter))
      return "Letra"
    elsif (punto(caracter))
      return "Punto"
    elsif (menos(caracter))
      return "Signo"
    elsif (mas(caracter))
      return "Signo"
    elsif (caracterespecial(caracter))
      return "Caracter Especial"
    elsif (finaldecadena(caracter))
      return "FDC"
    end
  end

  def digito(simbolo)
    if simbolo =~ /[0-9]/
      return true
    else
      return false
    end
  end

  def letra(simbolo)
    if simbolo =~ /[a-zA-Z]/
      return true
    else
      return false
    end
  end

  def punto(simbolo)
    if simbolo =~ /[.]/
      return true
    else
      return false
    end
  end

  def caracterespecial(simbolo)
    if simbolo =~ /[(<})¡?{!'@"*',-<"]/
      return true
    else
      return false
    end
  end

  def menos(simbolo)
    if simbolo =~ /[-]/
      return true
    else
      return false
    end
  end
  def mas(simbolo)
    if simbolo =~ /[+]/
      return true
    else
      return false
    end
  end

  def finaldecadena(simbolo)
    if simbolo == "\n"
      return true
    else
      return false
    end
  end

  def exponente (caracter)
    if caracter =~ /[eE^]/
      return true
    else
      return false
    end
  end

end