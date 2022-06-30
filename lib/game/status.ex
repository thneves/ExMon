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
end
