## Elixir Meetup 05/21/2019, Mob Programming: Music Maker DSL

__NOTE: To run the slides, install `patat` and run `$ patat slides.md`__

In this session we will all group together to write an elixir app that provides
a music maker DSL using which one could compose music:

```elixir
defmodule DoReMi do
  @moduledoc false
  import MusicMaker.DSL

  sequence :intro do
    note :c, 4, duration: 0.5
    note :d, 4, duration: 0.5
    note :e, 4, duration: 0.5
    note :f, 4, duration: 0.5
    # This is equivalent to no note...
    note :rest, 0, duration: 0.5
    note :g, 4, duration: 0.5
    note :a, 4, duration: 0.5
    note :b, 4, duration: 0.5
    note :c, 5, duration: 0.5
  end

  sequence :break do
    # Default duration is 1.0
    note :rest, 0
  end

  sequence :outro do
    note :c, 4, modifier: :sharp, duration: 0.5
    note :d, 4, modifier: :sharp, duration: 0.5
    note :e, 4, duration: 0.5
    note :f, 4, modifier: :sharp, duration: 0.5
    # This is equivalent to no note...
    note :rest, 0, duration: 0.5
    note :g, 4, modifier: :sharp, duration: 0.5
    note :a, 4, modifier: :sharp, duration: 0.5
    note :b, 4, modifier: :sharp, duration: 0.5
    note :c, 5, modifier: :sharp, duration: 0.5
  end

  def play do
    play [intro, break, outro]
  end
end
```

## Requirements

- No instruments
- Use `aplay` to play `.wav` data
  * Use this command:
    - `echo 'foo' |  awk '{ for (i = 0; i < 0.75; i+= 0.00003125) printf("%08X\n", 50*sin(440*3.14*exp((a[$1 % 8]/12)*log(2))*i)) }' | xxd -r -p | aplay -c 2 -f S32_LE -r 28000`
    - `440` is the base frequency
    - `0.75` is the duration
    - `50` is the volume
- TDD!


## Tasks

- [ ] New mix project
- [ ] Write a wrapper around the CLI
- [ ] Write an abstraction around notes
- [ ] Write a way to interact with the CLI in terms of humanized notes
    - [ ] Write a note to frequency converter
- [ ] Write a DSL to compose music
- [ ] Maybe Publish to Hex.Pm!

## Test Play

```elixir
defmodule SomethingReallyCool do
  @moduledoc """
  This is an awesome music track!
  """
  import MusicMaker.DSL

  sequence :intro do
    note :e, 4, duration: 0.1
    note :e, 4, duration: 0.1
    note :rest, 0, duration: 0.1
    note :e, 4, duration: 0.1, volume: 75
    note :rest, 0, duration: 0.1
    note :c, 4, duration: 0.1
    note :e, 4, duration: 0.1
    note :rest, 0, duration: 0.1
    note :g, 4, duration: 0.2
    note :rest, 0, duration: 0.2
    note :g, 3, duration: 0.2
  end

  sequence :break8 do
    note :rest, 0, duration: 0.8
  end

  sequence :break4 do
    note :rest, 0, duration: 0.4
  end

  sequence :second do
    note :c, 4, duration: 0.1
    note :rest, 0, duration: 0.4
    note :g, 3, duration: 0.1
    note :rest, 0, duration: 0.4
    note :e, 3, duration: 0.1
    note :rest, 0, duration: 0.4
    note :a, 3, duration: 0.1
    note :rest, 0, duration: 0.2
    note :b, 3, duration: 0.1
    note :rest, 0, duration: 0.1
    note :a, 3, modifier: :sharp, duration: 0.1
    note :a, 3, duration: 0.1
    note :rest, 0, duration: 0.2
    note :g, 3, duration: 0.1
    note :e, 4, duration: 0.1
    note :rest, 0, duration: 0.1
    note :g, 4, duration: 0.1
    note :a, 4, duration: 0.1
    note :rest, 0, duration: 0.1
    note :f, 4, duration: 0.1
    note :g, 4, duration: 0.1
    note :rest, 0, duration: 0.1
    note :e, 4, duration: 0.1
    note :c, 4, duration: 0.1
    note :rest, 0, duration: 0.1
    note :d, 4, duration: 0.1
    note :b, 3, duration: 0.1
  end

  sequence :third do
    note :g, 4, duration: 0.1
    note :f, 4, modifier: :sharp, duration: 0.1
    note :f, 4, duration: 0.1
    note :d, 4, modifier: :sharp, duration: 0.1
    note :e, 4, duration: 0.2
    note :rest, 0, duration: 0.2
    note :a, 3, duration: 0.1
    note :a, 3, duration: 0.1
    note :c, 4, duration: 0.1
    note :rest, 0, duration: 0.1
    note :a, 3, duration: 0.1
    note :c, 4, duration: 0.1
    note :d, 4, duration: 0.1
  end

  sequence :fourth do
    note :g, 4, duration: 0.1
    note :f, 4, modifier: :sharp, duration: 0.1
    note :f, 4, duration: 0.1
    note :d, 4, modifier: :sharp, duration: 0.1
    note :e, 4, duration: 0.2
    note :rest, 0, duration: 0.2
    note :c, 5, duration: 0.1
    note :c, 5, duration: 0.1
    note :c, 5, duration: 0.1
  end

  sequence :fifth do
    note :d, 4, modifier: :sharp, duration: 0.2
    note :rest, 0, duration: 0.1
    note :d, 4, duration: 0.2
    note :rest, 0, duration: 0.1
    note :c, 4, duration: 0.2
  end

  sequence :sixth do
    note :c, 4, duration: 0.1
    note :c, 4, duration: 0.1
    note :rest, 0, duration: 0.1
    note :c, 4, duration: 0.1
    note :rest, 0, duration: 0.4
    note :d, 4, duration: 0.1
  end

  sequence :seventh do
    note :e, 4, duration: 0.1
    note :c, 4, duration: 0.1
    note :rest, 0, duration: 0.2
    note :a, 3, duration: 0.1
    note :g, 3, duration: 0.1
  end

  def play do
    play [intro,
          break8,
          second,
          break4,
          second,
          break8,
          third,
          break4,
          fourth,
          break8,
          third,
          break4,
          fifth,
          break8,
          sixth,
          seventh,
          break4,
          sixth,
          break8,
          break4,
          sixth,
          seventh,
          break4,
          intro]
  end
end
```
