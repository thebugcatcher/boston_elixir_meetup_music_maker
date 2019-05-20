## Elixir Meetup 05/21/2019, Mob Programming: Music Maker DSL

In this session we will all group together to write an elixir app that provides
a music maker DSL using which one could compose music:

```elixir
defmodule DoReMi do
  @moduledoc false
  import MusicMaker.DSL

  sequence :intro do
    note :c4, duration: 0.5
    note :d4, duration: 0.5
    note :e4, duration: 0.5
    note :f4, duration: 0.5
    # This is equivalent to no note...
    note :rest, duration: 0.5
    note :g4, duration: 0.5
    note :a4, duration: 0.5
    note :b4, duration: 0.5
    note :c5, duration: 0.5
  end

  sequence :break do
    # Default duration is 1.0
    note :rest
  end

  sequence :outro do
    note :c4, modifier: :sharp, duration: 0.5
    note :d4, modifier: :sharp, duration: 0.5
    note :e4, modifier: :sharp, duration: 0.5
    note :f4, modifier: :sharp, duration: 0.5
    # This is equivalent to no note...
    note :rest, duration: 0.5
    note :g4, modifier: :sharp, duration: 0.5
    note :a4, modifier: :sharp, duration: 0.5
    note :b4, modifier: :sharp, duration: 0.5
    note :c5, modifier: :sharp, duration: 0.5
  end

  play [intro, outro]
end
```

## Requirements

- No instruments
- Use `aplay` to play `.wav` data
  * Use this command:
    - `echo 'foo' |  awk '{ for (i = 0; i < 0.75; i+= 0.00003125) printf("%08X\n", 50*sin(440*3.14*exp((a[$1 % 8]/12)*log(2))*i)) }' | xxd -r -p | aplay -c 2 -f S32_LE -r 28000`
    - `440` is the base frequency
    - `3.14` -> pi
    - `0.75` is the duration
    - `50` is the volume
- TDD!


## Tasks

- [ ] New mix project (umbrella?)
- [ ] Write a wrapper around the CLI
- [ ] Write a way to interact with the CLI in terms of humanized notes
    - [ ] Write a note to frequency converter

## Test Play

```elixir
defmodule SomethingReallyCool do
  @moduledoc """
  This is an awesome music track!
  """
  import MusicMaker.DSL

  sequence :intro do
    note :e4, duration: 0.1
    note :e4, duration: 0.1
    note :rest, duration: 0.1
    note :e4, duration: 0.1, volume: 75
    note :rest, duration: 0.1
    note :c4, duration: 0.1
    note :e4, duration: 0.1
    note :rest, duration: 0.1
    note :g4, duration: 0.2
    note :rest, duration: 0.2
    note :g3, duration: 0.2
  end

  sequence :break8 do
    note :rest, duration: 0.8
  end

  sequence :break4 do
    note :rest, duration: 0.4
  end

  sequence :second do
    note :c4, duration: 0.1
    note :rest, duration: 0.4
    note :g3, duration: 0.1
    note :rest, duration: 0.4
    note :e3, duration: 0.1
    note :rest, duration: 0.4
    note :a3, duration: 0.1
    note :rest, duration: 0.2
    note :b3, duration: 0.1
    note :rest, duration: 0.1
    note :a3, modifier: :sharp, duration: 0.1
    note :a3, duration: 0.1
    note :rest, duration: 0.2
    note :g3, duration: 0.1
    note :e4, duration: 0.1
    note :rest, duration: 0.1
    note :g4, duration: 0.1
    note :a4, duration: 0.1
    note :rest, duration: 0.1
    note :f4, duration: 0.1
    note :g4, duration: 0.1
    note :rest, duration: 0.1
    note :e4, duration: 0.1
    note :c4, duration: 0.1
    note :rest, duration: 0.1
    note :d4, duration: 0.1
    note :b3, duration: 0.1
  end

  sequence :third do
    note :g4, duration: 0.1
    note :f4, modifier: :sharp, duration: 0.1
    note :f4, duration: 0.1
    note :d4, modifier: :sharp, duration: 0.1
    note :e4, duration: 0.2
    note :rest, duration: 0.2
    note :a3, duration: 0.1
    note :a3, duration: 0.1
    note :c4, duration: 0.1
    note :rest, duration: 0.1
    note :a3, duration: 0.1
    note :c4, duration: 0.1
    note :d4, duration: 0.1
  end

  sequence :fourth do
    note :g4, duration: 0.1
    note :f4, modifier: :sharp, duration: 0.1
    note :f4, duration: 0.1
    note :d4, modifier: :sharp, duration: 0.1
    note :e4, duration: 0.2
    note :rest, duration: 0.2
    note :c5, duration: 0.1
    note :c5, duration: 0.1
    note :c5, duration: 0.1
  end

  sequence :fifth do
    note :d4, modifier: :sharp, duration: 0.2
    note :rest, duration: 0.1
    note :d4, duration: 0.2
    note :rest, duration: 0.1
    note :c4, duration: 0.2
  end

  sequence :sixth do
    note :c4, duration: 0.1
    note :c4, duration: 0.1
    note :rest, duration: 0.1
    note :c4, duration: 0.1
    note :rest, duration: 0.4
    note :d4, duration: 0.1
  end

  sequence :seventh do
    note :e4, duration: 0.1
    note :c4, duration: 0.1
    note :rest, duration: 0.2
    note :a3, duration: 0.1
    note :g3, duration: 0.1
  end

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
```
