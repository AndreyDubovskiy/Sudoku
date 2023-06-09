class SudokusController < ApplicationController
  @@start_array
  @@user_sudoku
  @@end_array

  def init_array()
    tmp = [[1,2,3,4,5,6,7,8,9],
                    [4,5,6,7,8,9,1,2,3],
                    [7,8,9,1,2,3,4,5,6],
                    [2,3,4,5,6,7,8,9,1],
                    [5,6,7,8,9,1,2,3,4],
                    [8,9,1,2,3,4,5,6,7],
                    [3,4,5,6,7,8,9,1,2],
                    [6,7,8,9,1,2,3,4,5],
                    [9,1,2,3,4,5,6,7,8]]
    return tmp
  end

  def prepare_array(array, n)
    last = 0
    while (n > 0)
      row = rand(0..8)
      col = rand(0..8)
      if array[row][col] != 0
        last = array[row][col]
        array[row][col] = 0
        numbers = variants_all(array, row, col)
        if numbers.size == 1
          n-=1
        else
          array[row][col] = last
        end
      end
    end
    return array
  end

  def shuffle(array)
    count_row_shuffle = rand(1..10)
    count_col_shuffle = rand(1..10)
    count_row3x3_shuffle = rand(1..10)
    count_col3x3_shuffle = rand(1..10)
    #0 - row swap
    #1 - col swap
    #2 - row3x3 swap
    #3 - col3x3 swap
    tmp = [0, 1, 2, 3]
    while(count_row_shuffle>0 or count_col_shuffle>0 or count_row3x3_shuffle>0 or count_col3x3_shuffle>0)
      numb = tmp.sample
      if(numb == 0)
        row3x3 = rand(0..2)
        array = swap_row(array, row3x3*3+rand(0..2), row3x3*3+rand(0..2))
        count_row_shuffle-=1
      elsif (numb == 1)
        col3x3 = rand(0..2)
        array = swap_col(array, col3x3*3+rand(0..2), col3x3*3+rand(0..2))
        count_col_shuffle-=1
      elsif (numb == 2)
        array = swap_row3x3(array, rand(0..2), rand(0..2))
        count_row3x3_shuffle-=1
      elsif (numb == 3)
        array = swap_col3x3(array, rand(0..2), rand(0..2))
        count_col3x3_shuffle-=1
      end
      if(count_row_shuffle == 0)
        tmp.delete(0)
      end
      if(count_col_shuffle == 0)
        tmp.delete(1)
      end
      if(count_row3x3_shuffle == 0)
        tmp.delete(2)
      end
      if(count_col3x3_shuffle == 0)
        tmp.delete(3)
      end
    end
    return array
  end

  def swap_row(array, row1, row2)
    tmprow = array[row1].clone
    array[row1] = array[row2].clone
    array[row2] = tmprow.clone
    return array
  end

  def swap_col3x3(array, col1, col2)
    for col in 0..2
      array = swap_col(array, col1*3+col, col2*3+col)
    end
    return array
  end

  def swap_row3x3(array, row1, row2)
    for row in 0..2
      array = swap_row(array, row1*3+row, row2*3+row)
    end
    return array
  end
  def swap_col(array, col1, col2)
    for row in 0..8
      tmp = array[row][col1]
      array[row][col1] = array[row][col2]
      array[row][col2] = tmp
    end
    return array
  end

  def variants_all(array, row, col)
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    result = []
    num_row = variants_row(array, row)
    num_col = variants_col(array, col)
    num_3x3 = variants_3x3(array, row, col)
    for i in numbers
      if(num_row.include? i) and (num_col.include? i) and (num_3x3.include? i)
        result.push(i)
      end
    end
    return result
  end

  def variants_row(array, row)
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    for i in array[row]
      if i != 0
        numbers.delete(i)
      end
    end
    return numbers
  end

  def variants_col(array, col)
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    for i in array
      if i[col] != 0
        numbers.delete(i[col])
      end
    end
    return numbers
  end

  def variants_3x3(array, row, col)
    row3x3 = row.div 3
    col3x3 = col.div 3
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    for row_x in 0..2
      for col_y in 0..2
        if (array[row3x3*3+row_x][col3x3*3+col_y] != 0)
          numbers.delete(array[row3x3*3+row_x][col3x3*3+col_y])
        end
      end
    end
    return numbers
  end

  def valid_row(array, row)
    valid = []
    for i in array[row]
      if (not (valid.include? i)) or i == 0
        valid.push(i)
      else
        return false
      end
    end
    return true
  end

  def valid_col(array, col)
    valid = []
    for i in array
      if (not (valid.include? i[col])) or i[col] == 0
        valid.push(i[col])
      else
        return false
      end
    end
    return true
  end

  def valid_3x3(array)
    for col_count in 0..2
      for row_count in 0..2
        valid = []
        for x in 0..2
          for y in 0..2
            if (not (valid.include? array[col_count*3+y][row_count*3+x])) or array[col_count*3+y][row_count*3+x] == 0
              valid.push(array[col_count*3+y][row_count*3+x])
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
    puts("init start")
    @@end_array = init_array
    @@end_array = shuffle(@@end_array)
    @@start_array = []
    for row in @@end_array
      @@start_array.push(row.clone)
    end
    @@start_array = prepare_array(@@start_array, 27)
    @start_array = @@start_array
    puts("init finish")
    render 'index'
  end

  def ckeck()
    @user_sudoku = @@user_sudoku
    @end_array = @@end_array
    @start_array = @@start_array
    render 'ckeck'
  end

  def clear()
    @start_array = @@start_array
    render 'index'
  end

  def autofill()
    @start_array = @@end_array
    render 'index'
  end

  def enter()
    @@end_array = nil
    @@user_sudoku = nil
    @@start_array = Array.new(9, Array.new(9, 0))
    @start_array = @@start_array
    render 'index'
  end

  def usesudoku()
    if(params[:commit] == 'Check')
      @@user_sudoku = []
      for row in @@start_array
        @@user_sudoku.push(row.clone)
      end
      for row in 0..8
        for col in 0..8
          if(@@user_sudoku[row][col] == 0)
            @@user_sudoku[row][col] = params['sudoku'+row.to_s+col.to_s].to_i
          end
        end
      end
      if(@@end_array != nil)
        @user_sudoku = @@user_sudoku
        @end_array = @@end_array
        redirect_to ckeck_path
      else
        @@end_array = Array.new(9, Array.new(9, -1))
        for row in 0..8
          for col in 0..8
            if(valid_row(@@user_sudoku, row) and valid_col(@@user_sudoku, col) and valid_3x3(@@user_sudoku))
              @@end_array[row][col] = @@user_sudoku[row][col]
            end
          end
        end
        redirect_to ckeck_path
      end
    elsif (params[:commit] == 'Clear')
      redirect_to clear_path
    elsif (params[:commit] == 'Fill')
      redirect_to index_path
    elsif (params[:commit] == 'AutoFill')
      if(@@end_array != nil)
        redirect_to autofill_path
      else
        @@user_sudoku = []
        for row in @@start_array
          @@user_sudoku.push(row.clone)
        end
        for row in 0..8
          for col in 0..8
            if(@@user_sudoku[row][col] == 0)
              @@user_sudoku[row][col] = params['sudoku'+row.to_s+col.to_s].to_i
            end
          end
        end
        @@end_array = []
        for row in @@user_sudoku
          @@end_array.push(row.clone)
        end
        for row in 0..8
          for col in 0..8
            if (@@user_sudoku[row][col] == 0)
              numbers = variants_all(@@user_sudoku, row, col)
              @@end_array[row][col] = numbers.sample
            end
          end
        end
        redirect_to autofill_path
      end
    elsif (params[:commit] == 'Enter')
      redirect_to enter_path
    end
  end

end
