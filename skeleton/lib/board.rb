class Board
  attr_accessor :cups, :name1, :name2

  def initialize(name1, name2)
    @cups = Array.new(14) { Array.new()}
    place_stones
    @name1 = name1
    @name2 = name2
  end

  def place_stones
    cups.each_with_index do |cup, idx|
      unless idx == 6 || idx == 13
        4.times { cup << :stone}
      end
    end
  end

  def valid_move?(start_pos)
    if start_pos < 0 || start_pos > 12
      raise "Invalid starting cup"
    elsif cups[start_pos].length == 0
      raise "Starting cup is empty"
    end

  end

  def make_move(start_pos, current_player_name)
    temp = cups[start_pos].dup
    cups[start_pos] = []
    current_pos = start_pos
    while temp.length > 0
      case current_pos
      when 0..4 #|| 6..11
        current_pos += 1
      when 5
        if current_player_name == name1
          current_pos += 1
        else
          current_pos = 7
        end
      when 6..11
        current_pos += 1
      when 12
        if current_player_name == name2
          current_pos += 1
        else
          current_pos = 0
        end
      when 13
        current_pos = 0
      end
      cups[current_pos] << temp.shift
    end
    render
    next_turn(current_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13
      return :prompt
    elsif cups[ending_cup_idx].length == 1
      return :switch 
    else
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    bottom = cups[0..5]
    top = cups[7..12]
    bottom.all? { |cup| cup.length == 0} || top.all? { |cup| cup.length == 0}

  end

  def winner
    store_1 = cups[6]
    store_2 = cups[13]
    if store_1.length == store_2.length
      return :draw
    elsif store_1.length > store_2.length
      return @name1
    elsif store_1.length < store_2.length
      return @name2
    end
  end
end
