class SudokusController < ApplicationController
  @start_array
  @current_array

  def init()
    @start_array = Array.new(9){Array.new(9, 0)}
  end

  def generate_end_array()

  end

  def valid_row(array, row)
    valid = []
    for i in array[row]
      if not i in valid
        valid.pop(i)
      else
        return false
      end
    end
    return true
  end

  def valid_col(array, col)
    valid = []
    for i in array
      if not i[col] in valid
        valid.pop(i[col])
      else
        return false
      end
    end
    return true
  end

  def valid_3x3(array)
    for col_count in 0..2
      for row_count in 0..2
        for x in 0..2
          for y in 0..2
            if not array[col_count*3+y][row_count*3+x] in valid
              valid.pop(array[col_count*3+y][row_count*3+x])
            else
              return false
            end
          end
        end
      end
    end

    return true
  end

  def index()
    render 'index'
  end




end
