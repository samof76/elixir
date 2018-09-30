defmodule TestStreams do
  def lines_lengths!(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1, "\n",""))
    |> Enum.map(&String.length(&1))
  end

  def longest_line_length!(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.map(&String.length(&1))
    |> Enum.max()
  end

  def longest_line!(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1,"\n", ""))
    |> Enum.max_by(&String.length(&1))
  end

  def words_per_line!(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1,"\n",""))
    |> Stream.map(&String.split(&1))
    |> Enum.map(&length(&1))
  end
end