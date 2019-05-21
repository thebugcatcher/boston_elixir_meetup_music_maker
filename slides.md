---
title: Elixir Mob Programming; The Music Maker App
author: Adi Iyengar
patat:
    incrementalLists: true
    theme:
        emph: [vividWhite, onVividBlack, bold]
        imageTarget: [onDullWhite, vividRed]
...

# TITLE
```
Music Maker App using ALSA's APlay
```

# PRELUDE

- The Goal is to write an app that provides a simple DSL to compose music while writing Elixir.

- No instruments, simple music based on a cli command

- We will of course try to follow TDD (as much as possible)

# CLI Command

- `aplay` binary provided by ALSA
- Command:
    * `echo 'foo' |  awk '{ for (i = 0; i < 0.75; i+= 0.00003125) printf("%08X\n", 50*sin(440*3.14*exp((a[$1 % 8]/12)*log(2))*i)) }' | xxd -r -p | aplay -c 2 -f S32_LE -r 28000`
    * `440` is the base frequency
    * `3.14` -> pi
    * `0.75` is the duration
    * `50` is the volume

# DSL

- The DSL should look something like this:

```elixir
defmodule DoReMi do
  @moduledoc false
  import MusicMaker.DSL

  sequence :intro do
    note :c, 4, duration: 0.5
    note :d, 4, duration: 0.5
    # This is equivalent to no note...
    note :rest, 0, duration: 0.5
    note :e, 4, duration: 0.5
  end

  sequence :break do
    # Default duration is 1.0
    note :rest, 0
  end

  sequence :outro do
    note :c, 4, modifier: :sharp, duration: 0.5
    note :d, 4, modifier: :sharp, duration: 0.5
  end

  def play do
    play [intro, break, outro]
  end
end
```

# TASKS

- New mix project
- Write a wrapper around the CLI
- Write an abstraction around notes
- Write a way to interact with the CLI in terms of humanized notes
    - Write a note to frequency converter
- Write a DSL to compose music

# FINAL TEST

- Try out the Super cool track in the `README.md`
