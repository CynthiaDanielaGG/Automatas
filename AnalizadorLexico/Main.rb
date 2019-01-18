




load 'ManejoCadena.rb'
load 'Numero.rb'
mCadena = ManejoCadena.new()
arreglo = mCadena.separarSimbolos('suma=(34*)-23')
arreglo.each { |i|
  puts i

  if mCadena.isAsignacion(i)
    puts "operador de asigancion: #{i}"
  elsif mCadena.isPuntoComa(i)
    puts "punto y coma: #{i}"
  elsif mCadena.isSeparadores(i)
    puts "separador: #{i}"
  elsif mCadena.isIdetificador(i)
    puts ""
  elsif mCadena.isNumero(i)
    puts ""
  end
  #mCadena.isIdetificador(i)


  #mCadena.isIdetificador(i)
  #mCadena.isNumero(i)
}



