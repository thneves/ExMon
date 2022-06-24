defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_status_message() do
    IO.puts("======= The game has started! ======= \n" )
    IO.inspect(Game.info())
    IO.puts("-----------------------------------------")
  end
end
