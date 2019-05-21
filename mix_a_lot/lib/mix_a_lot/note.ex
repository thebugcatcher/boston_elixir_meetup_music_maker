defmodule MixALot.Note do
  @moduledoc """
  Abstraction around a note
  """

  @enforce_keys ~w(type octet volume duration)a
  @optional_keys ~w(modifier)a

  @a4 440
  @frequency_constant 1.059463

  defstruct @enforce_keys ++ @optional_keys

  @type types :: :c | :d | :e | :f | :g | :a | :b | :rest

  @type t :: %__MODULE__{
    type: types(),
    octet: Integer.t(),
    volume: Integer.t(),
    duration: Decimal.t(),
    modifier: :sharp | nil
  }

  @doc """
  Returns a frequency corresponding to a note

  ## Examples

  # When the note is of `rest` type:
      iex> note = %MixALot.Note{
      ...>   type: :rest,
      ...>   volume: 0,
      ...>   duration: 1.0,
      ...>   octet: 0
      ...> }
      iex> MixALot.Note.to_frequency(note)
      0

  # When the note is A4:
      iex> note = %MixALot.Note{
      ...>   type: :a,
      ...>   volume: 0,
      ...>   duration: 1.0,
      ...>   octet: 4
      ...> }
      iex> MixALot.Note.to_frequency(note)
      440

  # When the note is B1:
      iex> note = %MixALot.Note{
      ...>   type: :b,
      ...>   volume: 0,
      ...>   duration: 1.0,
      ...>   octet: 1
      ...> }
      iex> MixALot.Note.to_frequency(note)
      62

  # When the note is G8:
      iex> note = %MixALot.Note{
      ...>   type: :g,
      ...>   volume: 0,
      ...>   duration: 1.0,
      ...>   octet: 8
      ...> }
      iex> MixALot.Note.to_frequency(note)
      6272
  """
  @spec to_frequency(t()) :: Integer.t()
  def to_frequency(%__MODULE__{type: :rest}), do: 0
  def to_frequency(note) do
    (@a4 * :math.pow(@frequency_constant, steps_from_a4(note)))
    |> round()
  end

  defp steps_from_a4(%__MODULE__{type: t, octet: o, modifier: mod}) do
    12 * (o - 4) - (9 - Enum.find_index(semitones(), & &1 == {t, mod}))
  end

  defp semitones do
    [
      {:c, nil},
      {:c, :sharp},
      {:d, nil},
      {:d, :sharp},
      {:e, nil},
      {:f, nil},
      {:f, :sharp},
      {:g, nil},
      {:g, :sharp},
      {:a, nil}, # 9
      {:a, :sharp},
      {:b, nil}
    ]
  end
end
