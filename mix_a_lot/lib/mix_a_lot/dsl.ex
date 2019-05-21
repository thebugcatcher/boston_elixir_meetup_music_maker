defmodule MixALot.DSL do
  @moduledoc """
  Provides a DSL to compose music!!!!
  """

  @doc """
  Creates a sequence of notes and defines a function to access it.

  ## Examples

      iex> defmodule TestSequence do
      ...>   import MixALot.DSL
      ...>   sequence :test do
      ...>   end
      ...> end
      iex> TestSequence.test()
      []

      iex> defmodule TestSequence do
      ...>   import MixALot.DSL
      ...>   sequence :test do
      ...>     note :e, 4, duration: 0.5
      ...>     note :f, 4, modifier: :sharp, duration: 0.5
      ...>     note :rest, 0, duration: 0.5
      ...>   end
      ...> end
      iex> TestSequence.test()
      [
        %MixALot.Note{type: :e, octet: 4, modifier: nil, duration: 0.5, volume: 100},
        %MixALot.Note{type: :f, octet: 4, modifier: :sharp, duration: 0.5, volume: 100},
        %MixALot.Note{type: :rest, octet: 0, modifier: nil, duration: 0.5, volume: 100},
      ]
  """
  defmacro sequence(name, do: block) do
    quote do
      def unquote(name)() do
        {:ok, var!(pid)} = begin_sequence()
        unquote(block)
        notes = get_notes(var!(pid))
        stop_sequence(var!(pid))
        notes
      end
    end
  end

  defmacro note(type, octet, options \\ []) do
    quote location: :keep do
      keyword =
        Keyword.merge(defaults(), unquote(options) ++ [type: unquote(type), octet: unquote(octet)])
      note = struct!(MixALot.Note, keyword)
      add_note(var!(pid), note)
    end
  end

  def play(sequences) do
    sequences
    |> List.flatten()
    |> Enum.each(&MixALot.NotePlayer.play_note/1)
  end

  def defaults do
    [
      duration: 1.0,
      volume: 100,
      modifier: nil
    ]
  end

  def begin_sequence, do: Agent.start_link(fn -> [] end)
  def add_note(pid, note), do: Agent.update(pid, &[note | &1])
  def get_notes(pid), do: Agent.get(pid, &Enum.reverse(&1))
  def stop_sequence(pid), do: Agent.stop(pid)
end
