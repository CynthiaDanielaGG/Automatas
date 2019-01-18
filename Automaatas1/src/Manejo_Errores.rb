
require_relative 'Manejo_Archivo_Excel.rb'

class ManejoErrores
  def initialize()
  end
  def obtenerdescripcion(error)
    @manejoa = ManejoArchivo_Excel.new
    return @manejoa.abrirarchivo(error)
  end
  
end