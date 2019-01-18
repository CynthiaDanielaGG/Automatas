class ManejoCadena
  @iterador
  @contador_iteraciones
  def initialize(cadena)
    @iterador = cadena
    @contador_iteraciones = -1
  end
  def siguiente
    @contador_iteraciones += 1
    return @iterador[@contador_iteraciones]
  end

  def esFinaldeCadena(caracter)
    if caracter=~/[~]/
      return true
    else
      return false
    end
  end


  def esDigito(caracter)
    if caracter=~ /\d/
      return true
    else
      return false
    end
  end

  def esLetra(caracter)
    if caracter=~ /[A-Za-z]/
      return true
    else
      return false
      false
    end
  end


  def esPunto(caracter)
    if caracter=~ /[.]/
      return true
    else
      return false
    end
  end


  def esSigno(caracter)
    if caracter=~ /[-|+]/
      return true
    else
      return false
    end
  end


  def esExponente(caracter)
    if caracter=~ /[E|e]/
      return true
    else
      return false
    end
  end

  def esOperador(caracter)
    if caracter=~ /[+]|[-]|[*]|[\/]/
      return true
    else
      return false
    end
  end

  def tipo(caracter)

    @tipo="INVALIDO"
    if esExponente(caracter)==true
      @tipo="EXPONENTE"
    elsif esLetra(caracter)==true
      @tipo="LETRA"
    elsif esDigito(caracter)==true
      @tipo="DIGITO"
    elsif esPunto(caracter)==true
      @tipo="PUNTO"
    elsif esSigno(caracter)==true
      @tipo="SIGNO"
    elsif esOperador(caracter)==true
      @tipo="OPERADOR"
    elsif esFinaldeCadena(caracter)==true
      @tipo="FDC"
    end
    return @tipo
  end

end