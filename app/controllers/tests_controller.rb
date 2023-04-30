class TestsController < ApplicationController
  def index()
    @start_array = Array.new(9){Array.new(9, 0)}
    @end_array = Array.new(9){Array.new(9, 1)}
    @current_array = Array.new(9){Array.new(9, 0)}
    render 'index'
  end

  def update
    sudoku_params = params[:sudoku]

    # Check if any cell was modified
    is_changed = false
    sudoku_params.each do |row|
      row.each do |value|
        if value != "0"
          is_changed = true
          break
        end
      end
      break if is_changed
    end

    # Remove all zero values if any cell was modified
    if is_changed
      sudoku_params.each do |row|
        row.each_with_index do |value, index|
          row[index] = "" if value == "0"
        end
      end
    end

    # Render the view again
    @start_array = sudoku_params.map { |row| row.map(&:to_i) }
    render :index
  end
end

