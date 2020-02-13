inputs = ["./input/a_example.in", "./input/b_small.in", "./input/c_medium.in", "./input/d_quite_big.in", "./input/e_also_big.in"]
inputs.each do |in|
  file_name = in.split("/")[2].split(".")[0]
  x = File.read(in).split("\n")

  max_slices = x[0].split(" ")[0].to_i
  max_types = x[0].split(" ")[1].to_i

  int_ara = x[1].split(" ").map { |i| i.to_i }

  length = int_ara.size - 1

  ara_collector = Array(Array(Int32)).new
  maximum_ara = 0

  length.downto(0) do |l|
    ara_counter = 0
    ara = Array(Int32).new
    l.downto(0).each do |i|
      break if ara.size >= max_types
      if int_ara[i] + ara_counter <= max_slices
        ara.unshift(i)
        ara_counter += int_ara[i]
      end
    end
    if ara_counter > maximum_ara && ara_counter <= max_slices
      maximum_ara = ara_counter
      ara_collector << ara
    end
  end

  ara_ara = ara_collector[-1]

  File.open("./results/#{file_name}.result", "w") do |f|
    f.puts ara_ara.size.to_s
    f.puts ara_ara.join(" ")
  end
end
