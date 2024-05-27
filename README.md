# Membrane H264 Decoder RGB

Membrane Bins used to decode h264 to RGB raw video and back. Created for use in AI project.

Repo consists of two Membrane Bins:
 - Membrane.H264_RGB.Decoder - decodes H264 into raw video and converts into RGB pixel format.
 - Membrane.H264_RGB.Encoder - encodes raw video into I420 H264 (suitable for playback through membrane_kino_plugin)

It's a part of the [Membrane Framework](https://membrane.stream).

## Installation

The package can be installed by adding `membrane_h264_rgb_plugin` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:membrane_h264_rgb_plugin, github: "membraneframework-labs/membrane_h264_rgb_plugin", tag: "v0.1.0"}
  ]
end
```

## Usage

For usage example, see examples folder.
