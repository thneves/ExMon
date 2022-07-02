defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message(%{status: :started} = info) do
    IO.puts("======= The game has started! ======= \n" )
    IO.inspect(info)
    IO.puts("-----------------------------------------")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("======= It's #{player} turn. ======= \n" )
    IO.inspect(info)
    IO.puts("-----------------------------------------")
  end

  def print_round_message(%{status: :game_over} = info) do
    IO.puts("======= the Game is Over ======= \n" )
    IO.inspect(info)
    IO.puts("-----------------------------------------")
  end

  def print_wrong_move_message(move) do
    IO.puts("========== #{move} is a invalid Move ========== \n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("========== Player attacked Computer dealing #{damage} damage ========== \n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("========== Computer attacked Player dealing #{damage} damage ========== \n")
  end

  def print_move_message(player, :heal, life) do
    IO.puts("========== The #{player } healed himself with #{life} points ========== \n")
  end
end
