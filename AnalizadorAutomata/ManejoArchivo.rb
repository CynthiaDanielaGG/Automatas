require 'spreadsheet'


class ManejoArchivo

  def initialize(file)

    @archivo = file


  end

  def obtenerAlfabeto

    libro = Spreadsheet.open(@archivo+'.xls')
    hoja = libro.worksheet('Hoja1')

    alfabeto = Array.new()

    i = 0
    cont_colum = hoja.column_count
    while(i<cont_colum)
      alfabeto.insert(i,hoja.cell(0,i).to_s)
      i+=1
    end
    return alfabeto
  end

  def getTabla

    libro = Spreadsheet.open(@archivo+'.xls')
    hoja = libro.worksheet('Hoja1')

    matriz = Array.new()

    i = 1
    cont_row = hoja.row_count
    cont_colum = hoja.column_count

    while(i < cont_row)

      aux = Array.new()
      j = 0
      while(j < cont_colum)
        aux.insert(j,hoja.cell(i,j).to_i)
        j+=1
      end
      matriz.insert((i-1),aux)
      i+=1
    end

    return matriz
  end

end