defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Thales", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Thales", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)
      current_player = Game.turn

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotnik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Thales"
        },
        status: :started,
        turn: current_player
      }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "returns the game state updated"  do
      player = Player.build("Thales", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)
      current_player = Game.turn

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotnik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Thales"
        },
        status: :started,
        turn: current_player
      }

      assert Game.info() == expected_response

      new_state = %{
        computer: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotnik"
        },
        player: %Player{
          life: 90,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Thales"
        },
        status: :started,
        turn: :computer
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :player, status: :continue}

      assert expected_response == Game.info
    end
  end

  describe "player/0" do
    test "return player" do
      player = Player.build("Thales", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      assert Game.player == player
    end
  end

  describe "turn/0" do
    test "return game turn" do
      player = Player.build("Thales", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      current_player = Game.turn

      assert Game.turn == current_player
    end
  end

  describe "fetch_current_player/1" do
    test "returns current player" do
      player = Player.build("Thales", :chute, :soco, :cura)
      computer = Player.build("Robotnik", :chute, :soco, :cura)

      Game.start(computer, player)

      assert Game.fetch_current_player(:player) == player
      assert Game.fetch_current_player(:computer) == computer
    end
  end
end
