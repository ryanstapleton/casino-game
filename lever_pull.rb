require_relative "slot_interface.rb"
require_relative "slots_helper.rb"

@hash_map = {
  1 => :cherry,
  2 => :apple,
  3 => :banana,
  4 => :grapes,
  5 => :pear,
  6 => :watermellon,
  7 => :seven,
  8 => :bar
}

def pull_the_lever
  25.times do
    spin 0.05
    system "clear"
  end

  15.times do
    spin 0.1
    system "clear"
  end

  6.times do
    spin 0.3
    system "clear"
  end

  1.times do
    spin
  end
end

def spin wait = 0

  @current_spin.again

  puts @slot_hash[:slot_top_border]
  8.times do |line|
    puts "==  " + @slot_hash[@hash_map[@current_spin.results[0]]][line] + "|" + @slot_hash[@hash_map[@current_spin.results[1]]][line] + "|" + @slot_hash[@hash_map[@current_spin.results[2]]][line] + "==" + @slot_hash[:top_row][line]
  end
  puts "==  " + "-"*63 + "  =="
  8.times do |line|
    puts "==  " + @slot_hash[@hash_map[@current_spin.results[3]]][line] + "|" + @slot_hash[@hash_map[@current_spin.results[4]]][line] + "|" + @slot_hash[@hash_map[@current_spin.results[5]]][line] + "==" + @slot_hash[:middle_row][line]
  end
  puts "==  " + "-"*63 + "  =="
  8.times do |line|
    puts "==  " + @slot_hash[@hash_map[@current_spin.results[6]]][line] + "|" + @slot_hash[@hash_map[@current_spin.results[7]]][line] + "|" + @slot_hash[@hash_map[@current_spin.results[8]]][line] + "==" + @slot_hash[:bottom_row][line]
  end
  puts @slot_hash[:slot_bottom_border]
  append_user_choices

  sleep(wait) 
end