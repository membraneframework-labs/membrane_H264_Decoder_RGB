defmodule Membrane.H264_RGB.Encoder do
  @moduledoc """
  This bin takes RawVideo, converts pixel format to I420, and encodes as H264.
  """
  use Membrane.Bin

  alias Membrane.FFmpeg.SWScale.PixelFormatConverter, as: PixelFormatConverter
  alias Membrane.H264
  alias Membrane.RawVideo

  def_input_pad :input,
    accepted_format: RawVideo,
    availability: :always

  def_output_pad :output,
    accepted_format: H264,
    availability: :always

  @impl true
  def handle_init(_ctx, _options) do
    structure = [
      bin_input()
      |> child(:converter, %PixelFormatConverter{format: :I420})
      |> child(:encoder, %Membrane.H264.FFmpeg.Encoder{profile: :baseline})
      |> bin_output()
    ]

    {[spec: structure], %{}}
  end
end
