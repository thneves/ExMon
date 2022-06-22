defmodule ExMon.Game do
  use Agent

  def start(pc, player) do
    initial_value = %{computer: pc, player: player, turn: :player, status: :started }
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end
end
