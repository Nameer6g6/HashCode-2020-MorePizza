inputs = ["./input_files/a_example.in", "./input_files/b_small.in", "./input_files/c_medium.in", "./input_files/d_quite_big.in", "./input_files/e_also_big.in"]
inputs.each do |in|
  file_name = in.split("/")[2].split(".")[0]
  x = File.read(in).split("\n")

  max_slices = x[0].split(" ")[0].to_i
  max_types = x[0].split(" ")[1].to_i

  int_ara = x[1].split(" ").map { |i| i.to_i }

  length = int_ara.size - 1

  ara_collector = Array(Array(Int32)).new
  ara_indx_collector = Array(Array(Int32)).new
  maximum_ara = 0

  (0).upto(length) do |l|
    ara_upper_counter = 0
    ara = Array(Int32).new
    ara_indx = Array(Int32).new
    (length).downto(0).each do |i|
      next if l == i
      if ara_upper_counter + int_ara[i] <= max_slices && ara_upper_counter <= max_slices
        ara.unshift(int_ara[i])
        ara_indx.unshift(i)
        ara_upper_counter += int_ara[i]
      end
    end
    if ara_upper_counter <= max_slices
      ara_collector << ara
      ara_indx_collector << ara_indx
    end
  end

  ara = Array(Int32).new
  ara_index = 0
  ara_num = 0
  ara_collector.each.with_index do |v, i|
    if v.sum > ara_num && v.sum >= max_slices
      ara_index = i
      ara_num = v.sum
    end
  end

  ara_ara = ara_indx_collector[ara_index]

  File.open("./results/#{file_name}.result", "w") do |f|
    f.puts ara_ara.size.to_s
    f.puts ara_ara.join(" ")
  end
end
