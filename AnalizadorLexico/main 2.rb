require 'tk'
load 'ManejoCadena.rb'
load 'Numero.rb'


frame = TkRoot.new do
  title "ANALIZADOR"
  minsize(400,250)
end
TkLabel.new(frame) do
  text 'VIENBENIDO'
  place('relx'=>0.40,'rely'=>0.05)
end

TkLabel.new(frame) do
  text 'INGRESA LA EXPRECION'
  place('relx'=>0.35,'rely'=>0.15)
end

cadena=TkEntry.new(frame) do
  background "white"
  place('relx'=>0.33,'rely'=>0.30)
end

boton1=TkButton.new(frame) do
  text "INGRESAR"
  borderwidth 1
  background "red"
  place('relx'=>0.41,'rely'=>0.42)
end

boton1.bind('ButtonPress',proc do
                           mCadena = ManejoCadena.new()
                           arreglo = mCadena.separarSimbolos(cadena.value)
                           arreglo.each { |i|

                             if mCadena.isAsignacion(i)
                               puts "operador de asigancion: #{i}"
                             elsif mCadena.isPuntoComa(i)
                               puts "punto y coma: #{i}"
                             elsif mCadena.isSeparadores(i)
                               puts "separador: #{i}"
                             elsif mCadena.isIdetificador(i)

                             elsif mCadena.isNumero(i)

                             end

                           }

                         end)

Tk.mainloop