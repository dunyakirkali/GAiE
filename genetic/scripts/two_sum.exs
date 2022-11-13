population = for _ <- 1..100, do: {Enum.random(0..2020), Enum.random(0..2020)}
IO.inspect(population)

evaluate = fn population ->
  Enum.sort_by(population, fn {l, r} ->
    abs(l + r - 2020)
  end, &<=/2)
end

# selection = fn population ->
#   population
#   |> Enum.chunk_every(2)
#   |> Enum.map(&List.to_tuple(&1))
# end

# mutation =
#   fn population ->
#     population
#     |> Enum.map(
#       fn chromosome ->
#         if :rand.uniform() < 0.05 do
#           Enum.shuffle(chromosome)
#         else
#           chromosome
#         end
#     end)
#   end

# crossover = fn population ->
#   Enum.reduce(population, [],
#     fn {p1, p2}, acc ->
#       cx_point = :rand.uniform(1000)
#       {{h1, t1}, {h2, t2}} =
#         {Enum.split(p1, cx_point),
#         Enum.split(p2, cx_point)}
#       [h1 ++ t2, h2 ++ t1 | acc]
#     end
#   )
# end

algorithm =
  fn population, algorithm ->
    {l, r} = Enum.min_by(population, fn {l, r} ->
      abs(l + r - 2020)
    end)
    IO.write("\rCurrent Best: {" <> Integer.to_string(l) <> ", " <> Integer.to_string(r) <> "}")

    if l + r == 2020 do
      {l, r}
    else
      population
      |> evaluate.()
      # |> selection.()
      # |> crossover.()
      # |> mutation.()
      |> algorithm.(algorithm)
    end
  end

solution = algorithm.(population, algorithm)
IO.write("\n Answer is \n")
IO.inspect solution
