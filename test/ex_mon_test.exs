defmodule ExMonTest do
  alias ExMon.Player
  alias ExMon.Game

  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "create_player/4" do
    test "returns new created player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Teste Player"
      }

      assert expected_response == ExMon.create_player("Teste Player", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "returns message after start" do
      player = Player.build("Thales", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game has started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup  do
      player = Player.build("Thales", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when move is valid, do move and make computer move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

        assert messages =~ "Player attacked Computer"
        assert messages =~ "It's computer turn"
        assert messages =~ "It's player turn"
        assert messages =~ "status: :continue"
    end

    test "when move is invalid" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:invalid_move)
        end)

        assert messages =~ "is a invalid Move"
    end

    test "when game is over" do

      state = %{
        computer: %Player{
          life: 0,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotnik"
        },
        player: %Player{
          life: 90,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Thales"
        },
        status: :started,
        turn: :player
      }

      messages =
        capture_io(fn ->
          ExMon.Game.update(state)
          ExMon.make_move(:chute)
        end)

      assert messages =~ "the Game is Over"
    end
  end
end
