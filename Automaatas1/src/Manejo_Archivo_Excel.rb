require 'spreadsheet'

class ManejoArchivoExcel

  @filas
  @columnas

  def initialize(file_name)
    @archivo = file_name
    @filas = 0
    @columnas = 0
  end

  def getNumFilas
    return @filas
  end

  def getNumColumnas
    return @columnas
  end

  def getEncabezado
    open_book = Spreadsheet.open(@archivo)
    hoja = open_book.worksheet 0
    @filas = hoja.row_count
    @columnas = hoja.column_count
    encabezado = Array.new
    columna = 0
      while(columna < @columnas - 1)
        encabezado.push(hoja.cell(0,columna).to_s)
        columna+=1
      end
      return encabezado
  end

  def getDatos
    open_book = Spreadsheet.open(@archivo)
    hoja = open_book.worksheet 0
    @filas = hoja.row_count
    @columnas = hoja.column_count
    matriz = Array.new
    i = 1
    while(i<@filas)
      j = 0
      auxiliar = Array.new
      while(j<@columnas)
        auxiliar.push(hoja.cell(i,j).to_s)
        j+=1
      end
      matriz.push(auxiliar)
      i+=1
    end
    return matriz
  end

  def getEstados
    open_book = Spreadsheet.open(@archivo)
    hoja = open_book.worksheet 0
    @filas = hoja.row_count
    @columnas = hoja.column_count
    columna = Array.new
    i = 1
    while(i<@filas)
      columna.push(hoja.cell(i, @columnas - 1).to_s)
      i += 1
    end
    return columna
  end


  def getColumnas
    return @columnas
  end

  def getFilas
    return @filas
  end

end