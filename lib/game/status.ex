defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_status_message() do
    IO.puts("======= The game has started! ======= \n" )
    IO.inspect(Game.info())
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
end
